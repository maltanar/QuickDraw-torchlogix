module capture_buffer (
  input  wire       wclk,
  input  wire       we,
  input  wire [15:0] waddr,
  input  wire       wmono,

  input  wire       rclk,
  input  wire       re,
  input  wire [15:0] raddr,
  output reg        rmono
);

  reg mem [0:64*1024];

  always @(posedge wclk) begin
    if (we) begin
      mem[waddr] <= wmono;
    end
  end

  always @(posedge rclk) begin
    if (re) begin
      rmono <= mem[raddr];
    end
  end

endmodule
