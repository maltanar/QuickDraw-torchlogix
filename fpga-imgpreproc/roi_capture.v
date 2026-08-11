// roi_capture.v
//
// Sits between threshold_stream and capture_buffer.  It monitors the
// mono_axis pixel stream, captures a square camera-space ROI, nearest-
// neighbour downsamples it to 28×28, and – when triggered – streams the
// result back as ASCII '0'/'1' with a '\n' at the end of every row.
//
// Clock domains
// -------------
//   data_clk  – camera pixel clock (cam_PCLK), drives the capture write port
//   ctrl_clk  – 25 MHz system clock, drives the dump FSM and output stream
//
// ROI coordinate mapping (matches renderer.v / vga_scanout.v)
//   vga_x = cam_x
//   vga_y = cam_y
//
// Square ROI sizes in camera-pixel space (exact multiples of 28 → no
// fractional arithmetic needed for nearest-neighbour downsampling):
//
//   roi_size_sel  cam_half  cam size   NN step  VGA box (W×H)
//       0  (S)      14      28 × 28       1       28 × 28
//       1  (M)      28      56 × 56       2       56 × 56
//       2  (L)      56     112 × 112      4      112 × 112
//
// Buffer layout: address = cell_y * 28 + cell_x  (784 bits = 98 bytes)

