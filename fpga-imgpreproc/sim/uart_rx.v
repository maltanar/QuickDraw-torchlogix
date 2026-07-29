`timescale 1ns/1ps

module uart_rx #(
    parameter CLK_FREQ = 25_000_000,
    parameter BAUD_RATE = 115_200
) (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       rx,
    output reg [7:0]  data,
    output reg        valid
);

  localparam CYCLES_PER_BIT = CLK_FREQ / BAUD_RATE;
  
  reg [2:0] state;
  reg [15:0] bit_count;
  reg [3:0] bit_index;
  reg [7:0] shift_reg;
  reg rx_prev;
  
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state <= 3'd0;
      bit_count <= 16'd0;
      bit_index <= 4'd0;
      shift_reg <= 8'd0;
      data <= 8'd0;
      valid <= 1'b0;
      rx_prev <= 1'b1;
    end else begin
      rx_prev <= rx;
      valid <= 1'b0;
      
      case (state)
        3'd0: begin
          // Idle state - wait for start bit (falling edge)
          if (rx_prev && !rx) begin
            bit_count <= CYCLES_PER_BIT / 2;  // Half bit to sample middle
            bit_index <= 4'd0;
            state <= 3'd1;
          end
        end
        
        3'd1: begin
          // Sampling state
          if (bit_count == 16'd0) begin
            if (bit_index < 4'd8) begin
              shift_reg <= {rx, shift_reg[7:1]};
              bit_index <= bit_index + 1;
              bit_count <= CYCLES_PER_BIT;
            end else begin
              // Stop bit - check for validity
              data <= shift_reg;
              valid <= 1'b1;
              state <= 3'd0;
            end
          end else begin
            bit_count <= bit_count - 1;
          end
        end
      endcase
    end
  end

endmodule
