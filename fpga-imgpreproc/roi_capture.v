// roi_capture.v
//
// Sits between threshold_stream and capture_buffer.  It monitors the
// mono_axis pixel stream, stores every pixel that falls inside the current
// ROI into an internal 240×240-bit buffer, and – when triggered – streams
// the buffer back as ASCII '0'/'1' characters with a '\n' at the end of
// every row.
//
// Clock domains
// -------------
//   data_clk  – camera pixel clock (cam_PCLK), drives the capture write port
//   ctrl_clk  – 25 MHz system clock, drives the dump FSM and output stream
//
// ROI coordinate mapping (matches renderer.v)
//   vga_x = cam_x * 4        =>  cam_x = vga_x >> 2
//   vga_y = (255-cam_y) * 2  =>  cam_y = 255 - (vga_y >> 1)
//
// Buffer layout:  address = rel_y * 240 + rel_x
// Maximum ROI (large, rect_half=240): 120 cols × 240 rows  → fits in 240×240

module roi_capture (
  // -------------------------------------------------------------------
  // Write side – camera pixel clock domain
  // -------------------------------------------------------------------
  input  wire       data_clk,
  input  wire       data_rst_n,

  // Mono stream input (data_clk domain)
  input  wire       s_valid,
  input  wire       s_pixel,
  input  wire       s_tlast,
  input  wire [7:0] s_x,
  input  wire [7:0] s_y,

  // Pass-through stream output (data_clk domain, wired straight through)
  output wire       m_valid,
  output wire       m_pixel,
  output wire       m_tlast,
  output wire [7:0] m_x,
  output wire [7:0] m_y,

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
  wire [9:0] rect_half =
    (roi_size_sel == 2'd0) ? 10'd60  :
    (roi_size_sel == 2'd1) ? 10'd120 : 10'd240;

  // VGA-space boundaries
  wire [9:0] roi_left_vga   = roi_cx - rect_half;
  wire [9:0] roi_right_vga  = roi_cx + rect_half - 10'd1;
  wire [8:0] roi_top_vga    = roi_cy - rect_half[8:0];
  wire [8:0] roi_bottom_vga = roi_cy + rect_half[8:0] - 9'd1;

  // Camera-pixel-space boundaries derived from VGA bounds
  wire [7:0] roi_cam_x_min = roi_left_vga[9:2];
  wire [7:0] roi_cam_x_max = roi_right_vga[9:2];
  wire [7:0] roi_cam_y_min = 8'd255 - roi_bottom_vga[8:1];
  wire [7:0] roi_cam_y_max = 8'd255 - roi_top_vga[8:1];

  // =========================================================================
  // Capture logic – data_clk domain
  // =========================================================================
  wire pix_in_roi = s_valid
                  && (s_x >= roi_cam_x_min) && (s_x <= roi_cam_x_max)
                  && (s_y >= roi_cam_y_min) && (s_y <= roi_cam_y_max);

  wire [7:0] rel_x = s_x - roi_cam_x_min;
  wire [7:0] rel_y = s_y - roi_cam_y_min;

  // Buffer address: rel_y * 240 + rel_x   (240 = 256 - 16)
  wire [15:0] wr_addr = ({8'd0, rel_y} << 8)
                      - ({8'd0, rel_y} << 4)
                      + {8'd0, rel_x};

  // 240×240 = 57,600-bit capture buffer (7200 bytes × 8 bits)
  // Written from data_clk; read from ctrl_clk
  reg [7:0] roi_buf [7199:0];

  always @(posedge data_clk) begin
    if (pix_in_roi) begin
      roi_buf[wr_addr >> 3][wr_addr & 7] <= s_pixel;
    end
  end

  // =========================================================================
  // Dump FSM – ctrl_clk domain
  // =========================================================================
  //
  // ROI dimensions in camera pixels:
  //   size 0 (small):  cols = 30,  rows = 60
  //   size 1 (medium): cols = 60,  rows = 120
  //   size 2 (large):  cols = 120, rows = 240
  //
  // State machine
  //   IDLE        – wait for dump pulse
  //   SEND_PIXEL  – output ASCII '0' or '1', wait for ready (holds output high)
  //   SEND_NL     – output '\n' at end of each row, wait for ready

  localparam DUMP_IDLE       = 2'd0;
  localparam DUMP_SEND_PIXEL = 2'd1;
  localparam DUMP_SEND_NL    = 2'd2;

  reg [1:0]  dump_state;
  reg [7:0]  dump_row_cnt;
  reg [7:0]  dump_col_cnt;
  reg [7:0]  dump_total_rows;   // latched when dump starts
  reg [7:0]  dump_total_cols;

  // Registered buffer reads (ctrl_clk domain) with pipelining
  wire [15:0] rd_addr_w = ({8'd0, dump_row_cnt} << 8)
                        - ({8'd0, dump_row_cnt} << 4)
                        + {8'd0, dump_col_cnt};
  wire [15:0] rd_byte_addr = rd_addr_w >> 3;
  wire [2:0] rd_bit_addr = rd_addr_w[2:0];

  reg rd_data_0, rd_data_1;  // pipeline delay for BRAM read
  always @(posedge ctrl_clk) begin
    rd_data_0 <= roi_buf[rd_byte_addr][rd_bit_addr];
    rd_data_1 <= rd_data_0;
  end

  always @(posedge ctrl_clk or negedge ctrl_rst_n) begin
    if (!ctrl_rst_n) begin
      dump_state      <= DUMP_IDLE;
      dump_row_cnt    <= 8'd0;
      dump_col_cnt    <= 8'd0;
      dump_total_rows <= 8'd0;
      dump_total_cols <= 8'd0;
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
            dump_row_cnt    <= 8'd0;
            dump_col_cnt    <= 8'd0;
            dump_total_rows <= (roi_size_sel == 2'd0) ? 8'd60  :
                               (roi_size_sel == 2'd1) ? 8'd120 : 8'd240;
            dump_total_cols <= (roi_size_sel == 2'd0) ? 8'd30  :
                               (roi_size_sel == 2'd1) ? 8'd60  : 8'd120;
            dump_state      <= DUMP_SEND_PIXEL;
          end
        end

        // -----------------------------------------------------------------
        DUMP_SEND_PIXEL: begin
          dump_o_valid <= 1'b1;
          dump_o_byte  <= rd_data_1 ? 8'h31 : 8'h30;   // '1' or '0'
          dump_o_last  <= 1'b0;
          if (dump_o_ready) begin
            // Transfer accepted – advance to next pixel or end-of-row.
            if (dump_col_cnt == dump_total_cols - 8'd1) begin
              dump_col_cnt <= 8'd0;
              dump_state   <= DUMP_SEND_NL;
            end else begin
              dump_col_cnt <= dump_col_cnt + 8'd1;
            end
          end
        end

        // -----------------------------------------------------------------
        DUMP_SEND_NL: begin
          dump_o_valid <= 1'b1;
          dump_o_byte  <= 8'h0A;   // '\n'
          dump_o_last  <= (dump_row_cnt == dump_total_rows - 8'd1);
          if (dump_o_ready) begin
            if (dump_row_cnt == dump_total_rows - 8'd1) begin
              dump_state <= DUMP_IDLE;           // all done
            end else begin
              dump_row_cnt <= dump_row_cnt + 8'd1;
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
