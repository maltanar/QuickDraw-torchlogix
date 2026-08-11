module capture_buffer (
  input  wire       wclk,
  input  wire       we,
  input  wire [18:0] waddr,
  input  wire       wmono,

  input  wire       rclk,
  input  wire       re,
  input  wire [18:0] raddr,
  output reg        rmono
);

  localparam integer FRAME_PIXELS = 640 * 480;
  reg mem [0:FRAME_PIXELS-1];

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
