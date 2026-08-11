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

pll pll_i (
  .clock_in(clk),
  .clock_out(clk_25MHz)
);

assign cam_PWON = 1'b0;
assign cam_RESET = 1'b1;
assign cam_XCLK = clk_25MHz;

reg [5:0] reset_cnt = 0;
wire resetn = (&reset_cnt) & btn;

always @(posedge clk_25MHz) begin
  reset_cnt <= reset_cnt + !resetn;
end

// ---------------------------------------------------------------------------
// Control path: UART command decoder drives threshold/ROI/label controls.
// ---------------------------------------------------------------------------
wire threshold_wr;
wire [3:0] threshold_wdata;
wire [1:0] roi_size_sel;
wire [9:0] roi_cx;
wire [8:0] roi_cy;
wire [3:0] label_idx;
wire nn_start;
wire nn_done;
wire [59:0] nn_scores;
wire nn_best_valid;
wire [3:0] nn_best_idx;

wire roi_dump;
  wire roi_dump_o_valid;
  wire [7:0] roi_dump_o_byte;
  wire roi_dump_o_last;

  control_uart control_uart_i (
    .clk(clk_25MHz),
    .rst_n(resetn),
    .rx_i(rx_i),
    .tx_o(tx_o),
    .threshold_wr(threshold_wr),
    .threshold_wdata(threshold_wdata),
    .roi_size_sel(roi_size_sel),
    .roi_cx(roi_cx),
    .roi_cy(roi_cy),
    .label_idx(label_idx),
    .nn_start(nn_start),
    .nn_done(nn_done),
    .nn_best_valid(nn_best_valid),
    .nn_best_idx(nn_best_idx),
    .roi_dump(roi_dump),
    .roi_dump_o_valid(roi_dump_o_valid),
    .roi_dump_o_byte(roi_dump_o_byte),
    .roi_dump_o_last(roi_dump_o_last),
    .roi_dump_o_ready(roi_dump_o_ready)
);

// ---------------------------------------------------------------------------
// Datapath stage 1: camera feed -> AXI-like stream with frame TLAST.
// ---------------------------------------------------------------------------
wire cam_frame_done;
wire cam_axis_valid;
wire [11:0] cam_axis_rgb444;
wire cam_axis_tlast;
wire [7:0] cam_axis_x;
wire [7:0] cam_axis_y;

camera_axis_source camera_axis_source_i (
  .cam_pclk(cam_PCLK),
  .cam_vsync(cam_VSYNC),
  .cam_href(cam_HREF),
  .cam_data(cam_data),
  .frame_done(cam_frame_done),
  .tvalid(cam_axis_valid),
  .tdata_rgb444(cam_axis_rgb444),
  .tlast(cam_axis_tlast),
  .pix_x(cam_axis_x),
  .pix_y(cam_axis_y)
);

// ---------------------------------------------------------------------------
// Datapath stage 2: thresholding with a writable threshold register.
// ---------------------------------------------------------------------------
wire [3:0] threshold_level;
wire mono_axis_valid;
wire mono_axis_pixel;
wire mono_axis_tlast;
wire [7:0] mono_axis_x;
wire [7:0] mono_axis_y;

threshold_stream threshold_stream_i (
  .cfg_clk(clk_25MHz),
  .cfg_rst_n(resetn),
  .cfg_wr(threshold_wr),
  .cfg_data(threshold_wdata),
  .data_clk(cam_PCLK),
  .data_rst_n(resetn),
  .s_valid(cam_axis_valid),
  .s_rgb444(cam_axis_rgb444),
  .s_tlast(cam_axis_tlast),
  .s_x(cam_axis_x),
  .s_y(cam_axis_y),
  .threshold_level(threshold_level),
  .m_valid(mono_axis_valid),
  .m_mono(mono_axis_pixel),
  .m_tlast(mono_axis_tlast),
  .m_x(mono_axis_x),
  .m_y(mono_axis_y)
);

