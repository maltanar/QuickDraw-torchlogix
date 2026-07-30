module control_uart (
  input  wire       clk,
  input  wire       rst_n,
  input  wire       rx_i,
  output wire       tx_o,

  output reg        threshold_wr,
  output reg [3:0]  threshold_wdata,
  output reg [1:0]  roi_size_sel,
  output reg [9:0]  roi_cx,
  output reg [8:0]  roi_cy,
  output reg [3:0]  label_idx,

  output reg        roi_dump,          // 1-cycle pulse: trigger ROI buffer dump
  input  wire       roi_dump_o_valid,  // roi_capture has a byte ready
  input  wire [7:0] roi_dump_o_byte,   // ASCII byte from roi_capture
  input  wire       roi_dump_o_last,   // last byte of the dump
  output wire       roi_dump_o_ready   // we can accept a byte
);

  localparam [9:0] VGA_W = 10'd640;
  localparam [8:0] VGA_H = 9'd480;
  localparam [9:0] MOVE_STEP_X = 10'd4;
  localparam [8:0] MOVE_STEP_Y = 9'd4;

  // Asymmetric VGA half-extents for square camera-pixel ROI
  // (vga_half_x = cam_half*4,  vga_half_y = cam_half*2)
  wire [9:0] rect_half_x =
    (roi_size_sel == 2'd0) ? 10'd56  :
    (roi_size_sel == 2'd1) ? 10'd112 : 10'd224;
  wire [8:0] rect_half_y =
    (roi_size_sel == 2'd0) ? 9'd28 :
    (roi_size_sel == 2'd1) ? 9'd56  : 9'd112;

  wire [9:0] rect_cx_min = rect_half_x;
  wire [9:0] rect_cx_max = VGA_W - rect_half_x;
  wire [8:0] rect_cy_min = rect_half_y;
  wire [8:0] rect_cy_max = VGA_H - rect_half_y;

  wire [7:0] uart_rx_data;
  wire uart_rx_valid;
  wire uart_tx_busy;
  wire [7:0] uart_tx_din;
  wire uart_tx_wr;

  reg uart_send_active;
  reg [4:0] uart_msg_idx;
  reg [1:0] uart_esc_state;
  reg       dump_mode;

  // Format: "T:X X:XXX Y:XXX S:X\n" (hex values, 20 bytes)
  function [7:0] hex_char;
    input [3:0] nibble;
    begin
      hex_char = (nibble < 4'd10) ? (8'h30 + {4'h0, nibble}) : (8'h37 + {4'h0, nibble});
    end
  endfunction

  wire [7:0] tx_size_char =
    (roi_size_sel == 2'd0) ? 8'h53 :  // 'S'
    (roi_size_sel == 2'd1) ? 8'h4D :  // 'M'
                             8'h4C;   // 'L'

  assign uart_tx_din =
    dump_mode             ? roi_dump_o_byte :                  // ROI dump byte
    (uart_msg_idx == 5'd0)  ? 8'h54 :                          // 'T'
    (uart_msg_idx == 5'd1)  ? 8'h3A :                          // ':'
    (uart_msg_idx == 5'd2)  ? hex_char(threshold_wdata) :      // threshold hex
    (uart_msg_idx == 5'd3)  ? 8'h20 :                          // ' '
    (uart_msg_idx == 5'd4)  ? 8'h58 :                          // 'X'
    (uart_msg_idx == 5'd5)  ? 8'h3A :                          // ':'
    (uart_msg_idx == 5'd6)  ? hex_char({2'b00, roi_cx[9:8]}) : // cx high nibble
    (uart_msg_idx == 5'd7)  ? hex_char(roi_cx[7:4]) :          // cx mid nibble
    (uart_msg_idx == 5'd8)  ? hex_char(roi_cx[3:0]) :          // cx low nibble
    (uart_msg_idx == 5'd9)  ? 8'h20 :                          // ' '
    (uart_msg_idx == 5'd10) ? 8'h59 :                          // 'Y'
    (uart_msg_idx == 5'd11) ? 8'h3A :                          // ':'
    (uart_msg_idx == 5'd12) ? hex_char({3'b000, roi_cy[8]}) :  // cy high nibble
    (uart_msg_idx == 5'd13) ? hex_char(roi_cy[7:4]) :          // cy mid nibble
    (uart_msg_idx == 5'd14) ? hex_char(roi_cy[3:0]) :          // cy low nibble
    (uart_msg_idx == 5'd15) ? 8'h20 :                          // ' '
    (uart_msg_idx == 5'd16) ? 8'h53 :                          // 'S'
    (uart_msg_idx == 5'd17) ? 8'h3A :                          // ':'
    (uart_msg_idx == 5'd18) ? tx_size_char :                   // size char
                              8'h0A;                           // '\n'

  // dump takes priority; suppress status TX while dumping
  assign roi_dump_o_ready = dump_mode && !uart_tx_busy;
  assign uart_tx_wr = !uart_tx_busy &&
                      (dump_mode ? roi_dump_o_valid : uart_send_active);

  uart_rx #(
    .CLK_FREQ(25000000),
    .BAUD_RATE(115200)
  ) uart_rx_i (
    .clk(clk),
    .rst_n(rst_n),
    .rx(rx_i),
    .data(uart_rx_data),
    .valid(uart_rx_valid)
  );

  uart_tx #(
    .CLK_FREQ(25000000),
    .BAUD_RATE(115200)
  ) uart_tx_i (
    .clk(clk),
    .rst_n(rst_n),
    .din(uart_tx_din),
    .wr(uart_tx_wr),
    .busy(uart_tx_busy),
    .tx(tx_o)
  );

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      uart_send_active <= 1'b0;
      uart_msg_idx <= 5'd0;
      threshold_wr <= 1'b0;
      threshold_wdata <= 4'd7;
      uart_esc_state <= 2'd0;
      roi_size_sel <= 2'd1;
      roi_cx <= 10'd320;
      roi_cy <= 9'd240;
      label_idx <= 4'd0;
      dump_mode <= 1'b0;
      roi_dump <= 1'b0;
    end else begin
      threshold_wr <= 1'b0;
      roi_dump <= 1'b0;

      // Clear dump_mode when the last ASCII byte of the dump is accepted.
      if (roi_dump_o_valid && roi_dump_o_ready && roi_dump_o_last) begin
        dump_mode <= 1'b0;
      end

      if (uart_rx_valid) begin
        if (uart_esc_state == 2'd0) begin
          if (uart_rx_data == 8'h1B) begin
            uart_esc_state <= 2'd1;
          end else if (uart_rx_data == 8'h2B) begin
            if (threshold_wdata < 4'd15) begin
              threshold_wdata <= threshold_wdata + 4'd1;
              threshold_wr <= 1'b1;
              if (!uart_send_active) begin
                uart_send_active <= 1'b1;
                uart_msg_idx <= 5'd0;
              end
            end
          end else if (uart_rx_data == 8'h2D) begin
            if (threshold_wdata > 4'd0) begin
              threshold_wdata <= threshold_wdata - 4'd1;
              threshold_wr <= 1'b1;
              if (!uart_send_active) begin
                uart_send_active <= 1'b1;
                uart_msg_idx <= 5'd0;
              end
            end
          end else if ((uart_rx_data == 8'h53) || (uart_rx_data == 8'h73)) begin
            roi_size_sel <= 2'd0;
            if (!uart_send_active) begin
              uart_send_active <= 1'b1;
              uart_msg_idx <= 5'd0;
            end
          end else if ((uart_rx_data == 8'h4D) || (uart_rx_data == 8'h6D)) begin
            roi_size_sel <= 2'd1;
            if (!uart_send_active) begin
              uart_send_active <= 1'b1;
              uart_msg_idx <= 5'd0;
            end
          end else if ((uart_rx_data == 8'h4C) || (uart_rx_data == 8'h6C)) begin
            roi_size_sel <= 2'd2;
            if (!uart_send_active) begin
              uart_send_active <= 1'b1;
              uart_msg_idx <= 5'd0;
            end
          end else if ((uart_rx_data == 8'h43) || (uart_rx_data == 8'h63)) begin
            // 'C' or 'c': trigger ROI capture dump over UART
            if (!dump_mode) begin
              roi_dump  <= 1'b1;
              dump_mode <= 1'b1;
            end
          end else if ((uart_rx_data >= 8'h30) && (uart_rx_data <= 8'h39)) begin
            label_idx <= uart_rx_data - 8'h30;
          end else if ((uart_rx_data >= 8'h41) && (uart_rx_data <= 8'h46)) begin
            label_idx <= uart_rx_data - 8'h37;
          end else if ((uart_rx_data >= 8'h61) && (uart_rx_data <= 8'h66)) begin
            label_idx <= uart_rx_data - 8'h57;
          end else if ((uart_rx_data == 8'h3F) && !uart_send_active) begin
            uart_send_active <= 1'b1;
            uart_msg_idx <= 5'd0;
          end
        end else if (uart_esc_state == 2'd1) begin
          if (uart_rx_data == 8'h5B) begin
            uart_esc_state <= 2'd2;
          end else begin
            uart_esc_state <= 2'd0;
          end
        end else begin
          uart_esc_state <= 2'd0;
          if (uart_rx_data == 8'h41) begin
            if (roi_cy > (rect_cy_min + MOVE_STEP_Y - 9'd1)) begin
              roi_cy <= roi_cy - MOVE_STEP_Y;
            end else begin
              roi_cy <= rect_cy_min;
            end
          end else if (uart_rx_data == 8'h42) begin
            if (roi_cy < (rect_cy_max - MOVE_STEP_Y + 9'd1)) begin
              roi_cy <= roi_cy + MOVE_STEP_Y;
            end else begin
              roi_cy <= rect_cy_max;
            end
          end else if (uart_rx_data == 8'h43) begin
            if (roi_cx < (rect_cx_max - MOVE_STEP_X + 10'd1)) begin
              roi_cx <= roi_cx + MOVE_STEP_X;
            end else begin
              roi_cx <= rect_cx_max;
            end
          end else if (uart_rx_data == 8'h44) begin
            if (roi_cx > (rect_cx_min + MOVE_STEP_X - 10'd1)) begin
              roi_cx <= roi_cx - MOVE_STEP_X;
            end else begin
              roi_cx <= rect_cx_min;
            end
          end
          if (!uart_send_active) begin
            uart_send_active <= 1'b1;
            uart_msg_idx <= 5'd0;
          end
        end
      end

      if (roi_cx < rect_cx_min) begin
        roi_cx <= rect_cx_min;
      end else if (roi_cx > rect_cx_max) begin
        roi_cx <= rect_cx_max;
      end

      if (roi_cy < rect_cy_min) begin
        roi_cy <= rect_cy_min;
      end else if (roi_cy > rect_cy_max) begin
        roi_cy <= rect_cy_max;
      end

      if (uart_send_active && !uart_tx_busy && !dump_mode) begin
        if (uart_msg_idx == 5'd19) begin
          uart_send_active <= 1'b0;
        end else begin
          uart_msg_idx <= uart_msg_idx + 5'd1;
        end
      end
    end
  end

endmodule
