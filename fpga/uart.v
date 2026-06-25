// Simple UART TX and RX modules for GateMateA1-EVB
// 8N1 format (8 data bits, no parity, 1 stop bit)

// ---------------------------------------------------------------------------
// UART Receiver
// ---------------------------------------------------------------------------
module uart_rx #(
    parameter CLK_FREQ  = 10_000_000,
    parameter BAUD_RATE = 115200
) (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       rx,
    output reg  [7:0] data,
    output reg        valid   // 1-cycle pulse when a byte is received
);
    localparam [15:0] CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;
    localparam [15:0] HALF_BIT     = CLKS_PER_BIT / 2;

    // Two-FF metastability synchronizer for RX
    reg rx_s1, rx_s2;
    always @(posedge clk) begin
        rx_s1 <= rx;
        rx_s2 <= rx_s1;
    end

    localparam [1:0] S_IDLE  = 2'd0;
    localparam [1:0] S_START = 2'd1;
    localparam [1:0] S_DATA  = 2'd2;
    localparam [1:0] S_STOP  = 2'd3;

    reg [1:0]  state;
    reg [15:0] cnt;
    reg [2:0]  bit_idx;
    reg [7:0]  shift;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state   <= S_IDLE;
            cnt     <= 16'd0;
            bit_idx <= 3'd0;
            shift   <= 8'd0;
            data    <= 8'd0;
            valid   <= 1'b0;
        end else begin
            valid <= 1'b0;
            case (state)
                S_IDLE: begin
                    if (!rx_s2) begin        // falling edge = start bit
                        state <= S_START;
                        cnt   <= 16'd0;
                    end
                end

                S_START: begin
                    if (cnt == HALF_BIT - 16'd1) begin
                        // Sample middle of start bit
                        if (!rx_s2) begin   // still low → valid start
                            state   <= S_DATA;
                            bit_idx <= 3'd0;
                            cnt     <= 16'd0;
                        end else begin
                            state <= S_IDLE; // glitch, ignore
                        end
                    end else
                        cnt <= cnt + 16'd1;
                end

                S_DATA: begin
                    if (cnt == CLKS_PER_BIT - 16'd1) begin
                        // LSB first: shift in from MSB side, correct order builds up
                        shift   <= {rx_s2, shift[7:1]};
                        cnt     <= 16'd0;
                        if (bit_idx == 3'd7)
                            state <= S_STOP;
                        else
                            bit_idx <= bit_idx + 3'd1;
                    end else
                        cnt <= cnt + 16'd1;
                end

                S_STOP: begin
                    if (cnt == CLKS_PER_BIT - 16'd1) begin
                        if (rx_s2) begin    // valid stop bit (high)
                            data  <= shift;
                            valid <= 1'b1;
                        end
                        state <= S_IDLE;
                        cnt   <= 16'd0;
                    end else
                        cnt <= cnt + 16'd1;
                end
            endcase
        end
    end
endmodule


// ---------------------------------------------------------------------------
// UART Transmitter
// ---------------------------------------------------------------------------
// Protocol: drive tx_wr high for one cycle with din valid when busy=0.
// The module will transmit: start(0), d0..d7, stop(1).
module uart_tx #(
    parameter CLK_FREQ  = 10_000_000,
    parameter BAUD_RATE = 115200
) (
    input  wire       clk,
    input  wire       rst_n,
    input  wire [7:0] din,
    input  wire       wr,    // write strobe: pulse high for 1 cycle when !busy
    output reg        busy,  // high while frame is being transmitted
    output reg        tx
);
    localparam [15:0] CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;

    reg [15:0] cnt;
    reg [3:0]  bit_idx;  // 0..9: 8 data bits + stop bit (start bit sent on wr edge)
    reg [7:0]  data_r;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tx      <= 1'b1;
            busy    <= 1'b0;
            cnt     <= 16'd0;
            bit_idx <= 4'd0;
            data_r  <= 8'd0;
        end else if (!busy) begin
            tx <= 1'b1;
            if (wr) begin
                data_r  <= din;
                tx      <= 1'b0;   // drive start bit immediately
                busy    <= 1'b1;
                cnt     <= 16'd0;
                bit_idx <= 4'd0;
            end
        end else begin
            if (cnt == CLKS_PER_BIT - 16'd1) begin
                cnt <= 16'd0;
                if (bit_idx < 4'd8) begin
                    // Data bits 0..7 (LSB first)
                    tx      <= data_r[bit_idx[2:0]];
                    bit_idx <= bit_idx + 4'd1;
                end else if (bit_idx == 4'd8) begin
                    // Stop bit
                    tx      <= 1'b1;
                    bit_idx <= 4'd9;
                end else begin
                    // Stop bit complete → idle
                    busy <= 1'b0;
                end
            end else
                cnt <= cnt + 16'd1;
        end
    end
endmodule
