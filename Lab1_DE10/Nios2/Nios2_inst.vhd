	component Nios2 is
		port (
			clk_clk        : in  std_logic                    := 'X'; -- clk
			reset_reset_n  : in  std_logic                    := 'X'; -- reset_n
			pio_led_export : out std_logic_vector(9 downto 0)         -- export
		);
	end component Nios2;

	u0 : component Nios2
		port map (
			clk_clk        => CONNECTED_TO_clk_clk,        --     clk.clk
			reset_reset_n  => CONNECTED_TO_reset_reset_n,  --   reset.reset_n
			pio_led_export => CONNECTED_TO_pio_led_export  -- pio_led.export
		);

