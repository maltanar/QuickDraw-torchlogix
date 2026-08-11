module sim_camera_source (
  input  wire       cam_pclk,
  input  wire       cam_vsync,
  input  wire       cam_href,
  input  wire [7:0] cam_data,

  output wire       frame_done,
  output wire       tvalid,
  output wire [11:0] tdata_rgb444,
  output wire       tlast,
  output wire [9:0] pix_x,
  output wire [9:0] pix_y
);

  // Compile-time camera X mirror. Set to 1'b1 to mirror horizontally.
  localparam MIRROR_X = 1'b0;

  wire [15:0] pixel_data;
  wire [9:0] cam_x;
  wire [9:0] cam_y;

  camera_read cam_read_i (
    .clk(1'b0),
    .x_clock(),
    .p_clock(cam_pclk),
    .vsync(cam_vsync),
    .href(cam_href),
    .p_data(cam_data),
    .pixel_data(pixel_data),
    .pixel_valid(tvalid),
    .frame_done(frame_done),
    .pix_x(cam_x),
    .pix_y(cam_y)
  );

  assign tdata_rgb444 = pixel_data[11:0];
  assign tlast = frame_done;

  // Match hardware mapping used by camera_axis_source.
  assign pix_x = MIRROR_X ? (10'd639 - cam_x) : cam_x;
  assign pix_y = cam_y;

endmodule
