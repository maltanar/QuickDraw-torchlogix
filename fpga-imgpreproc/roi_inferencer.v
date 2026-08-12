// Define ROI_INFERENCER_USE_MLP to build against the current MLP backend.
// Leave it undefined to use the neuralut backend.
// Remember to update latency (1 for MLP, 4 for neuralut) and N_SCORE_BITS (32 for MLP, 6 for neuralut) in the top.v accordingly.
`ifdef ROI_INFERENCER_USE_MLP
`include "../verilog/mlp_quickdraw_4k_4k.v"
`else
`include "../verilog/neuralut_lut4_79.54.v"
`endif

module roi_inferencer #(
  parameter [3:0] NN_LATENCY = 4'd1,
  parameter integer N_SCORE_BITS,
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

`ifdef ROI_INFERENCER_USE_MLP
  circuit mlp_quickdraw_4k_4k_i (
    .inp(nn_input),
    .scores_flat(nn_scores)
  );
`else
  neuralut neuralut_i (
    .M0(nn_input),
    .clk(clk),
    .rst(!rst_n),
    .M6(nn_scores)
  );
`endif

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
