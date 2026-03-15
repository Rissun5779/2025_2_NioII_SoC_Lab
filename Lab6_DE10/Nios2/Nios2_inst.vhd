	component Nios2 is
		port (
			clk_clk                        : in    std_logic                     := 'X';             -- clk
			clk_sdram_clk                  : out   std_logic;                                        -- clk
			hex0_export                    : out   std_logic_vector(6 downto 0);                     -- export
			hex1_export                    : out   std_logic_vector(6 downto 0);                     -- export
			hex2_export                    : out   std_logic_vector(6 downto 0);                     -- export
			hex3_export                    : out   std_logic_vector(6 downto 0);                     -- export
			pio_led_export                 : out   std_logic_vector(7 downto 0);                     -- export
			pio_sw_export                  : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			pll_locked_export              : out   std_logic;                                        -- export
			reset_reset_n                  : in    std_logic                     := 'X';             -- reset_n
			sdram_wire_addr                : out   std_logic_vector(11 downto 0);                    -- addr
			sdram_wire_ba                  : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_wire_cas_n               : out   std_logic;                                        -- cas_n
			sdram_wire_cke                 : out   std_logic;                                        -- cke
			sdram_wire_cs_n                : out   std_logic;                                        -- cs_n
			sdram_wire_dq                  : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_wire_dqm                 : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_wire_ras_n               : out   std_logic;                                        -- ras_n
			sdram_wire_we_n                : out   std_logic;                                        -- we_n
			uart_0_external_connection_rxd : in    std_logic                     := 'X';             -- rxd
			uart_0_external_connection_txd : out   std_logic;                                        -- txd
			uart_1_external_connection_rxd : in    std_logic                     := 'X';             -- rxd
			uart_1_external_connection_txd : out   std_logic                                         -- txd
		);
	end component Nios2;

	u0 : component Nios2
		port map (
			clk_clk                        => CONNECTED_TO_clk_clk,                        --                        clk.clk
			clk_sdram_clk                  => CONNECTED_TO_clk_sdram_clk,                  --                  clk_sdram.clk
			hex0_export                    => CONNECTED_TO_hex0_export,                    --                       hex0.export
			hex1_export                    => CONNECTED_TO_hex1_export,                    --                       hex1.export
			hex2_export                    => CONNECTED_TO_hex2_export,                    --                       hex2.export
			hex3_export                    => CONNECTED_TO_hex3_export,                    --                       hex3.export
			pio_led_export                 => CONNECTED_TO_pio_led_export,                 --                    pio_led.export
			pio_sw_export                  => CONNECTED_TO_pio_sw_export,                  --                     pio_sw.export
			pll_locked_export              => CONNECTED_TO_pll_locked_export,              --                 pll_locked.export
			reset_reset_n                  => CONNECTED_TO_reset_reset_n,                  --                      reset.reset_n
			sdram_wire_addr                => CONNECTED_TO_sdram_wire_addr,                --                 sdram_wire.addr
			sdram_wire_ba                  => CONNECTED_TO_sdram_wire_ba,                  --                           .ba
			sdram_wire_cas_n               => CONNECTED_TO_sdram_wire_cas_n,               --                           .cas_n
			sdram_wire_cke                 => CONNECTED_TO_sdram_wire_cke,                 --                           .cke
			sdram_wire_cs_n                => CONNECTED_TO_sdram_wire_cs_n,                --                           .cs_n
			sdram_wire_dq                  => CONNECTED_TO_sdram_wire_dq,                  --                           .dq
			sdram_wire_dqm                 => CONNECTED_TO_sdram_wire_dqm,                 --                           .dqm
			sdram_wire_ras_n               => CONNECTED_TO_sdram_wire_ras_n,               --                           .ras_n
			sdram_wire_we_n                => CONNECTED_TO_sdram_wire_we_n,                --                           .we_n
			uart_0_external_connection_rxd => CONNECTED_TO_uart_0_external_connection_rxd, -- uart_0_external_connection.rxd
			uart_0_external_connection_txd => CONNECTED_TO_uart_0_external_connection_txd, --                           .txd
			uart_1_external_connection_rxd => CONNECTED_TO_uart_1_external_connection_rxd, -- uart_1_external_connection.rxd
			uart_1_external_connection_txd => CONNECTED_TO_uart_1_external_connection_txd  --                           .txd
		);

