module capture_reader (
  input  wire       clk,
  input  wire       rst_n,

  output reg        cap_re,
  output reg [15:0] cap_raddr,
  input  wire       cap_rmono,

  output reg        m_valid,
  output reg        m_tlast,
  output reg        m_mono,
  output reg [7:0]  m_x,
  output reg [7:0]  m_y
);

  reg [15:0] scan_addr;
  reg valid_d;
  reg [15:0] addr_d;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      scan_addr  <= 16'd0;
      cap_re     <= 1'b0;
      cap_raddr  <= 16'd0;
      valid_d    <= 1'b0;
      addr_d     <= 16'd0;
      m_valid    <= 1'b0;
      m_tlast    <= 1'b0;
      m_mono     <= 1'b0;
      m_x        <= 8'd0;
      m_y        <= 8'd0;
    end else begin
      cap_re    <= 1'b1;
      cap_raddr <= scan_addr;
      scan_addr <= scan_addr + 16'd1;

      valid_d <= cap_re;
      addr_d  <= cap_raddr;

      m_valid <= valid_d;
      m_mono  <= cap_rmono;
      m_x     <= addr_d[7:0];
      m_y     <= addr_d[15:8];
      m_tlast <= valid_d && (addr_d == 16'hFFFF);
    end
  end

endmodule
