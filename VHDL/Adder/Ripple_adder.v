/*******************************************************************************

-- File Type:    Verilog HDL 
-- Tool Version: VHDL2verilog 19.00c
-- Input file was: Ripple_adder.vhd
-- Command line was: /home/rissun57/Downloads/synapticad-19.00c-x64-full-linux/synapticad-19.00c-x64/bin/x86_64/vhdl2verilog.bin Ripple_adder.vhd
-- Date Created: Sat Feb  7 16:52:45 2026

*******************************************************************************/

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module Ripple_adder (
   IN1,
   IN2,
   Cin,
   Sum,
   Carry);
 

input   [3:0] IN1; 
input   [3:0] IN2; 
input   Cin; 
output   [3:0] Sum; 
output   Carry; 

wire    [3:0] Sum; 
wire    Carry; 
wire    Carry1; 
wire    Carry2; 
wire    Carry3; 

full_adder2 FA0 (.IN1(IN1[0]),
          .IN2(IN2[0]),
          .Cin(Cin),
          .sum(Sum[0]),
          .carry(Carry1));
full_adder2 FA1 (.IN1(IN1[1]),
          .IN2(IN2[1]),
          .Cin(Carry1),
          .sum(Sum[1]),
          .carry(Carry2));
full_adder2 FA2 (.IN1(IN1[2]),
          .IN2(IN2[2]),
          .Cin(Carry2),
          .sum(Sum[2]),
          .carry(Carry3));
full_adder2 FA3 (.IN1(IN1[3]),
          .IN2(IN2[3]),
          .Cin(Carry3),
          .sum(Sum[3]),
          .carry(Carry));

endmodule // module Ripple_adder

