/*******************************************************************************

-- File Type:    Verilog HDL 
-- Tool Version: VHDL2verilog 19.00c
-- Input file was: PBWC.vhd
-- Command line was: /home/rissun57/Downloads/synapticad-19.00c-x64-full-linux/synapticad-19.00c-x64/bin/x86_64/vhdl2verilog.bin PBWC.vhd
-- Date Created: Sun Feb  8 00:22:18 2026

*******************************************************************************/

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module PBWC (
   CLK,
   RST,
   PRESS,
   OPEN_CW,
   CLOSE_CW);
 

input   CLK; 
input   RST; 
input   PRESS; 
output   OPEN_CW; 
output   CLOSE_CW; 

reg     OPEN_CW; 
reg     CLOSE_CW; 

// TYPE STATES:
parameter STATES_W_CLOSED = 0;
parameter STATES_W_OPEN = 1;

reg     current_state; 
reg     next_state; 


always @(posedge CLK or negedge RST)
   begin : CURRENT_STATES
   if (RST === 1'b 0)
      begin
      current_state <= STATES_W_CLOSED;   
      end
   else if (CLK === 1'b 1 )
      begin
      current_state <= next_state;   
      end
   end


always @(current_state or PRESS)
   begin : NEXT_STATES
   case (current_state)
   STATES_W_CLOSED:
      begin
      if (PRESS === 1'b 1)
         begin
         next_state <= STATES_W_OPEN;   
         end
      else
         begin
         next_state <= STATES_W_CLOSED;   
         end
      end
   STATES_W_OPEN:
      begin
      if (PRESS === 1'b 1)
         begin
         next_state <= STATES_W_CLOSED;   
         end
      else
         begin
         next_state <= STATES_W_OPEN;   
         end
      end
   default:
      begin
      next_state <= STATES_W_CLOSED;   
      end
   endcase
   end


always @(current_state or PRESS)
   begin : OUTPUT_LOGIC
   case (current_state)
   STATES_W_CLOSED:
      begin
      if (PRESS === 1'b 1)
         begin
         OPEN_CW <= 1'b 1;   
         CLOSE_CW <= 1'b 0;   
         end
      else
         begin
         OPEN_CW <= 1'b 0;   
         CLOSE_CW <= 1'b 0;   
         end
      end
   STATES_W_OPEN:
      begin
      if (PRESS === 1'b 1)
         begin
         OPEN_CW <= 1'b 0;   
         CLOSE_CW <= 1'b 1;   
         end
      else
         begin
         OPEN_CW <= 1'b 0;   
         CLOSE_CW <= 1'b 0;   
         end
      end
   default:
      begin
      OPEN_CW <= 1'b 0;   
      CLOSE_CW <= 1'b 0;   
      end
   endcase
   end


endmodule // module PBWC

