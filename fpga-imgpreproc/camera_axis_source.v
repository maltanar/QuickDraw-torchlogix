module camera_axis_source (
  input  wire       cam_pclk,
  input  wire       cam_vsync,
  input  wire       cam_href,
  input  wire [7:0] cam_data,

  output wire       frame_done,
  output wire       tvalid,
  output wire [11:0] tdata_rgb444,
  output wire       tlast,
  output wire [9:0] pix_x,
  output wire [8:0] pix_y
);

  wire [15:0] pixel_data;
  wire [9:0] row;
  wire [9:0] col;

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
    .row(row),
    .col(col)
  );

  assign tdata_rgb444 = pixel_data[11:0];
  assign tlast = frame_done;

  // Full-resolution 640x480 mapping in camera_read native orientation.
  assign pix_x = row;
  assign pix_y = col[8:0];

endmodule
