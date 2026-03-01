--IP Functional Simulation Model
--VERSION_BEGIN 13.0 cbx_mgl 2013:06:12:18:04:42:SJ cbx_simgen 2013:06:12:18:03:40:SJ  VERSION_END


-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- You may only use these simulation model output files for simulation
-- purposes and expressly not for synthesis or any other purposes (in which
-- event Altera disclaims all warranties of any kind).


--synopsys translate_off

--synthesis_resources = mux21 8 
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 ENTITY  nios2_addr_router IS 
	 PORT 
	 ( 
		 clk	:	IN  STD_LOGIC;
		 reset	:	IN  STD_LOGIC;
		 sink_data	:	IN  STD_LOGIC_VECTOR (88 DOWNTO 0);
		 sink_endofpacket	:	IN  STD_LOGIC;
		 sink_ready	:	OUT  STD_LOGIC;
		 sink_startofpacket	:	IN  STD_LOGIC;
		 sink_valid	:	IN  STD_LOGIC;
		 src_channel	:	OUT  STD_LOGIC_VECTOR (3 DOWNTO 0);
		 src_data	:	OUT  STD_LOGIC_VECTOR (88 DOWNTO 0);
		 src_endofpacket	:	OUT  STD_LOGIC;
		 src_ready	:	IN  STD_LOGIC;
		 src_startofpacket	:	OUT  STD_LOGIC;
		 src_valid	:	OUT  STD_LOGIC
	 ); 
 END nios2_addr_router;

 ARCHITECTURE RTL OF nios2_addr_router IS

	 ATTRIBUTE synthesis_clearbox : natural;
	 ATTRIBUTE synthesis_clearbox OF RTL : ARCHITECTURE IS 1;
	 SIGNAL	wire_nios2_addr_router_src_channel_17m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_nios2_addr_router_src_channel_20m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_nios2_addr_router_src_channel_24m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_nios2_addr_router_src_channel_25m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_nios2_addr_router_src_channel_27m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_nios2_addr_router_src_data_22m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_nios2_addr_router_src_data_28m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_nios2_addr_router_src_data_29m_dataout	:	STD_LOGIC;
	 SIGNAL  wire_w_lg_w_sink_data_range120w302w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range123w282w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range144w271w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w1w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w2w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range123w301w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range126w281w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range147w270w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  s_wire_nios2_addr_router_src_channel_1_265_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_nios2_addr_router_src_channel_2_284_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_nios2_addr_router_src_channel_3_303_dataout :	STD_LOGIC;
	 SIGNAL  wire_w_sink_data_range120w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range123w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range126w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range144w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range147w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
 BEGIN

	wire_w_lg_w_sink_data_range120w302w(0) <= wire_w_sink_data_range120w(0) AND wire_w_lg_w_sink_data_range123w301w(0);
	wire_w_lg_w_sink_data_range123w282w(0) <= wire_w_sink_data_range123w(0) AND wire_w_lg_w_sink_data_range126w281w(0);
	wire_w_lg_w_sink_data_range144w271w(0) <= wire_w_sink_data_range144w(0) AND wire_w_lg_w_sink_data_range147w270w(0);
	wire_w1w(0) <= NOT s_wire_nios2_addr_router_src_channel_1_265_dataout;
	wire_w2w(0) <= NOT s_wire_nios2_addr_router_src_channel_2_284_dataout;
	wire_w_lg_w_sink_data_range123w301w(0) <= NOT wire_w_sink_data_range123w(0);
	wire_w_lg_w_sink_data_range126w281w(0) <= NOT wire_w_sink_data_range126w(0);
	wire_w_lg_w_sink_data_range147w270w(0) <= NOT wire_w_sink_data_range147w(0);
	s_wire_nios2_addr_router_src_channel_1_265_dataout <= (((((wire_w_lg_w_sink_data_range144w271w(0) AND (NOT sink_data(49))) AND (NOT sink_data(50))) AND (NOT sink_data(51))) AND (NOT sink_data(52))) AND sink_data(53));
	s_wire_nios2_addr_router_src_channel_2_284_dataout <= ((((((((((((wire_w_lg_w_sink_data_range123w282w(0) AND (NOT sink_data(42))) AND (NOT sink_data(43))) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND sink_data(48)) AND (NOT sink_data(49))) AND (NOT sink_data(50))) AND (NOT sink_data(51))) AND (NOT sink_data(52))) AND sink_data(53));
	s_wire_nios2_addr_router_src_channel_3_303_dataout <= (((((((((((((wire_w_lg_w_sink_data_range120w302w(0) AND sink_data(41)) AND (NOT sink_data(42))) AND (NOT sink_data(43))) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND sink_data(48)) AND (NOT sink_data(49))) AND (NOT sink_data(50))) AND (NOT sink_data(51))) AND (NOT sink_data(52))) AND sink_data(53));
	sink_ready <= src_ready;
	src_channel <= ( wire_nios2_addr_router_src_channel_24m_dataout & wire_nios2_addr_router_src_channel_25m_dataout & s_wire_nios2_addr_router_src_channel_3_303_dataout & wire_nios2_addr_router_src_channel_27m_dataout);
	src_data <= ( sink_data(88 DOWNTO 79) & wire_nios2_addr_router_src_data_28m_dataout & wire_nios2_addr_router_src_data_29m_dataout & sink_data(76 DOWNTO 0));
	src_endofpacket <= sink_endofpacket;
	src_startofpacket <= sink_startofpacket;
	src_valid <= sink_valid;
	wire_w_sink_data_range120w(0) <= sink_data(39);
	wire_w_sink_data_range123w(0) <= sink_data(40);
	wire_w_sink_data_range126w(0) <= sink_data(41);
	wire_w_sink_data_range144w(0) <= sink_data(47);
	wire_w_sink_data_range147w(0) <= sink_data(48);
	wire_nios2_addr_router_src_channel_17m_dataout <= wire_w1w(0) AND NOT(s_wire_nios2_addr_router_src_channel_2_284_dataout);
	wire_nios2_addr_router_src_channel_20m_dataout <= s_wire_nios2_addr_router_src_channel_1_265_dataout AND NOT(s_wire_nios2_addr_router_src_channel_2_284_dataout);
	wire_nios2_addr_router_src_channel_24m_dataout <= wire_nios2_addr_router_src_channel_17m_dataout AND NOT(s_wire_nios2_addr_router_src_channel_3_303_dataout);
	wire_nios2_addr_router_src_channel_25m_dataout <= s_wire_nios2_addr_router_src_channel_2_284_dataout AND NOT(s_wire_nios2_addr_router_src_channel_3_303_dataout);
	wire_nios2_addr_router_src_channel_27m_dataout <= wire_nios2_addr_router_src_channel_20m_dataout AND NOT(s_wire_nios2_addr_router_src_channel_3_303_dataout);
	wire_nios2_addr_router_src_data_22m_dataout <= s_wire_nios2_addr_router_src_channel_1_265_dataout OR s_wire_nios2_addr_router_src_channel_2_284_dataout;
	wire_nios2_addr_router_src_data_28m_dataout <= wire_w2w(0) AND NOT(s_wire_nios2_addr_router_src_channel_3_303_dataout);
	wire_nios2_addr_router_src_data_29m_dataout <= wire_nios2_addr_router_src_data_22m_dataout AND NOT(s_wire_nios2_addr_router_src_channel_3_303_dataout);

 END RTL; --nios2_addr_router
--synopsys translate_on
--VALID FILE
