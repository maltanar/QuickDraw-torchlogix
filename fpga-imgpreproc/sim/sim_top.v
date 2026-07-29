module sim_top (
  input  wire       clk,
  input  wire       rst_n,
  input  wire       rx_i,
  output wire       tx_o,

  input  wire [7:0] sim_cam_data,
  input  wire       sim_cam_pclk,
  input  wire       sim_cam_href,
  input  wire       sim_cam_vsync,

  output wire       sim_vga_hsync,
  output wire       sim_vga_vsync,
  output wire [3:0] sim_vga_r,
  output wire [3:0] sim_vga_g,
  output wire [3:0] sim_vga_b,
  output wire [15:0] sim_vga_pix_addr,
  output wire        sim_vga_in_display
);

  // Instantiate the main top module with only camera and VGA inputs/outputs
  // All other outputs (cam_RESET, cam_XCLK, etc.) are not needed for simulation
  
  wire clk_25MHz;
  
  // PLL simulation - just pass through for simulation
  assign clk_25MHz = clk;

  // ---------------------------------------------------------------------------
  // Control path: UART command decoder drives threshold/ROI/label controls.
  // ---------------------------------------------------------------------------
  wire threshold_wr;
  wire [3:0] threshold_wdata;
  wire [1:0] roi_size_sel;
  wire [9:0] roi_cx;
  wire [8:0] roi_cy;
  wire [3:0] label_idx;

  control_uart control_uart_i (
    .clk(clk_25MHz),
    .rst_n(rst_n),
    .rx_i(rx_i),
    .tx_o(tx_o),
    .threshold_wr(threshold_wr),
    .threshold_wdata(threshold_wdata),
    .roi_size_sel(roi_size_sel),
    .roi_cx(roi_cx),
    .roi_cy(roi_cy),
    .label_idx(label_idx)
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

  sim_camera_source camera_axis_source_i (
    .cam_pclk(sim_cam_pclk),
    .cam_vsync(sim_cam_vsync),
    .cam_href(sim_cam_href),
    .cam_data(sim_cam_data),
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
    .cfg_rst_n(rst_n),
    .cfg_wr(threshold_wr),
    .cfg_data(threshold_wdata),
    .data_clk(sim_cam_pclk),
    .data_rst_n(rst_n),
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
  // Datapath stage 3: capture buffer write (camera clock) and read (25 MHz).
  // ---------------------------------------------------------------------------
  wire cap_re;
  wire [15:0] cap_raddr;
  wire cap_rmono;

  capture_buffer capture_buffer_i (
    .wclk(sim_cam_pclk),
    .we(mono_axis_valid),
    .waddr({mono_axis_y, mono_axis_x}),
    .wmono(mono_axis_pixel),
    .rclk(clk_25MHz),
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
    .rst_n(rst_n),
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
    .rst_n(rst_n),
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

  sim_vga_output vga_scanout_i (
    .clk_25mhz(clk_25MHz),
    .pix_in(vga_rd_pixel),
    .pix_addr(vga_rd_addr),
    .in_display(sim_vga_in_display),
    .vga_hsync(sim_vga_hsync),
    .vga_vsync(sim_vga_vsync),
    .vga_r(sim_vga_r),
    .vga_g(sim_vga_g),
    .vga_b(sim_vga_b)
  );

  assign sim_vga_pix_addr = vga_rd_addr;

endmodule
