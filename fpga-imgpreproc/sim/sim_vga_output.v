module sim_vga_output (
  input  wire       clk_25mhz,
  input  wire [11:0] pix_in,
  output wire [18:0] pix_addr,
  output wire [9:0] pix_x,
  output wire [8:0] pix_y,
  output wire        pix_req_valid,
  output wire        in_display,

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
  reg in_display_d0;
  reg in_display_d1;

  hvsync_generator hsync_i (
    .clk(clk_25mhz),
    .vga_h_sync(vga_hsync_raw),
    .vga_v_sync(vga_vsync_raw),
    .inDisplayArea(in_display_area),
    .CounterX(counter_x),
    .CounterY(counter_y)
  );

  assign pix_req_valid = in_display_area;
  assign pix_x = counter_x;
  assign pix_y = counter_y;
  assign pix_addr = ({10'd0, counter_y} << 9) + ({10'd0, counter_y} << 7) + counter_x;
  assign in_display = in_display_d1;

  always @(posedge clk_25mhz) begin
    vga_hsync_d0 <= vga_hsync_raw;
    vga_hsync_d1 <= vga_hsync_d0;
    vga_vsync_d0 <= vga_vsync_raw;
    vga_vsync_d1 <= vga_vsync_d0;
    in_display_d0 <= in_display_area;
    in_display_d1 <= in_display_d0;
  end

  assign vga_hsync = vga_hsync_d1;
  assign vga_vsync = vga_vsync_d1;

  assign vga_r = in_display_d1 ? pix_in[11:8] : 4'h0;
  assign vga_g = in_display_d1 ? pix_in[7:4] : 4'h0;
  assign vga_b = in_display_d1 ? pix_in[3:0] : 4'h0;

endmodule
