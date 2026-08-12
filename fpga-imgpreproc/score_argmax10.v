module score_argmax10 #(
  parameter integer N_SCORE_BITS = 6,
  parameter integer N_CLASSES = 10
) (
  input  wire        clk,
  input  wire        rst_n,
  input  wire        in_valid,
  input  wire [N_CLASSES*N_SCORE_BITS-1:0] scores,
  output reg         out_valid,
  output reg  [3:0]  max_idx
);

  localparam integer SCORE_WIDTH = N_CLASSES * N_SCORE_BITS;
  localparam integer PAIR_WIDTH = N_SCORE_BITS + 4;

  function [N_SCORE_BITS-1:0] class_score;
    input [SCORE_WIDTH-1:0] packed_scores;
    input [3:0] class_idx;
    begin
      case (class_idx)
        4'd0: class_score = packed_scores[N_SCORE_BITS-1:0];
        4'd1: class_score = packed_scores[2*N_SCORE_BITS-1:N_SCORE_BITS];
        4'd2: class_score = packed_scores[3*N_SCORE_BITS-1:2*N_SCORE_BITS];
        4'd3: class_score = packed_scores[4*N_SCORE_BITS-1:3*N_SCORE_BITS];
        4'd4: class_score = packed_scores[5*N_SCORE_BITS-1:4*N_SCORE_BITS];
        4'd5: class_score = packed_scores[6*N_SCORE_BITS-1:5*N_SCORE_BITS];
        4'd6: class_score = packed_scores[7*N_SCORE_BITS-1:6*N_SCORE_BITS];
        4'd7: class_score = packed_scores[8*N_SCORE_BITS-1:7*N_SCORE_BITS];
        4'd8: class_score = packed_scores[9*N_SCORE_BITS-1:8*N_SCORE_BITS];
        4'd9: class_score = packed_scores[10*N_SCORE_BITS-1:9*N_SCORE_BITS];
        default: class_score = {N_SCORE_BITS{1'b0}};
      endcase
    end
  endfunction

  function [PAIR_WIDTH-1:0] max_pair;
    input [N_SCORE_BITS-1:0] a_val;
    input [3:0] a_idx;
    input [N_SCORE_BITS-1:0] b_val;
    input [3:0] b_idx;
    begin
      if (b_val > a_val) begin
        max_pair = {b_val, b_idx};
      end else begin
        max_pair = {a_val, a_idx};
      end
    end
  endfunction

  reg [N_SCORE_BITS-1:0] s1_v0, s1_v1, s1_v2, s1_v3, s1_v4;
  reg [3:0] s1_i0, s1_i1, s1_i2, s1_i3, s1_i4;
  reg [N_SCORE_BITS-1:0] s2_v0, s2_v1, s2_v2;
  reg [3:0] s2_i0, s2_i1, s2_i2;
  reg [N_SCORE_BITS-1:0] s3_v0, s3_v1;
  reg [3:0] s3_i0, s3_i1;

  reg s1_valid;
  reg s2_valid;
  reg s3_valid;

  wire [PAIR_WIDTH-1:0] p0_comb;
  wire [PAIR_WIDTH-1:0] p1_comb;
  wire [PAIR_WIDTH-1:0] p2_comb;
  wire [PAIR_WIDTH-1:0] p3_comb;
  wire [PAIR_WIDTH-1:0] p4_comb;
  wire [PAIR_WIDTH-1:0] q0_comb;
  wire [PAIR_WIDTH-1:0] q1_comb;
  wire [PAIR_WIDTH-1:0] r0_comb;
  wire [PAIR_WIDTH-1:0] final_pair;

  assign p0_comb = max_pair(class_score(scores, 4'd0), 4'd0, class_score(scores, 4'd1), 4'd1);
  assign p1_comb = max_pair(class_score(scores, 4'd2), 4'd2, class_score(scores, 4'd3), 4'd3);
  assign p2_comb = max_pair(class_score(scores, 4'd4), 4'd4, class_score(scores, 4'd5), 4'd5);
  assign p3_comb = max_pair(class_score(scores, 4'd6), 4'd6, class_score(scores, 4'd7), 4'd7);
  assign p4_comb = max_pair(class_score(scores, 4'd8), 4'd8, class_score(scores, 4'd9), 4'd9);

  assign q0_comb = max_pair(s1_v0, s1_i0, s1_v1, s1_i1);
  assign q1_comb = max_pair(s1_v2, s1_i2, s1_v3, s1_i3);
  assign r0_comb = max_pair(s2_v0, s2_i0, s2_v1, s2_i1);
  assign final_pair = max_pair(s3_v0, s3_i0, s3_v1, s3_i1);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      s1_v0 <= {N_SCORE_BITS{1'b0}};
      s1_v1 <= {N_SCORE_BITS{1'b0}};
      s1_v2 <= {N_SCORE_BITS{1'b0}};
      s1_v3 <= {N_SCORE_BITS{1'b0}};
      s1_v4 <= {N_SCORE_BITS{1'b0}};
      s1_i0 <= 4'd0;
      s1_i1 <= 4'd0;
      s1_i2 <= 4'd0;
      s1_i3 <= 4'd0;
      s1_i4 <= 4'd0;
      s2_v0 <= {N_SCORE_BITS{1'b0}};
      s2_v1 <= {N_SCORE_BITS{1'b0}};
      s2_v2 <= {N_SCORE_BITS{1'b0}};
      s2_i0 <= 4'd0;
      s2_i1 <= 4'd0;
      s2_i2 <= 4'd0;
      s3_v0 <= {N_SCORE_BITS{1'b0}};
      s3_v1 <= {N_SCORE_BITS{1'b0}};
      s3_i0 <= 4'd0;
      s3_i1 <= 4'd0;
      max_idx <= 4'd0;
      s1_valid <= 1'b0;
      s2_valid <= 1'b0;
      s3_valid <= 1'b0;
      out_valid <= 1'b0;
    end else begin
      // Valid pipeline for deterministic handoff to UART control.
      s1_valid <= in_valid;
      s2_valid <= s1_valid;
      s3_valid <= s2_valid;
      out_valid <= s3_valid;

      if (in_valid) begin
        s1_v0 <= p0_comb[PAIR_WIDTH-1:4];
        s1_i0 <= p0_comb[3:0];
        s1_v1 <= p1_comb[PAIR_WIDTH-1:4];
        s1_i1 <= p1_comb[3:0];
        s1_v2 <= p2_comb[PAIR_WIDTH-1:4];
        s1_i2 <= p2_comb[3:0];
        s1_v3 <= p3_comb[PAIR_WIDTH-1:4];
        s1_i3 <= p3_comb[3:0];
        s1_v4 <= p4_comb[PAIR_WIDTH-1:4];
        s1_i4 <= p4_comb[3:0];
      end

      if (s1_valid) begin
        s2_v0 <= q0_comb[PAIR_WIDTH-1:4];
        s2_i0 <= q0_comb[3:0];
        s2_v1 <= q1_comb[PAIR_WIDTH-1:4];
        s2_i1 <= q1_comb[3:0];
        s2_v2 <= s1_v4;
        s2_i2 <= s1_i4;
      end

      if (s2_valid) begin
        s3_v0 <= r0_comb[PAIR_WIDTH-1:4];
        s3_i0 <= r0_comb[3:0];
        s3_v1 <= s2_v2;
        s3_i1 <= s2_i2;
      end

      if (s3_valid) begin
        max_idx <= final_pair[3:0];
      end
    end
  end

endmodule
