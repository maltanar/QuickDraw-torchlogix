module vga_scanout (
  input  wire       clk_25mhz,
  input  wire [11:0] pix_in,
  output wire [15:0] pix_addr,
  output wire       pix_req_valid,

  output wire       vga_hsync,
  output wire       vga_vsync,
  output wire [3:0] vga_r,
  output wire [3:0] vga_g,
  output wire [3:0] vga_b
);

  wire in_display_area;
  wire [9:0] counter_x;
  wire [8:0] counter_y;
  wire vga_hsync_raw;
  wire vga_vsync_raw;

  reg vga_hsync_d0;
  reg vga_hsync_d1;
  reg vga_vsync_d0;
  reg vga_vsync_d1;
  reg in_square_view_d0;
  reg in_square_view_d1;

  localparam [9:0] VIEW_X0 = 10'd80;
  localparam [9:0] VIEW_X1 = 10'd559;

  hvsync_generator hsync_i (
    .clk(clk_25mhz),
    .vga_h_sync(vga_hsync_raw),
    .vga_v_sync(vga_vsync_raw),
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

  assign pix_req_valid = in_square_view;
  assign pix_addr = {yin, xin};

  always @(posedge clk_25mhz) begin
    vga_hsync_d0 <= vga_hsync_raw;
    vga_hsync_d1 <= vga_hsync_d0;
    vga_vsync_d0 <= vga_vsync_raw;
    vga_vsync_d1 <= vga_vsync_d0;
    in_square_view_d0 <= in_square_view;
    in_square_view_d1 <= in_square_view_d0;
  end

  assign vga_hsync = vga_hsync_d1;
  assign vga_vsync = vga_vsync_d1;

  assign vga_r = in_square_view_d1 ? pix_in[11:8] : 4'h0;
  assign vga_g = in_square_view_d1 ? pix_in[7:4] : 4'h0;
  assign vga_b = in_square_view_d1 ? pix_in[3:0] : 4'h0;

endmodule
