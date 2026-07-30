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
    .dump(roi_dump),
    .dump_o_valid(roi_dump_o_valid),
    .dump_o_byte(roi_dump_o_byte),
    .dump_o_last(roi_dump_o_last),
    .dump_o_ready(roi_dump_o_ready)
  );

  // ---------------------------------------------------------------------------
  // Datapath stage 3: capture buffer write (camera clock) and read (25 MHz).
  // ---------------------------------------------------------------------------
  wire cap_re;
  wire [15:0] cap_raddr;
  wire cap_rmono;

  capture_buffer capture_buffer_i (
    .wclk(cam_PCLK),
    .we(mono_axis_valid_out),
    .waddr({mono_axis_y_out, mono_axis_x_out}),
    .wmono(mono_axis_pixel_out),
  .re(cap_re),
  .raddr(cap_raddr),
  .rmono(cap_rmono)
);

wire cap_stream_valid;
wire cap_stream_tlast;
wire cap_stream_mono;
wire [7:0] cap_stream_x;
wire [7:0] cap_stream_y;

capture_reader capture_reader_i (
  .clk(clk_25MHz),
  .rst_n(resetn),
  .cap_re(cap_re),
  .cap_raddr(cap_raddr),
  .cap_rmono(cap_rmono),
  .m_valid(cap_stream_valid),
  .m_tlast(cap_stream_tlast),
  .m_mono(cap_stream_mono),
  .m_x(cap_stream_x),
  .m_y(cap_stream_y)
);

// ---------------------------------------------------------------------------
// Datapath stage 4: renderer overlays ROI border + green label text.
// ---------------------------------------------------------------------------
wire vga_wr_en;
wire [15:0] vga_wr_addr;
wire [11:0] vga_wr_pixel;

renderer renderer_i (
  .clk(clk_25MHz),
  .rst_n(resetn),
  .s_valid(cap_stream_valid),
  .s_mono(cap_stream_mono),
  .s_tlast(cap_stream_tlast),
  .s_x(cap_stream_x),
  .s_y(cap_stream_y),
  .roi_cx(roi_cx),
  .roi_cy(roi_cy),
  .roi_size_sel(roi_size_sel),
  .label_idx(label_idx),
  .m_we(vga_wr_en),
  .m_waddr(vga_wr_addr),
  .m_rgb444(vga_wr_pixel)
);

// ---------------------------------------------------------------------------
// Datapath stage 5: VGA buffer + scanout.
// ---------------------------------------------------------------------------
wire [15:0] vga_rd_addr;
wire [11:0] vga_rd_pixel;

vgabuff vga_buffer_i (
  .clk(clk_25MHz),
  .raddr(vga_rd_addr),
  .waddr(vga_wr_addr),
  .we(vga_wr_en),
  .pixout(vga_wr_pixel),
  .rclk(clk_25MHz),
  .pixin(vga_rd_pixel)
);

vga_scanout vga_scanout_i (
  .clk_25mhz(clk_25MHz),
  .pix_in(vga_rd_pixel),
  .pix_addr(vga_rd_addr),
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
