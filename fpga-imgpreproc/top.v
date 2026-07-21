
module top
(
  input clk,
  input btn,
  input rx_i,
  output tx_o,
  input [7:0] cam_data,
  input cam_PCLK,
  input cam_HREF,
  input cam_VSYNC,
  output cam_RESET,
  output cam_XCLK,
  output cam_PWON,
  output cam_SOIC,
  inout  cam_SOID,

  output vga_hsync,
  output vga_vsync,
  output [3:0] vga_R,
  output [3:0] vga_G,
  output [3:0] vga_B
);

wire clk_25MHz;

pll pll_i(
	.clock_in(clk),             // 10 MHz input
  .clock_out(clk_25MHz)       // 25 MHz output 
);

// You do not need to connect PWON and RESET pins, but if you do you need this
assign cam_PWON = 1'b0;  // constant camera Power ON
assign cam_RESET = 1'b1; // camera reset to HIGH

wire inDisplayArea;
wire [9:0] CounterX;
wire [8:0] CounterY;
wire frame_done;

hvsync_generator hvsync_gen(
  .clk(clk_25MHz), //Input
  .vga_h_sync(vga_hsync), //Output
  .vga_v_sync(vga_vsync),//Output
  .inDisplayArea(inDisplayArea), //Output
  .CounterX(CounterX), //Output
  .CounterY(CounterY) //Output
);

wire [11:0] pixin;
wire [15:0] pixout;
wire [7:0] xout;
wire [7:0] yout;
reg we;

wire [3:0] cam_R = pixin[11:8];
wire [3:0] cam_G = pixin[7:4];
wire [3:0] cam_B = pixin[3:0];
// 4-bit grayscale conversion using weighted average
wire [3:0] cam_Y = ((cam_R * 5) + (cam_G * 9) + (cam_B * 2)) >> 4;
wire bw_pixel = (cam_Y >= bw_threshold);

assign vga_R = inDisplayArea ? (bw_pixel ? 4'hF : 4'h0) : 4'h0;
assign vga_G = inDisplayArea ? (bw_pixel ? 4'hF : 4'h0) : 4'h0;
assign vga_B = inDisplayArea ? (bw_pixel ? 4'hF : 4'h0) : 4'h0;

wire [7:0] xin = CounterX[9:2];
wire [7:0] yin = 8'd255 - CounterY[8:1];

wire [15:0] raddr = { yin, xin };
wire [15:0] waddr = { yout, xout };

vgabuff vgab (
        .clk(cam_PCLK), // Input
        .raddr(raddr),   // Input
        .pixin(pixin),  // Output
        .we(we),        // Input
        .waddr(waddr),  // Input
        .rclk(clk_25MHz),
        .pixout(pixout[11:0]) // Input
        );

wire [15:0] pixel_data;
wire [9:0] row, col;

assign yout = 255 - row[8:1] + 31;
assign xout = 150 - col[9:2];

assign pixout = pixel_data;

assign cam_XCLK =  clk_25MHz;

camera_read cam_read(
    .clk(clk_25MHz),           // 25MHz INPUT
    .x_clock(),                // OUTPUT
    .p_clock(cam_PCLK),        // Input
    .vsync(cam_VSYNC),         // Input
    .href(cam_HREF),           // Input
    .p_data(cam_data),         // Input
    .pixel_data(pixel_data),   // Input
    .pixel_valid(we),          // Input
    .frame_done(frame_done),
    .row(row),
    .col(col)
);

  reg [5:0] reset_cnt = 0;
  wire resetn = (&reset_cnt) & btn;

	always @(posedge clk_25MHz) begin
		reset_cnt <= reset_cnt + !resetn;
	end

wire [7:0] uart_rx_data;
wire uart_rx_valid;
wire uart_tx_busy;
wire [7:0] uart_tx_din;
wire uart_tx_wr;
reg uart_send_active;
reg [2:0] uart_msg_idx;
reg [3:0] bw_threshold;

assign uart_tx_din =
  (uart_msg_idx == 3'd0) ? "H" :
  (uart_msg_idx == 3'd1) ? "e" :
  (uart_msg_idx == 3'd2) ? "l" :
  (uart_msg_idx == 3'd3) ? "l" :
                           "o";
assign uart_tx_wr = uart_send_active && !uart_tx_busy;

uart_rx #(
  .CLK_FREQ(25000000),
  .BAUD_RATE(115200)
) uart_rx_i (
  .clk(clk_25MHz),
  .rst_n(resetn),
  .rx(rx_i),
  .data(uart_rx_data),
  .valid(uart_rx_valid)
);

uart_tx #(
  .CLK_FREQ(25000000),
  .BAUD_RATE(115200)
) uart_tx_i (
  .clk(clk_25MHz),
  .rst_n(resetn),
  .din(uart_tx_din),
  .wr(uart_tx_wr),
  .busy(uart_tx_busy),
  .tx(tx_o)
);

always @(posedge clk_25MHz or negedge resetn) begin
  if (!resetn) begin
    uart_send_active <= 1'b0;
    uart_msg_idx <= 3'd0;
    bw_threshold <= 4'd7;
  end else begin
    if (uart_rx_valid) begin
      if (uart_rx_data == 8'h2B) begin // '+' increases threshold
        if (bw_threshold < 4'd15) begin
          bw_threshold <= bw_threshold + 4'd1;
        end
      end else if (uart_rx_data == 8'h2D) begin // '-' decreases threshold
        if (bw_threshold > 4'd0) begin
          bw_threshold <= bw_threshold - 4'd1;
        end
      end else if ((uart_rx_data == 8'h3F) && !uart_send_active) begin
        uart_send_active <= 1'b1;
        uart_msg_idx <= 3'd0;
      end
    end

    if (uart_send_active && !uart_tx_busy) begin
      if (uart_msg_idx == 3'd4) begin
        uart_send_active <= 1'b0;
      end else begin
        uart_msg_idx <= uart_msg_idx + 3'd1;
      end
    end
  end
end

camera_configure cam_configure
(
    .clk(clk_25MHz),    // 25MHz
    .start(!resetn),       // Input
    .sioc(cam_SOIC),    // Output
    .siod(cam_SOID),    // Output
    .done()             // Output
);

endmodule
