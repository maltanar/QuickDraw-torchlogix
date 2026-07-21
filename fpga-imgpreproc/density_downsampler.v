
module density_downsampler #(
    parameter IN_WIDTH = 640,
    parameter IN_HEIGHT = 480,
    parameter OUT_WIDTH = 28,
    parameter OUT_HEIGHT = 28
) (
    input wire clk,
    input wire rst_n,

    // Runtime Configuration Inputs
    input wire [7:0] ink_threshold_in,
    input wire [15:0] density_threshold_in,

    // AXI-Stream Input (8-bit grayscale)
    input wire [7:0] s_axis_tdata,
    input wire s_axis_tvalid,
    output wire s_axis_tready,

    // AXI-Stream Output (1-bit B/W)
    output wire [0:0] m_axis_tdata,
    output wire m_axis_tvalid,
    input wire m_axis_tready
);

    // Coordinate trackers
    reg [15:0] x_in;
    reg [15:0] y_in;
    reg [15:0] x_out;
    
    // Fractional error counters for DDA boundary calculation
    reg [31:0] err_x;
    reg [31:0] err_y;
    
    // RAM to hold the ink counts for the current row of blocks
    reg [15:0] block_accum [0:OUT_WIDTH-1];
    
    // Glitch-free configuration registers
    reg [7:0] ink_thresh_reg;
    reg [15:0] den_thresh_reg;
    
    // State Machine
    localparam STATE_ACCUM = 1'b0;
    localparam STATE_DRAIN = 1'b1;
    reg state;
    reg [15:0] drain_idx;

    // AXI Stream mappings
    assign s_axis_tready = (state == STATE_ACCUM);
    assign m_axis_tvalid = (state == STATE_DRAIN);
    
    // ---------------------------------------------------------
    // Configuration Latching Logic
    // ---------------------------------------------------------
    wire start_of_frame = (x_in == 0 && y_in == 0);
    wire pixel_accepted = (s_axis_tvalid && s_axis_tready);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ink_thresh_reg <= 8'd100;
            den_thresh_reg <= 16'd5;
        end else if (state == STATE_ACCUM && start_of_frame && pixel_accepted) begin
            // Latch the external inputs precisely as the new frame begins
            ink_thresh_reg <= ink_threshold_in;
            den_thresh_reg <= density_threshold_in;
        end
    end

    // Use the live input on pixel (0,0) so the combinational logic doesn't lag by 1 cycle,
    // then switch to the latched register for the rest of the frame to prevent glitching.
    wire [7:0] effective_ink_thresh = (start_of_frame) ? ink_threshold_in : ink_thresh_reg;
    
    // ---------------------------------------------------------
    // Core Logic
    // ---------------------------------------------------------
    // Density threshold is only checked during STATE_DRAIN, so the register is fully settled
    assign m_axis_tdata = (block_accum[drain_idx] >= den_thresh_reg) ? 1'b0 : 1'b1;

    wire is_ink = (s_axis_tdata <= effective_ink_thresh);
    wire last_x = (x_in == IN_WIDTH - 1);
    wire last_y = (y_in == IN_HEIGHT - 1);
    
    wire [31:0] next_err_x = err_x + OUT_WIDTH;
    wire step_x = (next_err_x >= IN_WIDTH);
    
    wire [31:0] next_err_y = err_y + OUT_HEIGHT;
    wire step_y = (next_err_y >= IN_HEIGHT);

    integer i;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= STATE_ACCUM;
            x_in <= 0;
            y_in <= 0;
            x_out <= 0;
            err_x <= 0;
            err_y <= 0;
            drain_idx <= 0;
            for (i = 0; i < OUT_WIDTH; i = i + 1) begin
                block_accum[i] <= 0;
            end
        end else begin
            if (state == STATE_ACCUM) begin
                if (pixel_accepted) begin
                    // 1. Accumulate ink pixel for current block
                    if (is_ink) begin
                        block_accum[x_out] <= block_accum[x_out] + 1;
                    end
                    
                    // 2. Advance X coordinate
                    if (last_x) begin
                        x_in <= 0;
                        x_out <= 0;
                        err_x <= 0;
                        
                        // 3. Advance Y coordinate
                        if (last_y) begin
                            y_in <= 0;
                            err_y <= 0;
                            state <= STATE_DRAIN; // End of image, drain final block row
                        end else begin
                            y_in <= y_in + 1;
                            if (step_y) begin
                                err_y <= next_err_y - IN_HEIGHT;
                                state <= STATE_DRAIN; // Block row boundary reached, output it
                            end else begin
                                err_y <= next_err_y;
                            end
                        end
                    end else begin
                        x_in <= x_in + 1;
                        if (step_x) begin
                            x_out <= x_out + 1;
                            err_x <= next_err_x - IN_WIDTH;
                        end else begin
                            err_x <= next_err_x;
                        end
                    end
                end
            end else if (state == STATE_DRAIN) begin
                if (m_axis_tready) begin
                    block_accum[drain_idx] <= 0;
                    
                    if (drain_idx == OUT_WIDTH - 1) begin
                        drain_idx <= 0;
                        state <= STATE_ACCUM;
                    end else begin
                        drain_idx <= drain_idx + 1;
                    end
                end
            end
        end
    end
endmodule
