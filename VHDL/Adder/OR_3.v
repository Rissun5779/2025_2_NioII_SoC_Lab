/*******************************************************************************

-- File Type:    Verilog HDL 
-- Tool Version: VHDL2verilog 19.00c
-- Input file was: OR_3.vhd
-- Command line was: /home/rissun57/Downloads/synapticad-19.00c-x64-full-linux/synapticad-19.00c-x64/bin/x86_64/vhdl2verilog.bin OR_3.vhd
-- Date Created: Sat Feb  7 16:43:00 2026

*******************************************************************************/

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module OR_3 (
   IN1,
   IN2,
   IN3,
   OUT_PIN);
 

input   IN1; 
input   IN2; 
input   IN3; 
output   OUT_PIN; 

wire    OUT_PIN; 

assign OUT_PIN = IN1 | IN2 | IN3; 

endmodule // module OR_3

