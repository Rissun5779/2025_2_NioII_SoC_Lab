
# (C) 2001-2026 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 13.1 162 linux 2026.02.27.22:37:46

# ----------------------------------------
# Auto-generated simulation script

# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "nios2"
}

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
}

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "/home/rissun57/QuartusII/quartus/"
}

# ----------------------------------------
# Initialize simulation properties - DO NOT MODIFY!
set ELAB_OPTIONS ""
set SIM_OPTIONS ""
if ![ string match "*-64 vsim*" [ vsim -version ] ] {
} else {
}

# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
  file copy -force $QSYS_SIMDIR/submodules/nios2_RAM.hex ./
  file copy -force $QSYS_SIMDIR/submodules/nios2_nios2_rf_ram_a.dat ./
  file copy -force $QSYS_SIMDIR/submodules/nios2_nios2_ociram_default_contents.hex ./
  file copy -force $QSYS_SIMDIR/submodules/nios2_nios2_rf_ram_a.mif ./
  file copy -force $QSYS_SIMDIR/submodules/nios2_nios2_rf_ram_b.hex ./
  file copy -force $QSYS_SIMDIR/submodules/nios2_nios2_rf_ram_a.hex ./
  file copy -force $QSYS_SIMDIR/submodules/nios2_nios2_rf_ram_b.mif ./
  file copy -force $QSYS_SIMDIR/submodules/nios2_nios2_ociram_default_contents.dat ./
  file copy -force $QSYS_SIMDIR/submodules/nios2_nios2_ociram_default_contents.mif ./
  file copy -force $QSYS_SIMDIR/submodules/nios2_nios2_rf_ram_b.dat ./
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib          ./libraries/     
ensure_lib          ./libraries/work/
vmap       work     ./libraries/work/
vmap       work_lib ./libraries/work/
if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
  ensure_lib                  ./libraries/altera_ver/      
  vmap       altera_ver       ./libraries/altera_ver/      
  ensure_lib                  ./libraries/lpm_ver/         
  vmap       lpm_ver          ./libraries/lpm_ver/         
  ensure_lib                  ./libraries/sgate_ver/       
  vmap       sgate_ver        ./libraries/sgate_ver/       
  ensure_lib                  ./libraries/altera_mf_ver/   
  vmap       altera_mf_ver    ./libraries/altera_mf_ver/   
  ensure_lib                  ./libraries/altera_lnsim_ver/
  vmap       altera_lnsim_ver ./libraries/altera_lnsim_ver/
  ensure_lib                  ./libraries/cycloneive_ver/  
  vmap       cycloneive_ver   ./libraries/cycloneive_ver/  
  ensure_lib                  ./libraries/altera/          
  vmap       altera           ./libraries/altera/          
  ensure_lib                  ./libraries/lpm/             
  vmap       lpm              ./libraries/lpm/             
  ensure_lib                  ./libraries/sgate/           
  vmap       sgate            ./libraries/sgate/           
  ensure_lib                  ./libraries/altera_mf/       
  vmap       altera_mf        ./libraries/altera_mf/       
  ensure_lib                  ./libraries/altera_lnsim/    
  vmap       altera_lnsim     ./libraries/altera_lnsim/    
  ensure_lib                  ./libraries/cycloneive/      
  vmap       cycloneive       ./libraries/cycloneive/      
}
ensure_lib                                                                            ./libraries/rsp_xbar_mux/                                                              
vmap       rsp_xbar_mux                                                               ./libraries/rsp_xbar_mux/                                                              
ensure_lib                                                                            ./libraries/rsp_xbar_demux/                                                            
vmap       rsp_xbar_demux                                                             ./libraries/rsp_xbar_demux/                                                            
ensure_lib                                                                            ./libraries/cmd_xbar_mux/                                                              
vmap       cmd_xbar_mux                                                               ./libraries/cmd_xbar_mux/                                                              
ensure_lib                                                                            ./libraries/cmd_xbar_demux/                                                            
vmap       cmd_xbar_demux                                                             ./libraries/cmd_xbar_demux/                                                            
ensure_lib                                                                            ./libraries/id_router/                                                                 
vmap       id_router                                                                  ./libraries/id_router/                                                                 
ensure_lib                                                                            ./libraries/addr_router/                                                               
vmap       addr_router                                                                ./libraries/addr_router/                                                               
ensure_lib                                                                            ./libraries/nios2_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo/
vmap       nios2_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo ./libraries/nios2_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo/
ensure_lib                                                                            ./libraries/nios2_jtag_debug_module_translator_avalon_universal_slave_0_agent/         
vmap       nios2_jtag_debug_module_translator_avalon_universal_slave_0_agent          ./libraries/nios2_jtag_debug_module_translator_avalon_universal_slave_0_agent/         
ensure_lib                                                                            ./libraries/nios2_instruction_master_translator_avalon_universal_master_0_agent/       
vmap       nios2_instruction_master_translator_avalon_universal_master_0_agent        ./libraries/nios2_instruction_master_translator_avalon_universal_master_0_agent/       
ensure_lib                                                                            ./libraries/nios2_jtag_debug_module_translator/                                        
vmap       nios2_jtag_debug_module_translator                                         ./libraries/nios2_jtag_debug_module_translator/                                        
ensure_lib                                                                            ./libraries/nios2_instruction_master_translator/                                       
vmap       nios2_instruction_master_translator                                        ./libraries/nios2_instruction_master_translator/                                       
ensure_lib                                                                            ./libraries/rst_controller/                                                            
vmap       rst_controller                                                             ./libraries/rst_controller/                                                            
ensure_lib                                                                            ./libraries/irq_mapper/                                                                
vmap       irq_mapper                                                                 ./libraries/irq_mapper/                                                                
ensure_lib                                                                            ./libraries/mm_interconnect_0/                                                         
vmap       mm_interconnect_0                                                          ./libraries/mm_interconnect_0/                                                         
ensure_lib                                                                            ./libraries/LED_PIO/                                                                   
vmap       LED_PIO                                                                    ./libraries/LED_PIO/                                                                   
ensure_lib                                                                            ./libraries/JUART/                                                                     
vmap       JUART                                                                      ./libraries/JUART/                                                                     
ensure_lib                                                                            ./libraries/RAM/                                                                       
vmap       RAM                                                                        ./libraries/RAM/                                                                       
ensure_lib                                                                            ./libraries/nios2/                                                                     
vmap       nios2                                                                      ./libraries/nios2/                                                                     

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"              -work altera_ver      
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                       -work lpm_ver         
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                          -work sgate_ver       
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                      -work altera_mf_ver   
    vlog -sv "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/altera_lnsim_for_vhdl.sv"  -work altera_lnsim_ver
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneive_atoms.v"               -work cycloneive_ver  
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_syn_attributes.vhd"        -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_standard_functions.vhd"    -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/alt_dspbuilder_package.vhd"       -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_europa_support_lib.vhd"    -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives_components.vhd" -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.vhd"            -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220pack.vhd"                      -work lpm             
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.vhd"                     -work lpm             
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate_pack.vhd"                   -work sgate           
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.vhd"                        -work sgate           
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf_components.vhd"         -work altera_mf       
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.vhd"                    -work altera_mf       
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim_components.vhd"      -work altera_lnsim    
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneive_atoms.vhd"             -work cycloneive      
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneive_components.vhd"        -work cycloneive      
  }
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  vcom     "$QSYS_SIMDIR/submodules/nios2_mm_interconnect_0_rsp_xbar_mux.vho"                                                               -work rsp_xbar_mux                                                              
  vcom     "$QSYS_SIMDIR/submodules/nios2_mm_interconnect_0_rsp_xbar_demux.vho"                                                             -work rsp_xbar_demux                                                            
  vcom     "$QSYS_SIMDIR/submodules/nios2_mm_interconnect_0_cmd_xbar_mux.vho"                                                               -work cmd_xbar_mux                                                              
  vcom     "$QSYS_SIMDIR/submodules/nios2_mm_interconnect_0_cmd_xbar_demux.vho"                                                             -work cmd_xbar_demux                                                            
  vcom     "$QSYS_SIMDIR/submodules/nios2_mm_interconnect_0_id_router.vho"                                                                  -work id_router                                                                 
  vcom     "$QSYS_SIMDIR/submodules/nios2_mm_interconnect_0_addr_router.vho"                                                                -work addr_router                                                               
  vcom     "$QSYS_SIMDIR/submodules/nios2_mm_interconnect_0_nios2_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo.vho" -work nios2_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo
  vlog -sv "$QSYS_SIMDIR/submodules/mentor/altera_merlin_slave_agent.sv"                                                                    -work nios2_jtag_debug_module_translator_avalon_universal_slave_0_agent         
  vlog -sv "$QSYS_SIMDIR/submodules/mentor/altera_merlin_burst_uncompressor.sv"                                                             -work nios2_jtag_debug_module_translator_avalon_universal_slave_0_agent         
  vlog -sv "$QSYS_SIMDIR/submodules/mentor/altera_merlin_master_agent.sv"                                                                   -work nios2_instruction_master_translator_avalon_universal_master_0_agent       
  vlog -sv "$QSYS_SIMDIR/submodules/mentor/altera_merlin_slave_translator.sv"                                                               -work nios2_jtag_debug_module_translator                                        
  vlog -sv "$QSYS_SIMDIR/submodules/mentor/altera_merlin_master_translator.sv"                                                              -work nios2_instruction_master_translator                                       
  vlog     "$QSYS_SIMDIR/submodules/mentor/altera_reset_controller.v"                                                                       -work rst_controller                                                            
  vlog     "$QSYS_SIMDIR/submodules/mentor/altera_reset_synchronizer.v"                                                                     -work rst_controller                                                            
  vcom     "$QSYS_SIMDIR/submodules/nios2_irq_mapper.vho"                                                                                   -work irq_mapper                                                                
  vcom     "$QSYS_SIMDIR/submodules/nios2_mm_interconnect_0.vhd"                                                                            -work mm_interconnect_0                                                         
  vcom     "$QSYS_SIMDIR/submodules/nios2_mm_interconnect_0_nios2_jtag_debug_module_translator.vhd"                                         -work mm_interconnect_0                                                         
  vcom     "$QSYS_SIMDIR/submodules/nios2_mm_interconnect_0_juart_avalon_jtag_slave_translator.vhd"                                         -work mm_interconnect_0                                                         
  vcom     "$QSYS_SIMDIR/submodules/nios2_mm_interconnect_0_led_pio_s1_translator.vhd"                                                      -work mm_interconnect_0                                                         
  vcom     "$QSYS_SIMDIR/submodules/nios2_mm_interconnect_0_ram_s1_translator.vhd"                                                          -work mm_interconnect_0                                                         
  vcom     "$QSYS_SIMDIR/submodules/nios2_mm_interconnect_0_nios2_instruction_master_translator.vhd"                                        -work mm_interconnect_0                                                         
  vcom     "$QSYS_SIMDIR/submodules/nios2_mm_interconnect_0_nios2_data_master_translator.vhd"                                               -work mm_interconnect_0                                                         
  vcom     "$QSYS_SIMDIR/submodules/nios2_LED_PIO.vhd"                                                                                      -work LED_PIO                                                                   
  vcom     "$QSYS_SIMDIR/submodules/nios2_JUART.vhd"                                                                                        -work JUART                                                                     
  vcom     "$QSYS_SIMDIR/submodules/nios2_RAM.vhd"                                                                                          -work RAM                                                                       
  vcom     "$QSYS_SIMDIR/submodules/nios2_nios2.vhd"                                                                                        -work nios2                                                                     
  vcom     "$QSYS_SIMDIR/submodules/nios2_nios2_jtag_debug_module_wrapper.vhd"                                                              -work nios2                                                                     
  vcom     "$QSYS_SIMDIR/submodules/nios2_nios2_oci_test_bench.vhd"                                                                         -work nios2                                                                     
  vcom     "$QSYS_SIMDIR/submodules/nios2_nios2_jtag_debug_module_tck.vhd"                                                                  -work nios2                                                                     
  vcom     "$QSYS_SIMDIR/submodules/nios2_nios2_jtag_debug_module_sysclk.vhd"                                                               -work nios2                                                                     
  vcom     "$QSYS_SIMDIR/submodules/nios2_nios2_test_bench.vhd"                                                                             -work nios2                                                                     
  vcom     "$QSYS_SIMDIR/nios2.vhd"                                                                                                                                                                                         
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim -t ps $ELAB_OPTIONS -L work -L work_lib -L rsp_xbar_mux -L rsp_xbar_demux -L cmd_xbar_mux -L cmd_xbar_demux -L id_router -L addr_router -L nios2_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo -L nios2_jtag_debug_module_translator_avalon_universal_slave_0_agent -L nios2_instruction_master_translator_avalon_universal_master_0_agent -L nios2_jtag_debug_module_translator -L nios2_instruction_master_translator -L rst_controller -L irq_mapper -L mm_interconnect_0 -L LED_PIO -L JUART -L RAM -L nios2 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with novopt option
alias elab_debug {
  echo "\[exec\] elab_debug"
  eval vsim -novopt -t ps $ELAB_OPTIONS -L work -L work_lib -L rsp_xbar_mux -L rsp_xbar_demux -L cmd_xbar_mux -L cmd_xbar_demux -L id_router -L addr_router -L nios2_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo -L nios2_jtag_debug_module_translator_avalon_universal_slave_0_agent -L nios2_instruction_master_translator_avalon_universal_master_0_agent -L nios2_jtag_debug_module_translator -L nios2_instruction_master_translator -L rst_controller -L irq_mapper -L mm_interconnect_0 -L LED_PIO -L JUART -L RAM -L nios2 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -novopt
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                     -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                       -- Compile device library files"
  echo
  echo "com                           -- Compile the design files in correct order"
  echo
  echo "elab                          -- Elaborate top level design"
  echo
  echo "elab_debug                    -- Elaborate the top level design with novopt option"
  echo
  echo "ld                            -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                      -- Compile all the design files and elaborate the top level design with -novopt"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                -- Top level module name."
  echo
  echo "SYSTEM_INSTANCE_NAME          -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                   -- Qsys base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR           -- Quartus installation directory."
}
file_copy
h
