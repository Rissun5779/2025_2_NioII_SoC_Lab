/*******************************************************************************

-- File Type:    Verilog HDL 
-- Tool Version: VHDL2verilog 19.00c
-- Input file was: D_FF_preset.vhd
-- Command line was: /home/rissun57/Downloads/synapticad-19.00c-x64-full-linux/synapticad-19.00c-x64/bin/x86_64/vhdl2verilog.bin D_FF_preset.vhd
-- Date Created: Sat Feb  7 22:36:48 2026

*******************************************************************************/

`define false 1'b 0
`define FALSE 1'b 0
`define true 1'b 1
`define TRUE 1'b 1

`timescale 1 ns / 1 ns // timescale for following modules


module D_FF_preset (
   clk,
   rst,
   pre,
   D,
   Q,
   Qn);
 

input   clk; 
input   rst; 
input   pre; 
input   D; 
output   Q; 
output   Qn; 

reg     Q; 
reg     Qn; 


always @(clk or D)
   begin : D_FLIPFLOP
   if (rst === 1'b 0)
      begin
      Q <= 1'b 0;   
      Qn <= 1'b 1;   
      end
   else if (pre === 1'b 0 )
      begin
      Q <= 1'b 1;   
      Qn <= 1'b 0;   
      end
   else if (clk === 1'b 1 )
      begin
      Q <= D;   
      Qn <= ~D;   
      end
   end


endmodule // module D_FF_preset

