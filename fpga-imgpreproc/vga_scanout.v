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

  hvsync_generator hsync_i (
    .clk(clk_25mhz),
    .vga_h_sync(vga_hsync),
    .vga_v_sync(vga_vsync),
    .inDisplayArea(in_display_area),
    .CounterX(counter_x),
    .CounterY(counter_y)
  );

  wire [7:0] xin = counter_x[9:2];
  wire [7:0] yin = 8'd255 - counter_y[8:1];

  assign pix_addr = {yin, xin};

  assign vga_r = in_display_area ? pix_in[11:8] : 4'h0;
  assign vga_g = in_display_area ? pix_in[7:4] : 4'h0;
  assign vga_b = in_display_area ? pix_in[3:0] : 4'h0;

endmodule
