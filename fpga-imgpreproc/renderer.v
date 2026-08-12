module renderer (
  input  wire       clk,
  input  wire       rst_n,

  input  wire       s_valid,
  input  wire       s_mono,
  input  wire       s_tlast,
  input  wire [9:0] s_x,
  input  wire [9:0] s_y,

  input  wire [9:0] roi_cx,
  input  wire [8:0] roi_cy,
  input  wire [1:0] roi_size_sel,
  input  wire [3:0] label_idx,

  output reg        m_we,
  output reg [18:0] m_waddr,
  output reg [11:0] m_rgb444
);

  localparam [9:0] BORDER_THICK = 10'd2;
  localparam [9:0] TEXT_X_OFF = 10'd6;
  localparam [8:0] TEXT_Y_OFF = 9'd6;
  localparam [3:0] MAX_NAME_LEN = 4'd11;
  localparam [2:0] GLYPH_W = 3'd4;
  localparam [2:0] GLYPH_H = 3'd4;
  localparam [2:0] GLYPH_ADV = 3'd5;
  localparam [9:0] TEXT_BLOCK_H = 10'd8;

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
        "_": case (row)
          2'd0: font4x4_row = 4'b0000;
          2'd1: font4x4_row = 4'b0000;
          2'd2: font4x4_row = 4'b0000;
          default: font4x4_row = 4'b1111;
        endcase
        "a": case (row)
          2'd0: font4x4_row = 4'b0110;
          2'd1: font4x4_row = 4'b0001;
          2'd2: font4x4_row = 4'b0111;
          default: font4x4_row = 4'b0111;
        endcase
        "b": case (row)
          2'd0: font4x4_row = 4'b1000;
          2'd1: font4x4_row = 4'b1110;
          2'd2: font4x4_row = 4'b1001;
          default: font4x4_row = 4'b1110;
        endcase
        "c": case (row)
          2'd0: font4x4_row = 4'b0111;
          2'd1: font4x4_row = 4'b1000;
          2'd2: font4x4_row = 4'b1000;
          default: font4x4_row = 4'b0111;
        endcase
        "e": case (row)
          2'd0: font4x4_row = 4'b0111;
          2'd1: font4x4_row = 4'b1110;
          2'd2: font4x4_row = 4'b1000;
          default: font4x4_row = 4'b0111;
        endcase
        "f": case (row)
          2'd0: font4x4_row = 4'b0111;
          2'd1: font4x4_row = 4'b1110;
          2'd2: font4x4_row = 4'b1000;
          default: font4x4_row = 4'b1000;
        endcase
        "g": case (row)
          2'd0: font4x4_row = 4'b0111;
          2'd1: font4x4_row = 4'b1000;
          2'd2: font4x4_row = 4'b1011;
          default: font4x4_row = 4'b0111;
        endcase
        "h": case (row)
          2'd0: font4x4_row = 4'b1001;
          2'd1: font4x4_row = 4'b1111;
          2'd2: font4x4_row = 4'b1001;
          default: font4x4_row = 4'b1001;
        endcase
        "i": case (row)
          2'd0: font4x4_row = 4'b0111;
          2'd1: font4x4_row = 4'b0010;
          2'd2: font4x4_row = 4'b0010;
          default: font4x4_row = 4'b0111;
        endcase
        "k": case (row)
          2'd0: font4x4_row = 4'b1001;
          2'd1: font4x4_row = 4'b1010;
          2'd2: font4x4_row = 4'b1100;
          default: font4x4_row = 4'b1010;
        endcase
        "l": case (row)
          2'd0: font4x4_row = 4'b1000;
          2'd1: font4x4_row = 4'b1000;
          2'd2: font4x4_row = 4'b1000;
          default: font4x4_row = 4'b1111;
        endcase
        "m": case (row)
          2'd0: font4x4_row = 4'b1001;
          2'd1: font4x4_row = 4'b1111;
          2'd2: font4x4_row = 4'b1111;
          default: font4x4_row = 4'b1001;
        endcase
        "n": case (row)
          2'd0: font4x4_row = 4'b1001;
          2'd1: font4x4_row = 4'b1101;
          2'd2: font4x4_row = 4'b1011;
          default: font4x4_row = 4'b1001;
        endcase
        "o": case (row)
          2'd0: font4x4_row = 4'b0110;
          2'd1: font4x4_row = 4'b1001;
          2'd2: font4x4_row = 4'b1001;
          default: font4x4_row = 4'b0110;
        endcase
        "p": case (row)
          2'd0: font4x4_row = 4'b1110;
          2'd1: font4x4_row = 4'b1001;
          2'd2: font4x4_row = 4'b1110;
          default: font4x4_row = 4'b1000;
        endcase
        "r": case (row)
          2'd0: font4x4_row = 4'b1110;
          2'd1: font4x4_row = 4'b1001;
          2'd2: font4x4_row = 4'b1110;
          default: font4x4_row = 4'b1010;
        endcase
        "s": case (row)
          2'd0: font4x4_row = 4'b0111;
          2'd1: font4x4_row = 4'b0110;
          2'd2: font4x4_row = 4'b0001;
          default: font4x4_row = 4'b1110;
        endcase
        "t": case (row)
          2'd0: font4x4_row = 4'b1111;
          2'd1: font4x4_row = 4'b0010;
          2'd2: font4x4_row = 4'b0010;
          default: font4x4_row = 4'b0010;
        endcase
        "y": case (row)
          2'd0: font4x4_row = 4'b1001;
          2'd1: font4x4_row = 4'b0110;
          2'd2: font4x4_row = 4'b0010;
          default: font4x4_row = 4'b0010;
        endcase
        default: font4x4_row = 4'b0000;
      endcase
    end
  endfunction

  reg [8*MAX_NAME_LEN-1:0] CLASS_NAME_TABLE [0:9];
  initial begin
    CLASS_NAME_TABLE[0] = "bicycle    ";
    CLASS_NAME_TABLE[1] = "eyeglasses ";
    CLASS_NAME_TABLE[2] = "car        ";
    CLASS_NAME_TABLE[3] = "eye        ";
    CLASS_NAME_TABLE[4] = "tree       ";
    CLASS_NAME_TABLE[5] = "apple      ";
    CLASS_NAME_TABLE[6] = "smiley_face";
    CLASS_NAME_TABLE[7] = "cell_phone ";
    CLASS_NAME_TABLE[8] = "airplane   ";
    CLASS_NAME_TABLE[9] = "book       ";
  end

  function [7:0] class_char;
    input [3:0] cls;
    input [3:0] pos;
    reg [8*MAX_NAME_LEN-1:0] class_name;
    begin
      class_char = 8'h20;
      class_name = {8*MAX_NAME_LEN{1'b0}};
      if (cls <= 4'd9) begin
        class_name = CLASS_NAME_TABLE[cls];
        if (pos < MAX_NAME_LEN) begin
          class_char = class_name[((MAX_NAME_LEN - 4'd1 - pos) * 8) +: 8];
        end
      end
    end
  endfunction

  // 1:1 VGA/camera mapping keeps ROI square with symmetric half-extents.
  wire [9:0] rect_half_x_next =
    (roi_size_sel == 2'd0) ? 10'd14  :
    (roi_size_sel == 2'd1) ? 10'd28  : 10'd56;
  wire [8:0] rect_half_y_next =
    (roi_size_sel == 2'd0) ? 9'd14 :
    (roi_size_sel == 2'd1) ? 9'd28  : 9'd56;

  reg [9:0] rect_left_r;
  reg [9:0] rect_right_r;
  reg [8:0] rect_top_r;
  reg [8:0] rect_bottom_r;
  reg [9:0] text_x0_r;
  reg [8:0] text_y0_r;

  wire [9:0] text_left_next = roi_cx - rect_half_x_next;
  wire [8:0] text_top_next =
    (roi_cy > ({1'b0, rect_half_y_next} + TEXT_BLOCK_H + TEXT_Y_OFF[8:0])) ?
      (roi_cy - rect_half_y_next - TEXT_BLOCK_H - TEXT_Y_OFF[8:0]) : 9'd0;

  wire [9:0] rect_left   = rect_left_r;
  wire [9:0] rect_right  = rect_right_r;
  wire [8:0] rect_top    = rect_top_r;
  wire [8:0] rect_bottom = rect_bottom_r;

  wire [9:0] vga_x = s_x;
  wire [9:0] vga_y = s_y;

  // 1:1 pixel mapping between captured mono stream and VGA space.
  wire [9:0] cell_x0 = vga_x;
  wire [9:0] cell_x1 = vga_x;
  wire [9:0] cell_y0 = vga_y;
  wire [9:0] cell_y1 = vga_y;

  wire [9:0] rect_left_edge_hi = rect_left + BORDER_THICK - 10'd1;
  wire [9:0] rect_right_edge_lo = rect_right - BORDER_THICK + 10'd1;
  wire [8:0] rect_top_edge_hi = rect_top + BORDER_THICK[8:0] - 9'd1;
  wire [8:0] rect_bottom_edge_lo = rect_bottom - BORDER_THICK[8:0] + 9'd1;

  wire ov_x_rect = (cell_x1 >= rect_left) && (cell_x0 <= rect_right);
  wire ov_y_rect = (cell_y1 >= {1'b0, rect_top}) && (cell_y0 <= {1'b0, rect_bottom});

  wire on_left_edge =
    (cell_x1 >= rect_left) && (cell_x0 <= rect_left_edge_hi) && ov_y_rect;
  wire on_right_edge =
    (cell_x1 >= rect_right_edge_lo) && (cell_x0 <= rect_right) && ov_y_rect;
  wire on_top_edge =
    (cell_y1 >= {1'b0, rect_top}) && (cell_y0 <= {1'b0, rect_top_edge_hi}) && ov_x_rect;
  wire on_bottom_edge =
    (cell_y1 >= {1'b0, rect_bottom_edge_lo}) && (cell_y0 <= {1'b0, rect_bottom}) && ov_x_rect;

  wire draw_border = on_left_edge || on_right_edge || on_top_edge || on_bottom_edge;

  // Text rasterization in 1:1 VGA pixels.
  wire [9:0] text_x0 = text_x0_r;
  wire [8:0] text_y0 = text_y0_r;
  wire [7:0] text_w_cells = ({4'd0, MAX_NAME_LEN} * {5'd0, GLYPH_ADV});
  wire [9:0] text_rel_x_cells_full = (vga_x - text_x0);
  wire [9:0] text_rel_y_cells_full = (vga_y - {1'b0, text_y0});
  wire [7:0] text_rel_x_cells = text_rel_x_cells_full[7:0];
  wire text_in_bounds =
    (vga_x >= text_x0) &&
    (vga_y >= text_y0) &&
    (text_rel_x_cells_full < {2'd0, text_w_cells}) &&
    (text_rel_y_cells_full < {7'd0, GLYPH_H});

  // Exact for 0..54 (the valid text cell range): floor(x/5) = (x*13)>>6.
  // Gate with text_in_bounds so out-of-range values do not matter.
  wire [7:0] text_rel_x_cells_active = text_in_bounds ? text_rel_x_cells : 8'd0;
  wire [11:0] text_mul13 =
    ({4'd0, text_rel_x_cells_active} << 3) +
    ({4'd0, text_rel_x_cells_active} << 2) +
    {4'd0, text_rel_x_cells_active};
  wire [7:0] text_char_idx_full = text_mul13[11:6];
  wire [7:0] text_col_full =
    text_rel_x_cells_active - ((text_char_idx_full << 2) + text_char_idx_full);
  wire [3:0] text_char_idx = text_char_idx_full[3:0];
  wire [2:0] text_col = text_col_full[2:0];
  wire [1:0] text_row = text_rel_y_cells_full[1:0];
  wire text_col_is_glyph = (text_col < GLYPH_W);

  // Pipeline stage to break the long path through ROI math -> text decode -> color mux.
  reg        p_valid;
  reg  [9:0] p_x;
  reg  [9:0] p_y;
  reg        p_mono;
  reg        p_draw_border;
  reg        p_text_in_bounds;
  reg        p_text_col_is_glyph;
  reg  [3:0] p_text_char_idx;
  reg  [2:0] p_text_col;
  reg  [1:0] p_text_row;
  reg  [3:0] p_label_idx;

  wire [7:0] p_text_char = class_char(p_label_idx, p_text_char_idx);
  wire [3:0] p_text_row_bits = font4x4_row(p_text_char, p_text_row);
  wire p_text_pixel = p_text_in_bounds && p_text_col_is_glyph && (p_text_char != 8'h20) &&
                      p_text_row_bits[3 - p_text_col[1:0]];

  wire [3:0] p_bw_level = p_mono ? 4'hF : 4'h0;
  wire [11:0] p_mono_rgb = {p_bw_level, p_bw_level, p_bw_level};
  wire [11:0] p_out_rgb = p_draw_border ? 12'hF00 : (p_text_pixel ? 12'h0F0 : p_mono_rgb);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      rect_left_r <= 10'd0;
      rect_right_r <= 10'd0;
      rect_top_r <= 9'd0;
      rect_bottom_r <= 9'd0;
      text_x0_r <= 10'd0;
      text_y0_r <= 9'd0;

      p_valid <= 1'b0;
      p_x <= 10'd0;
      p_y <= 10'd0;
      p_mono <= 1'b0;
      p_draw_border <= 1'b0;
      p_text_in_bounds <= 1'b0;
      p_text_col_is_glyph <= 1'b0;
      p_text_char_idx <= 4'd0;
      p_text_col <= 3'd0;
      p_text_row <= 2'd0;
      p_label_idx <= 4'd0;
      m_we    <= 1'b0;
      m_waddr <= 19'd0;
      m_rgb444 <= 12'h000;
    end else begin
      rect_left_r <= roi_cx - rect_half_x_next;
      rect_right_r <= roi_cx + rect_half_x_next - 10'd1;
      rect_top_r <= roi_cy - rect_half_y_next;
      rect_bottom_r <= roi_cy + rect_half_y_next - 9'd1;
      text_x0_r <= text_left_next + TEXT_X_OFF;
      text_y0_r <= text_top_next;

      p_valid <= s_valid;
      p_x <= s_x;
      p_y <= s_y;
      p_mono <= s_mono;
      p_draw_border <= draw_border;
      p_text_in_bounds <= text_in_bounds;
      p_text_col_is_glyph <= text_col_is_glyph;
      p_text_char_idx <= text_char_idx;
      p_text_col <= text_col;
      p_text_row <= text_row;
      p_label_idx <= label_idx;

      m_we    <= p_valid;
      m_waddr <= ({10'd0, p_y} << 9) + ({10'd0, p_y} << 7) + p_x;
      m_rgb444 <= p_out_rgb;
    end
  end

endmodule
