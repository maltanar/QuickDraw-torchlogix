module threshold_stream (
  input  wire       cfg_clk,
  input  wire       cfg_rst_n,
  input  wire       cfg_wr,
  input  wire [3:0] cfg_data,

  input  wire       data_clk,
  input  wire       data_rst_n,
  input  wire       s_valid,
  input  wire [11:0] s_rgb444,
  input  wire       s_tlast,
  input  wire [9:0] s_x,
  input  wire [9:0] s_y,

  output wire [3:0] threshold_level,
  output wire       m_valid,
  output wire       m_mono,
  output wire       m_tlast,
  output wire [9:0] m_x,
  output wire [9:0] m_y
);

  reg [3:0] cfg_shadow;
  reg cfg_toggle;

  always @(posedge cfg_clk or negedge cfg_rst_n) begin
    if (!cfg_rst_n) begin
      cfg_shadow <= 4'd7;
      cfg_toggle <= 1'b0;
    end else if (cfg_wr) begin
      cfg_shadow <= cfg_data;
      cfg_toggle <= ~cfg_toggle;
    end
  end

  reg [1:0] toggle_sync;
  reg [3:0] shadow_sync1;
  reg [3:0] shadow_sync2;
  reg [3:0] threshold_reg;

  always @(posedge data_clk or negedge data_rst_n) begin
    if (!data_rst_n) begin
      toggle_sync  <= 2'b00;
      shadow_sync1 <= 4'd7;
      shadow_sync2 <= 4'd7;
      threshold_reg <= 4'd7;
    end else begin
      toggle_sync  <= {toggle_sync[0], cfg_toggle};
      shadow_sync1 <= cfg_shadow;
      shadow_sync2 <= shadow_sync1;
      if (toggle_sync[1] != toggle_sync[0]) begin
        threshold_reg <= shadow_sync2;
      end
    end
  end

  wire [3:0] cam_r = s_rgb444[11:8];
  wire [3:0] cam_g = s_rgb444[7:4];
  wire [3:0] cam_b = s_rgb444[3:0];
  wire [7:0] y_mix = (cam_r * 4'd5) + (cam_g * 4'd9) + (cam_b * 4'd2);

  assign threshold_level = threshold_reg;
  assign m_valid = s_valid;
  assign m_mono = ((y_mix >> 4) < threshold_reg);
  assign m_tlast = s_tlast;
  assign m_x = s_x;
  assign m_y = s_y;

endmodule
