module score_argmax10 (
  input  wire        clk,
  input  wire        rst_n,
  input  wire        in_valid,
  input  wire [59:0] scores,
  output reg         out_valid,
  output reg  [3:0]  max_idx
);

  function [5:0] class_score;
    input [59:0] packed_scores;
    input [3:0] class_idx;
    begin
      case (class_idx)
        4'd0: class_score = packed_scores[5:0];
        4'd1: class_score = packed_scores[11:6];
        4'd2: class_score = packed_scores[17:12];
        4'd3: class_score = packed_scores[23:18];
        4'd4: class_score = packed_scores[29:24];
        4'd5: class_score = packed_scores[35:30];
        4'd6: class_score = packed_scores[41:36];
        4'd7: class_score = packed_scores[47:42];
        4'd8: class_score = packed_scores[53:48];
        4'd9: class_score = packed_scores[59:54];
        default: class_score = 6'd0;
      endcase
    end
  endfunction

  function [9:0] max_pair;
    input [5:0] a_val;
    input [3:0] a_idx;
    input [5:0] b_val;
    input [3:0] b_idx;
    begin
      if (b_val > a_val) begin
        max_pair = {b_val, b_idx};
      end else begin
        max_pair = {a_val, a_idx};
      end
    end
  endfunction

  reg [5:0] s1_v0, s1_v1, s1_v2, s1_v3, s1_v4;
  reg [3:0] s1_i0, s1_i1, s1_i2, s1_i3, s1_i4;
  reg [5:0] s2_v0, s2_v1, s2_v2;
  reg [3:0] s2_i0, s2_i1, s2_i2;
  reg [5:0] s3_v0, s3_v1;
  reg [3:0] s3_i0, s3_i1;

  reg s1_valid;
  reg s2_valid;
  reg s3_valid;

  reg [9:0] p0;
  reg [9:0] p1;
  reg [9:0] p2;
  reg [9:0] p3;
  reg [9:0] p4;
  reg [9:0] q0;
  reg [9:0] q1;
  reg [9:0] r0;
  wire [9:0] final_pair;

  assign final_pair = max_pair(s3_v0, s3_i0, s3_v1, s3_i1);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      s1_v0 <= 6'd0;
      s1_v1 <= 6'd0;
      s1_v2 <= 6'd0;
      s1_v3 <= 6'd0;
      s1_v4 <= 6'd0;
      s1_i0 <= 4'd0;
      s1_i1 <= 4'd0;
      s1_i2 <= 4'd0;
      s1_i3 <= 4'd0;
      s1_i4 <= 4'd0;
      s2_v0 <= 6'd0;
      s2_v1 <= 6'd0;
      s2_v2 <= 6'd0;
      s2_i0 <= 4'd0;
      s2_i1 <= 4'd0;
      s2_i2 <= 4'd0;
      s3_v0 <= 6'd0;
      s3_v1 <= 6'd0;
      s3_i0 <= 4'd0;
      s3_i1 <= 4'd0;
      max_idx <= 4'd0;
      s1_valid <= 1'b0;
      s2_valid <= 1'b0;
      s3_valid <= 1'b0;
      out_valid <= 1'b0;
      p0 <= 10'd0;
      p1 <= 10'd0;
      p2 <= 10'd0;
      p3 <= 10'd0;
      p4 <= 10'd0;
      q0 <= 10'd0;
      q1 <= 10'd0;
      r0 <= 10'd0;
    end else begin
      // Valid pipeline for deterministic handoff to UART control.
      s1_valid <= in_valid;
      s2_valid <= s1_valid;
      s3_valid <= s2_valid;
      out_valid <= s3_valid;

      p0 <= max_pair(class_score(scores, 4'd0), 4'd0, class_score(scores, 4'd1), 4'd1);
      p1 <= max_pair(class_score(scores, 4'd2), 4'd2, class_score(scores, 4'd3), 4'd3);
      p2 <= max_pair(class_score(scores, 4'd4), 4'd4, class_score(scores, 4'd5), 4'd5);
      p3 <= max_pair(class_score(scores, 4'd6), 4'd6, class_score(scores, 4'd7), 4'd7);
      p4 <= max_pair(class_score(scores, 4'd8), 4'd8, class_score(scores, 4'd9), 4'd9);

      s1_v0 <= p0[9:4];
      s1_i0 <= p0[3:0];
      s1_v1 <= p1[9:4];
      s1_i1 <= p1[3:0];
      s1_v2 <= p2[9:4];
      s1_i2 <= p2[3:0];
      s1_v3 <= p3[9:4];
      s1_i3 <= p3[3:0];
      s1_v4 <= p4[9:4];
      s1_i4 <= p4[3:0];

      q0 <= max_pair(s1_v0, s1_i0, s1_v1, s1_i1);
      q1 <= max_pair(s1_v2, s1_i2, s1_v3, s1_i3);

      s2_v0 <= q0[9:4];
      s2_i0 <= q0[3:0];
      s2_v1 <= q1[9:4];
      s2_i1 <= q1[3:0];
      s2_v2 <= s1_v4;
      s2_i2 <= s1_i4;

      r0 <= max_pair(s2_v0, s2_i0, s2_v1, s2_i1);

      s3_v0 <= r0[9:4];
      s3_i0 <= r0[3:0];
      s3_v1 <= s2_v2;
      s3_i1 <= s2_i2;

      max_idx <= final_pair[3:0];
    end
  end

endmodule
