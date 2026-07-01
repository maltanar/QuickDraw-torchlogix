// Top-level wrapper for QuickDraw logic network on GateMateA1-EVB
//
// Protocol (8N1 UART, default 115200 baud):
//   PC → FPGA : 98 bytes  (784 bits of binarized 28×28 image, LSB first)
//   FPGA → PC : 40 bytes  (320 bits = 10 × 32-bit signed scores, LSB first)
//
// The 'circuit' module is clocked/pipelined; scores are available after
// a 2-cycle latency from the last latched input byte.
//
// LED:  off during RECV, on during SEND (visual activity indicator)
// BTN:  active-low manual reset (hold to reset state machine)

`timescale 1ns/1ps

module quickdraw_top #(
    parameter CLK_FREQ  = 10_000_000,   // Hz  – must match board oscillator
    parameter BAUD_RATE = 115200        // bps – must match PC-side setting
) (
    input  wire clk_i,   // 10 MHz oscillator  (IO_SB_A8)
    input  wire but_i,   // button, active-low  (IO_SB_B7) – 0 = pressed = reset
    input  wire rx_i,    // UART RX from host   (IO_SA_A6)
    output wire tx_o,    // UART TX to host     (IO_SA_B6)
    output reg  led_o    // status LED          (IO_SB_B6)
);

    // -----------------------------------------------------------------------
    // Power-on reset + manual reset (button)
    //   por_sr shifts 1s in after power-up; rst_n asserts for first 4 cycles
    //   but_i=0 (button pressed) holds rst_n low (synchronous to clock)
    // -----------------------------------------------------------------------
    reg [3:0] por_sr = 4'd0;
    always @(posedge clk_i)
        por_sr <= {por_sr[2:0], 1'b1};
    wire rst_n = por_sr[3] & but_i;

    // -----------------------------------------------------------------------
    // UART receiver
    // -----------------------------------------------------------------------
    wire [7:0] rx_data;
    wire       rx_valid;

    uart_rx #(
        .CLK_FREQ  (CLK_FREQ),
        .BAUD_RATE (BAUD_RATE)
    ) u_rx (
        .clk   (clk_i),
        .rst_n (rst_n),
        .rx    (rx_i),
        .data  (rx_data),
        .valid (rx_valid)
    );

    // -----------------------------------------------------------------------
    // Inference circuit (clocked/pipelined - auto-generated)
    // -----------------------------------------------------------------------
    reg  [783:0] inp_reg;
    wire [319:0] scores_flat;

    circuit u_circuit (
        .clk        (clk_i),
        .reset      (~rst_n),
        .inp        (inp_reg),
        .scores_flat(scores_flat)
    );

    // -----------------------------------------------------------------------
    // Control state machine
    // -----------------------------------------------------------------------
    localparam [1:0] S_RECV = 2'd0;   // receiving 98 bytes from PC
    localparam [1:0] S_WAIT = 2'd1;   // wait for circuit pipeline latency
    localparam [1:0] S_SEND = 2'd2;   // sending  40 bytes to PC

    reg [1:0] state;
    reg [6:0] byte_cnt;   // 0..97 in RECV, 0..39 in SEND
    reg [1:0] wait_cnt;   // cycles remaining before SEND (uses value 2)

    // TX wiring: combinational write-strobe keeps handshake glitch-free
    wire       tx_busy;
    wire       tx_wr  = (state == S_SEND) & ~tx_busy;
    wire [7:0] tx_din = scores_flat[byte_cnt * 8 +: 8];

    always @(posedge clk_i or negedge rst_n) begin
        if (!rst_n) begin
            state    <= S_RECV;
            byte_cnt <= 7'd0;
            wait_cnt <= 2'd0;
            inp_reg  <= 784'd0;
            led_o    <= 1'b0;
        end else begin
            case (state)

                S_RECV: begin
                    led_o <= 1'b0;
                    if (rx_valid) begin
                        inp_reg[byte_cnt * 8 +: 8] <= rx_data;
                        if (byte_cnt == 7'd97) begin
                            // All 98 bytes received -> wait 2 cycles for pipeline
                            state    <= S_WAIT;
                            wait_cnt <= 2'd2;
                            byte_cnt <= 7'd0;
                        end else
                            byte_cnt <= byte_cnt + 7'd1;
                    end
                end

                S_WAIT: begin
                    led_o <= 1'b0;
                    if (wait_cnt == 2'd1) begin
                        state <= S_SEND;
                    end
                    wait_cnt <= wait_cnt - 2'd1;
                end

                S_SEND: begin
                    led_o <= 1'b1;
                    // tx_wr fires combinationally whenever !tx_busy;
                    // only advance byte_cnt / state after TX accepts the byte
                    if (~tx_busy) begin
                        if (byte_cnt == 7'd39) begin
                            // Last byte queued → wait for next image
                            state    <= S_RECV;
                            byte_cnt <= 7'd0;
                        end else
                            byte_cnt <= byte_cnt + 7'd1;
                    end
                end

                default: begin
                    state    <= S_RECV;
                    byte_cnt <= 7'd0;
                    wait_cnt <= 2'd0;
                    led_o    <= 1'b0;
                end

            endcase
        end
    end

    // -----------------------------------------------------------------------
    // UART transmitter
    // -----------------------------------------------------------------------
    uart_tx #(
        .CLK_FREQ  (CLK_FREQ),
        .BAUD_RATE (BAUD_RATE)
    ) u_tx (
        .clk   (clk_i),
        .rst_n (rst_n),
        .din   (tx_din),
        .wr    (tx_wr),
        .busy  (tx_busy),
        .tx    (tx_o)
    );

endmodule