// ---------------------------------------------------------------------------
  // Datapath stage 2.5: ROI capture buffer – intercept mono_axis, write
  // to internal buffer, and pass-through to capture_buffer.
  // ---------------------------------------------------------------------------
  wire mono_axis_valid_out;
  wire mono_axis_pixel_out;
  wire mono_axis_tlast_out;
  wire [7:0] mono_axis_x_out;
  wire [7:0] mono_axis_y_out;
  wire [783:0] roi_bits;
  wire roi_dump_o_ready;

  roi_capture roi_capture_i (
    .data_clk(cam_PCLK),
    .data_rst_n(resetn),
    .s_valid(mono_axis_valid),
    .s_pixel(mono_axis_pixel),
    .s_tlast(mono_axis_tlast),
    .s_x(mono_axis_x),
    .s_y(mono_axis_y),
    .m_valid(mono_axis_valid_out),
    .m_pixel(mono_axis_pixel_out),
    .m_tlast(mono_axis_tlast_out),
    .m_x(mono_axis_x_out),
    .m_y(mono_axis_y_out),
    .roi_cx(roi_cx),
    .roi_cy(roi_cy),
    .roi_size_sel(roi_size_sel),
    .ctrl_clk(clk_25MHz),
    .ctrl_rst_n(resetn),
    .roi_bits(roi_bits),
    .dump(roi_dump),
    .dump_o_valid(roi_dump_o_valid),
    .dump_o_byte(roi_dump_o_byte),
    .dump_o_last(roi_dump_o_last),
    .dump_o_ready(roi_dump_o_ready)
  );

  roi_inferencer roi_inferencer_i (
    .clk(clk_25MHz),
    .rst_n(resetn),
    .start(nn_start),
    .roi_bits(roi_bits),
    .done(nn_done),
    .scores(nn_scores)
  );

  score_argmax10 score_argmax10_i (
    .clk(clk_25MHz),
    .rst_n(resetn),
    .in_valid(nn_done),
    .scores(nn_scores),
    .out_valid(nn_best_valid),
    .max_idx(nn_best_idx)
  );

  // ---------------------------------------------------------------------------
  // Datapath stage 3: capture buffer write (camera clock) and read (25 MHz).
  // ---------------------------------------------------------------------------
  wire cap_rmono;
  wire [15:0] vga_rd_addr;
  wire scan_pix_valid;

  capture_buffer capture_buffer_i (
  .wclk(cam_PCLK),
  .we(mono_axis_valid_out),
  .waddr({mono_axis_y_out, mono_axis_x_out}),
  .wmono(mono_axis_pixel_out),
  .rclk(clk_25MHz),
  .re(1'b1),
  .raddr(vga_rd_addr),
  .rmono(cap_rmono)
);

reg scan_pix_valid_d;
reg [7:0] scan_x_d;
reg [7:0] scan_y_d;

always @(posedge clk_25MHz or negedge resetn) begin
  if (!resetn) begin
    scan_pix_valid_d <= 1'b0;
    scan_x_d <= 8'd0;
    scan_y_d <= 8'd0;
  end else begin
    scan_pix_valid_d <= scan_pix_valid;
    scan_x_d <= vga_rd_addr[7:0];
    scan_y_d <= vga_rd_addr[15:8];
  end
end

// ---------------------------------------------------------------------------
// Datapath stage 4: renderer overlays ROI border + green label text.
// ---------------------------------------------------------------------------
wire [11:0] vga_pix_rgb;

renderer renderer_i (
  .clk(clk_25MHz),
  .rst_n(resetn),
  .s_valid(scan_pix_valid_d),
  .s_mono(cap_rmono),
  .s_tlast(1'b0),
  .s_x(scan_x_d),
  .s_y(scan_y_d),
  .roi_cx(roi_cx),
  .roi_cy(roi_cy),
  .roi_size_sel(roi_size_sel),
  .label_idx(label_idx),
  .m_we(),
  .m_waddr(),
  .m_rgb444(vga_pix_rgb)
);

// ---------------------------------------------------------------------------
// Datapath stage 5: direct scanout (no intermediate RGB frame buffer).
// ---------------------------------------------------------------------------
vga_scanout vga_scanout_i (
  .clk_25mhz(clk_25MHz),
  .pix_in(vga_pix_rgb),
  .pix_addr(vga_rd_addr),
  .pix_req_valid(scan_pix_valid),
  .vga_hsync(vga_hsync),
  .vga_vsync(vga_vsync),
  .vga_r(vga_R),
  .vga_g(vga_G),
  .vga_b(vga_B)
);

camera_configure cam_configure
(
  .clk(clk_25MHz),
  .start(!resetn),
  .sioc(cam_SOIC),
  .siod(cam_SOID),
  .done()
);

endmodule
