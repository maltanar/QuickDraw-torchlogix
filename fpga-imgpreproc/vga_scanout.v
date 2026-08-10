module vga_scanout (
  input  wire       clk_25mhz,
  input  wire [11:0] pix_in,
  output wire [15:0] pix_addr,

  output wire       vga_hsync,
  output wire       vga_vsync,
  output wire [3:0] vga_r,
  output wire [3:0] vga_g,
  output wire [3:0] vga_b
);

  wire in_display_area;
  wire [9:0] counter_x;
  wire [8:0] counter_y;

  localparam [9:0] VIEW_X0 = 10'd80;
  localparam [9:0] VIEW_X1 = 10'd559;

  hvsync_generator hsync_i (
    .clk(clk_25mhz),
    .vga_h_sync(vga_hsync),
    .vga_v_sync(vga_vsync),
    .inDisplayArea(in_display_area),
    .CounterX(counter_x),
    .CounterY(counter_y)
  );

  wire in_square_view = in_display_area && (counter_x >= VIEW_X0) && (counter_x <= VIEW_X1);
  wire [9:0] view_x = counter_x - VIEW_X0;

  // Display a centered 480x480 square with isotropic 2x scaling in both axes.
  // This shows camera rows/cols [8..247] and preserves square ROI appearance.
  wire [7:0] xin = in_square_view ? (8'd8 + view_x[8:1]) : 8'd0;
  wire [7:0] yin = in_square_view ? (8'd247 - counter_y[8:1]) : 8'd0;

  assign pix_addr = {yin, xin};

  assign vga_r = in_square_view ? pix_in[11:8] : 4'h0;
  assign vga_g = in_square_view ? pix_in[7:4] : 4'h0;
  assign vga_b = in_square_view ? pix_in[3:0] : 4'h0;

endmodule
