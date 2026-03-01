
module Nios2 (
	clk_clk,
	pio_led_export,
	reset_reset_n,
	pio_sw_export);	

	input		clk_clk;
	output	[7:0]	pio_led_export;
	input		reset_reset_n;
	input	[9:0]	pio_sw_export;
endmodule
