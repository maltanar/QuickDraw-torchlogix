`include "../verilog/neuralut_lut4_79.54.v"

module roi_inferencer #(
  parameter [3:0] NN_LATENCY = 4'd8,
  parameter integer N_SCORE_BITS = 6,
  parameter integer N_CLASSES = 10
) (
  input  wire         clk,
  input  wire         rst_n,
  input  wire         start,
  input  wire [783:0] roi_bits,
  output wire [783:0] nn_input_dbg,
  output reg          done,
  output reg  [N_CLASSES*N_SCORE_BITS-1:0] scores
);

  localparam integer SCORE_WIDTH = N_CLASSES * N_SCORE_BITS;

  reg [783:0] nn_input;
  wire [SCORE_WIDTH-1:0] nn_scores;

  reg       busy;
  reg [3:0] wait_ctr;

  assign nn_input_dbg = nn_input;

  neuralut neuralut_i (
    .M0(nn_input),
    .clk(clk),
    .rst(!rst_n),
    .M6(nn_scores)
  );

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      nn_input  <= 784'd0;
      done      <= 1'b0;
      scores    <= {SCORE_WIDTH{1'b0}};
      busy      <= 1'b0;
      wait_ctr  <= 4'd0;
    end else begin
      done <= 1'b0;

      if (start && !busy) begin
        nn_input <= roi_bits;
        busy     <= 1'b1;
        wait_ctr <= NN_LATENCY - 4'd1;
      end else if (busy) begin
        if (wait_ctr == 4'd0) begin
          busy   <= 1'b0;
          scores <= nn_scores;
          done   <= 1'b1;
        end else begin
          wait_ctr <= wait_ctr - 4'd1;
        end
      end
    end
  end

endmodule