module roi_capture #(
  parameter VFLIP = 1   // 1 = vertically flip rows when writing to buffer
) (
  // -------------------------------------------------------------------
  // Write side – camera pixel clock domain
  // -------------------------------------------------------------------
  input  wire       data_clk,
  input  wire       data_rst_n,

  // Mono stream input (data_clk domain)
  input  wire       s_valid,
  input  wire       s_pixel,
  input  wire       s_tlast,
  input  wire [9:0] s_x,
  input  wire [9:0] s_y,

  // Pass-through stream output (data_clk domain, wired straight through)
  output wire       m_valid,
  output wire       m_pixel,
  output wire       m_tlast,
  output wire [9:0] m_x,
  output wire [9:0] m_y,

  // -------------------------------------------------------------------
  // ROI configuration (quasi-static, from ctrl_clk domain)
  // -------------------------------------------------------------------
  input  wire [9:0] roi_cx,
  input  wire [8:0] roi_cy,
  input  wire [1:0] roi_size_sel,

  // -------------------------------------------------------------------
  // Control / dump side – ctrl_clk (25 MHz) domain
  // -------------------------------------------------------------------
  input  wire       ctrl_clk,
  input  wire       ctrl_rst_n,
  input  wire       dump,           // 1-cycle pulse: start a dump

  // ASCII dump output stream (ctrl_clk domain)
  output wire [783:0] roi_bits,
  output reg        dump_o_valid,
  output reg  [7:0] dump_o_byte,
  output reg        dump_o_last,    // asserted with the final '\n'
  input  wire       dump_o_ready    // backpressure: UART TX can accept a byte
);

  // =========================================================================
  // Pass-through
  // =========================================================================
  assign m_valid = s_valid;
  assign m_pixel = s_pixel;
  assign m_tlast = s_tlast;
  assign m_x     = s_x;
  assign m_y     = s_y;

  // =========================================================================
  // ROI boundary computation (combinational)
  // =========================================================================
  // Square ROI in 1:1 camera/VGA mapping.

  wire [6:0] cam_half =
    (roi_size_sel == 2'd0) ? 7'd14 :
    (roi_size_sel == 2'd1) ? 7'd28 : 7'd56;

  wire [9:0] cam_cx = roi_cx;
  wire [9:0] cam_cy = {1'b0, roi_cy};

  wire [9:0] roi_cam_x_min = cam_cx - {3'b000, cam_half};
  wire [9:0] roi_cam_x_max = cam_cx + {3'b000, cam_half} - 10'd1;
  wire [9:0] roi_cam_y_min = cam_cy - {3'b000, cam_half};
  wire [9:0] roi_cam_y_max = cam_cy + {3'b000, cam_half} - 10'd1;

  // =========================================================================
  // Nearest-neighbour capture – data_clk domain
  // =========================================================================
  wire pix_in_roi = s_valid
                  && (s_x >= roi_cam_x_min) && (s_x <= roi_cam_x_max)
                  && (s_y >= roi_cam_y_min) && (s_y <= roi_cam_y_max)
                  && (s_y < 10'd480);

  wire [9:0] rel_x = s_x - roi_cam_x_min;
  wire [9:0] rel_y = s_y - roi_cam_y_min;

  // Only sample at the top-left corner of each output cell.
  // S: every pixel (step=1), M: every 2nd (step=2), L: every 4th (step=4)
  wire pix_is_sample =
    (roi_size_sel == 2'd0) ? 1'b1 :
    (roi_size_sel == 2'd1) ? (rel_x[0] == 1'b0 && rel_y[0] == 1'b0) :
                             (rel_x[1:0] == 2'b00 && rel_y[1:0] == 2'b00);

  // Output cell coordinates (bit-select division by 1/2/4)
  wire [4:0] cell_x =
    (roi_size_sel == 2'd0) ? rel_x[4:0] :
    (roi_size_sel == 2'd1) ? rel_x[5:1] : rel_x[6:2];

  wire [4:0] cell_y =
    (roi_size_sel == 2'd0) ? rel_y[4:0] :
    (roi_size_sel == 2'd1) ? rel_y[5:1] : rel_y[6:2];

  // Buffer address: wr_cell_y * 28 + cell_x  (28 = 32 - 4)
  wire [4:0] wr_cell_y = VFLIP ? (5'd27 - cell_y) : cell_y;
  wire [9:0] wr_addr = ({5'd0, wr_cell_y} << 5)
                     - ({5'd0, wr_cell_y} << 2)
                     + {5'd0, cell_x};

  // 28×28 = 784-bit output buffer (98 bytes × 8 bits).
  // Written from data_clk; read by the dump FSM on ctrl_clk.
  reg [7:0] roi_buf [97:0];

  // Clear the buffer at frame end so stale ink does not persist.
  reg [6:0] clear_cnt;
  reg       clearing;

  always @(posedge data_clk or negedge data_rst_n) begin
    if (!data_rst_n) begin
      clearing  <= 1'b1;
      clear_cnt <= 7'd0;
    end else if (clearing) begin
      roi_buf[clear_cnt] <= 8'd0;
      if (clear_cnt == 7'd97) begin
        clearing  <= 1'b0;
        clear_cnt <= 7'd0;
      end else begin
        clear_cnt <= clear_cnt + 7'd1;
      end
    end else begin
      if (s_valid && s_tlast) begin
        clearing  <= 1'b1;
        clear_cnt <= 7'd0;
      end
      if (pix_in_roi && pix_is_sample)
        roi_buf[wr_addr >> 3][wr_addr & 7] <= s_pixel;
    end
  end

  // =========================================================================
  // Dump FSM – ctrl_clk domain
  // =========================================================================
  //
  // Always dumps a 28×28 grid, regardless of original ROI size (S/M/L)
  // Incoming pixels are downsampled via OR-reduction during capture.
  //
  // State machine
  //   IDLE        – wait for dump pulse
  //   SEND_PIXEL  – output ASCII '0' or '1', wait for ready (holds output high)
  //   SEND_NL     – output '\n' at end of each row, wait for ready

  localparam DUMP_IDLE       = 2'd0;
  localparam DUMP_SEND_PIXEL = 2'd1;
  localparam DUMP_SEND_NL    = 2'd2;

  reg [1:0]  dump_state;
  reg [4:0]  dump_row_cnt;
  reg [4:0]  dump_col_cnt;

  // Registered buffer reads (ctrl_clk domain) with pipelining
  wire [9:0] rd_addr_w = ({5'd0, dump_row_cnt} << 5) - ({5'd0, dump_row_cnt} << 2) + {5'd0, dump_col_cnt};
  wire [9:0] rd_byte_addr = rd_addr_w >> 3;
  wire [2:0] rd_bit_addr = rd_addr_w[2:0];

  reg rd_data_0, rd_data_1;  // pipeline delay for BRAM read
  always @(posedge ctrl_clk) begin
    rd_data_0 <= roi_buf[rd_byte_addr][rd_bit_addr];
    rd_data_1 <= rd_data_0;
  end

  genvar g_roi_bit;
  generate
    for (g_roi_bit = 0; g_roi_bit < 784; g_roi_bit = g_roi_bit + 1) begin : gen_roi_bits
      assign roi_bits[g_roi_bit] = roi_buf[g_roi_bit >> 3][g_roi_bit[2:0]];
    end
  endgenerate

  always @(posedge ctrl_clk or negedge ctrl_rst_n) begin
    if (!ctrl_rst_n) begin
      dump_state      <= DUMP_IDLE;
      dump_row_cnt    <= 5'd0;
      dump_col_cnt    <= 5'd0;
      dump_o_valid    <= 1'b0;
      dump_o_byte     <= 8'd0;
      dump_o_last     <= 1'b0;
    end else begin
      case (dump_state)

        // -----------------------------------------------------------------
        DUMP_IDLE: begin
          dump_o_valid <= 1'b0;
          dump_o_last  <= 1'b0;
          if (dump) begin
            dump_row_cnt <= 5'd0;
            dump_col_cnt <= 5'd0;
            dump_state   <= DUMP_SEND_PIXEL;
          end
        end

        // -----------------------------------------------------------------
        DUMP_SEND_PIXEL: begin
          dump_o_valid <= 1'b1;
          dump_o_byte  <= rd_data_1 ? 8'h31 : 8'h30;   // '1' or '0'
          dump_o_last  <= 1'b0;
          if (dump_o_ready) begin
            // Transfer accepted – advance to next pixel or end-of-row.
            if (dump_col_cnt == 5'd27) begin
              dump_col_cnt <= 5'd0;
              dump_state   <= DUMP_SEND_NL;
            end else begin
              dump_col_cnt <= dump_col_cnt + 5'd1;
            end
          end
        end

        // -----------------------------------------------------------------
        DUMP_SEND_NL: begin
          dump_o_valid <= 1'b1;
          dump_o_byte  <= 8'h0A;   // '\n'
          dump_o_last  <= (dump_row_cnt == 5'd27);
          if (dump_o_ready) begin
            if (dump_row_cnt == 5'd27) begin
              dump_state <= DUMP_IDLE;           // all done
            end else begin
              dump_row_cnt <= dump_row_cnt + 5'd1;
              dump_state   <= DUMP_SEND_PIXEL;
            end
          end
        end

        default: begin
          dump_state <= DUMP_IDLE;
        end
      endcase
    end
  end

endmodule
