# Legal Notice: (C)2026 Altera Corporation. All rights reserved.  Your
# use of Altera Corporation's design tools, logic functions and other
# software and tools, and its AMPP partner logic functions, and any
# output files any of the foregoing (including device programming or
# simulation files), and any associated documentation or information are
# expressly subject to the terms and conditions of the Altera Program
# License Subscription Agreement or other applicable license agreement,
# including, without limitation, that your use is for the sole purpose
# of programming logic devices manufactured by Altera and sold by Altera
# or its authorized distributors.  Please refer to the applicable
# agreement for further details.

#**************************************************************
# Timequest JTAG clock definition
#   Uncommenting the following lines will define the JTAG
#   clock in TimeQuest Timing Analyzer
#**************************************************************

#create_clock -period 10MHz {altera_reserved_tck}
#set_clock_groups -asynchronous -group {altera_reserved_tck}

#**************************************************************
# Set TCL Path Variables 
#**************************************************************

set 	CORE 	CORE:the_CORE
set 	CORE_oci 	CORE_nios2_oci:the_CORE_nios2_oci
set 	CORE_oci_break 	CORE_nios2_oci_break:the_CORE_nios2_oci_break
set 	CORE_ocimem 	CORE_nios2_ocimem:the_CORE_nios2_ocimem
set 	CORE_oci_debug 	CORE_nios2_oci_debug:the_CORE_nios2_oci_debug
set 	CORE_wrapper 	CORE_jtag_debug_module_wrapper:the_CORE_jtag_debug_module_wrapper
set 	CORE_jtag_tck 	CORE_jtag_debug_module_tck:the_CORE_jtag_debug_module_tck
set 	CORE_jtag_sysclk 	CORE_jtag_debug_module_sysclk:the_CORE_jtag_debug_module_sysclk
set 	CORE_oci_path 	 [format "%s|%s" $CORE $CORE_oci]
set 	CORE_oci_break_path 	 [format "%s|%s" $CORE_oci_path $CORE_oci_break]
set 	CORE_ocimem_path 	 [format "%s|%s" $CORE_oci_path $CORE_ocimem]
set 	CORE_oci_debug_path 	 [format "%s|%s" $CORE_oci_path $CORE_oci_debug]
set 	CORE_jtag_tck_path 	 [format "%s|%s|%s" $CORE_oci_path $CORE_wrapper $CORE_jtag_tck]
set 	CORE_jtag_sysclk_path 	 [format "%s|%s|%s" $CORE_oci_path $CORE_wrapper $CORE_jtag_sysclk]
set 	CORE_jtag_sr 	 [format "%s|*sr" $CORE_jtag_tck_path]

#**************************************************************
# Set False Paths
#**************************************************************

set_false_path -from [get_keepers *$CORE_oci_break_path|break_readreg*] -to [get_keepers *$CORE_jtag_sr*]
set_false_path -from [get_keepers *$CORE_oci_debug_path|*resetlatch]     -to [get_keepers *$CORE_jtag_sr[33]]
set_false_path -from [get_keepers *$CORE_oci_debug_path|monitor_ready]  -to [get_keepers *$CORE_jtag_sr[0]]
set_false_path -from [get_keepers *$CORE_oci_debug_path|monitor_error]  -to [get_keepers *$CORE_jtag_sr[34]]
set_false_path -from [get_keepers *$CORE_ocimem_path|*MonDReg*] -to [get_keepers *$CORE_jtag_sr*]
set_false_path -from *$CORE_jtag_sr*    -to *$CORE_jtag_sysclk_path|*jdo*
set_false_path -from sld_hub:*|irf_reg* -to *$CORE_jtag_sysclk_path|ir*
set_false_path -from sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1] -to *$CORE_oci_debug_path|monitor_go
