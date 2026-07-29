`timescale 1ns/1ps

module uart_tx #(
    parameter CLK_FREQ = 25_000_000,
    parameter BAUD_RATE = 115_200
) (
    input  wire       clk,
    input  wire       rst_n,
    input  wire [7:0] din,
    input  wire       wr,
    output reg        busy,
    output reg        tx
);

  localparam CYCLES_PER_BIT = CLK_FREQ / BAUD_RATE;
  
  reg [2:0] state;
  reg [15:0] bit_count;
  reg [3:0] bit_index;
  reg [7:0] data_reg;
  
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state <= 3'd0;
      bit_count <= 16'd0;
      bit_index <= 4'd0;
      data_reg <= 8'd0;
      busy <= 1'b0;
      tx <= 1'b1;
    end else begin
      case (state)
        3'd0: begin
          // Idle - wait for write request
          if (wr && !busy) begin
            data_reg <= din;
            busy <= 1'b1;
            tx <= 1'b0;  // Start bit
            bit_count <= CYCLES_PER_BIT;
            bit_index <= 4'd0;
            state <= 3'd1;
          end else begin
            tx <= 1'b1;
          end
        end
        
        3'd1: begin
          // Send data bits
          if (bit_count == 16'd0) begin
            if (bit_index < 4'd8) begin
              tx <= data_reg[bit_index];
              bit_index <= bit_index + 1;
              bit_count <= CYCLES_PER_BIT;
            end else begin
              // Send stop bit
              tx <= 1'b1;
              bit_count <= CYCLES_PER_BIT * 2;
              state <= 3'd2;
            end
          end else begin
            bit_count <= bit_count - 1;
          end
        end
        
        3'd2: begin
          // Stop bits
          if (bit_count == 16'd0) begin
            busy <= 1'b0;
            state <= 3'd0;
          end else begin
            bit_count <= bit_count - 1;
          end
        end
      endcase
    end
  end

endmodule
