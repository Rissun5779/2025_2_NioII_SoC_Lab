-- Copyright (C) 1991-2009 Altera Corporation
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

-- VENDOR "Altera"
-- PROGRAM "Quartus II"
-- VERSION "Version 9.1 Build 222 10/21/2009 SJ Web Edition"

-- DATE "03/05/2026 18:49:24"

-- 
-- Device: Altera EP3C16F484C6 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEIII;
LIBRARY IEEE;
USE CYCLONEIII.CYCLONEIII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	decode2_4 IS
    PORT (
	OUT1 : OUT std_logic;
	\IN\ : IN std_logic;
	IN2 : IN std_logic;
	OUT2 : OUT std_logic;
	OUT3 : OUT std_logic;
	OUT4 : OUT std_logic
	);
END decode2_4;

-- Design Ports Information
-- OUT1	=>  Location: PIN_J1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- OUT2	=>  Location: PIN_J2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- OUT3	=>  Location: PIN_J3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- OUT4	=>  Location: PIN_H1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- IN	=>  Location: PIN_H5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- IN2	=>  Location: PIN_J6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_ASDO_DATA1~	=>  Location: PIN_D1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_FLASH_nCE_nCSO~	=>  Location: PIN_E2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DCLK~	=>  Location: PIN_K2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DATA0~	=>  Location: PIN_K1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_nCEO~	=>  Location: PIN_K22,	 I/O Standard: 2.5 V,	 Current Strength: 8mA

ARCHITECTURE structure OF decode2_4 IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_OUT1 : std_logic;
SIGNAL \ww_IN\ : std_logic;
SIGNAL ww_IN2 : std_logic;
SIGNAL ww_OUT2 : std_logic;
SIGNAL ww_OUT3 : std_logic;
SIGNAL ww_OUT4 : std_logic;
SIGNAL \OUT1~output_o\ : std_logic;
SIGNAL \OUT2~output_o\ : std_logic;
SIGNAL \OUT3~output_o\ : std_logic;
SIGNAL \OUT4~output_o\ : std_logic;
SIGNAL \IN2~input_o\ : std_logic;
SIGNAL \IN~input_o\ : std_logic;
SIGNAL \inst4~combout\ : std_logic;
SIGNAL \inst5~0_combout\ : std_logic;
SIGNAL \inst5~1_combout\ : std_logic;
SIGNAL \inst5~2_combout\ : std_logic;
SIGNAL \ALT_INV_inst4~combout\ : std_logic;

BEGIN

OUT1 <= ww_OUT1;
\ww_IN\ <= \IN\;
ww_IN2 <= IN2;
OUT2 <= ww_OUT2;
OUT3 <= ww_OUT3;
OUT4 <= ww_OUT4;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_inst4~combout\ <= NOT \inst4~combout\;

-- Location: IOOBUF_X0_Y20_N9
\OUT1~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_inst4~combout\,
	devoe => ww_devoe,
	o => \OUT1~output_o\);

-- Location: IOOBUF_X0_Y20_N2
\OUT2~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst5~0_combout\,
	devoe => ww_devoe,
	o => \OUT2~output_o\);

-- Location: IOOBUF_X0_Y21_N23
\OUT3~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst5~1_combout\,
	devoe => ww_devoe,
	o => \OUT3~output_o\);

-- Location: IOOBUF_X0_Y21_N16
\OUT4~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst5~2_combout\,
	devoe => ww_devoe,
	o => \OUT4~output_o\);

-- Location: IOIBUF_X0_Y24_N1
\IN2~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_IN2,
	o => \IN2~input_o\);

-- Location: IOIBUF_X0_Y27_N1
\IN~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_IN\,
	o => \IN~input_o\);

-- Location: LCCOMB_X1_Y21_N24
inst4 : cycloneiii_lcell_comb
-- Equation(s):
-- \inst4~combout\ = (\IN2~input_o\) # (\IN~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \IN2~input_o\,
	datad => \IN~input_o\,
	combout => \inst4~combout\);

-- Location: LCCOMB_X1_Y21_N26
\inst5~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst5~0_combout\ = (\IN2~input_o\ & !\IN~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \IN2~input_o\,
	datad => \IN~input_o\,
	combout => \inst5~0_combout\);

-- Location: LCCOMB_X1_Y21_N20
\inst5~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst5~1_combout\ = (!\IN2~input_o\ & \IN~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \IN2~input_o\,
	datad => \IN~input_o\,
	combout => \inst5~1_combout\);

-- Location: LCCOMB_X1_Y21_N14
\inst5~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst5~2_combout\ = (\IN2~input_o\ & \IN~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \IN2~input_o\,
	datad => \IN~input_o\,
	combout => \inst5~2_combout\);

ww_OUT1 <= \OUT1~output_o\;

ww_OUT2 <= \OUT2~output_o\;

ww_OUT3 <= \OUT3~output_o\;

ww_OUT4 <= \OUT4~output_o\;
END structure;


