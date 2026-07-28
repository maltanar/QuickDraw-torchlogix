module renderer (
  input  wire       clk,
  input  wire       rst_n,

  input  wire       s_valid,
  input  wire       s_mono,
  input  wire       s_tlast,
  input  wire [7:0] s_x,
  input  wire [7:0] s_y,

  input  wire [9:0] roi_cx,
  input  wire [8:0] roi_cy,
  input  wire [1:0] roi_size_sel,
  input  wire [3:0] label_idx,

  output reg        m_we,
  output reg [15:0] m_waddr,
  output reg [11:0] m_rgb444
);

  localparam [9:0] BORDER_THICK = 10'd2;
  localparam [9:0] TEXT_X_OFF = 10'd6;
  localparam [8:0] TEXT_Y_OFF = 9'd6;

  function [3:0] font4x4_row;
    input [7:0] ch;
    input [1:0] row;
    begin
      case (ch)
        "0": case (row)
          2'd0: font4x4_row = 4'b0110;
          2'd1: font4x4_row = 4'b1001;
          2'd2: font4x4_row = 4'b1001;
          default: font4x4_row = 4'b0110;
        endcase
        "1": case (row)
          2'd0: font4x4_row = 4'b0010;
          2'd1: font4x4_row = 4'b0110;
          2'd2: font4x4_row = 4'b0010;
          default: font4x4_row = 4'b0111;
        endcase
        "2": case (row)
          2'd0: font4x4_row = 4'b1110;
          2'd1: font4x4_row = 4'b0001;
          2'd2: font4x4_row = 4'b0110;
          default: font4x4_row = 4'b1111;
        endcase
        "3": case (row)
          2'd0: font4x4_row = 4'b1110;
          2'd1: font4x4_row = 4'b0010;
          2'd2: font4x4_row = 4'b0001;
          default: font4x4_row = 4'b1110;
        endcase
        "4": case (row)
          2'd0: font4x4_row = 4'b1001;
          2'd1: font4x4_row = 4'b1001;
          2'd2: font4x4_row = 4'b1111;
          default: font4x4_row = 4'b0001;
        endcase
        "5": case (row)
          2'd0: font4x4_row = 4'b1111;
          2'd1: font4x4_row = 4'b1110;
          2'd2: font4x4_row = 4'b0001;
          default: font4x4_row = 4'b1110;
        endcase
        "6": case (row)
          2'd0: font4x4_row = 4'b0111;
          2'd1: font4x4_row = 4'b1000;
          2'd2: font4x4_row = 4'b1110;
          default: font4x4_row = 4'b0110;
        endcase
        "7": case (row)
          2'd0: font4x4_row = 4'b1111;
          2'd1: font4x4_row = 4'b0001;
          2'd2: font4x4_row = 4'b0010;
          default: font4x4_row = 4'b0100;
        endcase
        "8": case (row)
          2'd0: font4x4_row = 4'b0110;
          2'd1: font4x4_row = 4'b1111;
          2'd2: font4x4_row = 4'b1001;
          default: font4x4_row = 4'b0110;
        endcase
        "9": case (row)
          2'd0: font4x4_row = 4'b0110;
          2'd1: font4x4_row = 4'b0111;
          2'd2: font4x4_row = 4'b0001;
          default: font4x4_row = 4'b1110;
        endcase
        "A": case (row)
          2'd0: font4x4_row = 4'b0110;
          2'd1: font4x4_row = 4'b1001;
          2'd2: font4x4_row = 4'b1111;
          default: font4x4_row = 4'b1001;
        endcase
        "B": case (row)
          2'd0: font4x4_row = 4'b1110;
          2'd1: font4x4_row = 4'b1001;
          2'd2: font4x4_row = 4'b1110;
          default: font4x4_row = 4'b1001;
        endcase
        "C": case (row)
          2'd0: font4x4_row = 4'b0111;
          2'd1: font4x4_row = 4'b1000;
          2'd2: font4x4_row = 4'b1000;
          default: font4x4_row = 4'b0111;
        endcase
        "D": case (row)
          2'd0: font4x4_row = 4'b1110;
          2'd1: font4x4_row = 4'b1001;
          2'd2: font4x4_row = 4'b1001;
          default: font4x4_row = 4'b1110;
        endcase
        "E": case (row)
          2'd0: font4x4_row = 4'b1111;
          2'd1: font4x4_row = 4'b1110;
          2'd2: font4x4_row = 4'b1000;
          default: font4x4_row = 4'b1111;
        endcase
        "F": case (row)
          2'd0: font4x4_row = 4'b1111;
          2'd1: font4x4_row = 4'b1110;
          2'd2: font4x4_row = 4'b1000;
          default: font4x4_row = 4'b1000;
        endcase
        default: font4x4_row = 4'b0000;
      endcase
    end
  endfunction

  wire [9:0] rect_half =
    (roi_size_sel == 2'd0) ? 10'd60 :
    (roi_size_sel == 2'd1) ? 10'd120 :
                             10'd240;

  wire [9:0] rect_left = roi_cx - rect_half;
  wire [9:0] rect_right = roi_cx + rect_half - 10'd1;
  wire [8:0] rect_top = roi_cy - rect_half[8:0];
  wire [8:0] rect_bottom = roi_cy + rect_half[8:0] - 9'd1;

  wire [9:0] vga_x = {2'b00, s_x} << 2;
  wire [8:0] vga_y = (9'd255 - {1'b0, s_y}) << 1;

  // Each capture pixel covers a 4x2 region in VGA space. Use overlap tests
  // against that cell so ROI edges are not dropped between sample points.
  wire [9:0] cell_x0 = vga_x;
  wire [9:0] cell_x1 = vga_x + 10'd3;
  wire [8:0] cell_y0 = vga_y;
  wire [8:0] cell_y1 = vga_y + 9'd1;

  wire [9:0] rect_left_edge_hi = rect_left + BORDER_THICK - 10'd1;
  wire [9:0] rect_right_edge_lo = rect_right - BORDER_THICK + 10'd1;
  wire [8:0] rect_top_edge_hi = rect_top + BORDER_THICK[8:0] - 9'd1;
  wire [8:0] rect_bottom_edge_lo = rect_bottom - BORDER_THICK[8:0] + 9'd1;

  wire ov_x_rect = (cell_x1 >= rect_left) && (cell_x0 <= rect_right);
  wire ov_y_rect = (cell_y1 >= rect_top) && (cell_y0 <= rect_bottom);

  wire on_left_edge =
    (cell_x1 >= rect_left) && (cell_x0 <= rect_left_edge_hi) && ov_y_rect;
  wire on_right_edge =
    (cell_x1 >= rect_right_edge_lo) && (cell_x0 <= rect_right) && ov_y_rect;
  wire on_top_edge =
    (cell_y1 >= rect_top) && (cell_y0 <= rect_top_edge_hi) && ov_x_rect;
  wire on_bottom_edge =
    (cell_y1 >= rect_bottom_edge_lo) && (cell_y0 <= rect_bottom) && ov_x_rect;

  wire draw_border = on_left_edge || on_right_edge || on_top_edge || on_bottom_edge;

  wire [7:0] label_char =
    (label_idx < 4'd10) ? (8'd48 + {4'd0, label_idx}) : (8'd55 + {4'd0, label_idx});

  wire [9:0] text_x0 = rect_left + TEXT_X_OFF;
  wire [8:0] text_y0 = rect_top + TEXT_Y_OFF;
  wire text_in_bounds =
    (vga_x >= text_x0) && (vga_x < (text_x0 + 10'd4)) &&
    (vga_y >= text_y0) && (vga_y < (text_y0 + 9'd4));

  wire [1:0] text_rel_x = vga_x[1:0];
  wire [1:0] text_rel_y = vga_y - text_y0;
  wire [3:0] text_row_bits = font4x4_row(label_char, text_rel_y);
  wire text_pixel = text_in_bounds && text_row_bits[3 - text_rel_x];

  wire [3:0] bw_level = s_mono ? 4'hF : 4'h0;
  wire [11:0] mono_rgb = {bw_level, bw_level, bw_level};

  wire [11:0] out_rgb = draw_border ? 12'hF00 : (text_pixel ? 12'h0F0 : mono_rgb);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      m_we    <= 1'b0;
      m_waddr <= 16'd0;
      m_rgb444 <= 12'h000;
    end else begin
      m_we    <= s_valid;
      m_waddr <= {s_y, s_x};
      m_rgb444 <= out_rgb;
    end
  end

endmodule
