module camera_read(
	input wire clk,
	output wire x_clock,
	input wire p_clock,
	input wire vsync,
	input wire href,
	input wire [7:0] p_data,
	output reg [15:0] pixel_data = 0,
	output reg pixel_valid = 0,
	output reg frame_done = 0,
	output [9:0] pix_x,
	output [9:0] pix_y
    );

	reg [7:0] first_byte, second_byte;
	reg [9:0] x_count = 0 , y_count = 0;
	reg start_of_frame = 0;
	reg [7:0] data;

	assign pix_x = x_count;
	assign pix_y = y_count;

	assign x_clock = clk;

	reg [1:0] FSM_state = 0;
        reg pixel_half = 0;

	localparam WAIT_FRAME_START = 0;
	localparam ROW_CAPTURE = 1;

	always@(posedge p_clock)
	begin

	  case(FSM_state)

	  WAIT_FRAME_START: begin //wait for VSYNC
	     FSM_state <= (!vsync) ? ROW_CAPTURE : WAIT_FRAME_START;
	     frame_done <= 0;
	     pixel_half <= 0;
             start_of_frame <= 1;
             x_count <= 0;
             y_count <= 0;
	  end

	  ROW_CAPTURE: begin
	     FSM_state <= vsync ? WAIT_FRAME_START : ROW_CAPTURE;
	     frame_done <= vsync;
	     pixel_valid <= (href && pixel_half);
	     if (href) begin
                 if (start_of_frame) begin
                    if (!pixel_half) begin
                      first_byte <= p_data;
                      data <= p_data;
                    end
                    else begin
                      start_of_frame <= 0;
                      second_byte <= p_data;
                    end
                 end
	         if (pixel_half) pixel_data[7:0] <= p_data;
	         else pixel_data[15:8] <= p_data;
	         if (pixel_half) x_count <= x_count + 1;
	         pixel_half <= ~ pixel_half;
	     end else begin
	       x_count <= 0;
	       if (x_count != 0) y_count <= y_count + 1;
             end
	  end

	  endcase
	end
endmodule
