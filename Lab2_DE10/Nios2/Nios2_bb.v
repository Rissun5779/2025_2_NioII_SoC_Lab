
module Nios2 (
	clk_clk,
	pio_led_export,
	pio_sw_export,
	reset_reset_n,
	pll_locked_export,
	clk_sdram_clk,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n);	

	input		clk_clk;
	output	[7:0]	pio_led_export;
	input	[9:0]	pio_sw_export;
	input		reset_reset_n;
	output		pll_locked_export;
	output		clk_sdram_clk;
	output	[11:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[15:0]	sdram_wire_dq;
	output	[1:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
endmodule
