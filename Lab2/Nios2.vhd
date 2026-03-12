--megafunction wizard: %Altera SOPC Builder%
--GENERATION: STANDARD
--VERSION: WM1.0


--Legal Notice: (C)2026 Altera Corporation. All rights reserved.  Your
--use of Altera Corporation's design tools, logic functions and other
--software and tools, and its AMPP partner logic functions, and any
--output files any of the foregoing (including device programming or
--simulation files), and any associated documentation or information are
--expressly subject to the terms and conditions of the Altera Program
--License Subscription Agreement or other applicable license agreement,
--including, without limitation, that your use is for the sole purpose
--of programming logic devices manufactured by Altera and sold by Altera
--or its authorized distributors.  Please refer to the applicable
--agreement for further details.


-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity CORE_jtag_debug_module_arbitrator is 
        port (
              -- inputs:
                 signal CORE_data_master_address_to_slave : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal CORE_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal CORE_data_master_debugaccess : IN STD_LOGIC;
                 signal CORE_data_master_read : IN STD_LOGIC;
                 signal CORE_data_master_waitrequest : IN STD_LOGIC;
                 signal CORE_data_master_write : IN STD_LOGIC;
                 signal CORE_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal CORE_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal CORE_instruction_master_read : IN STD_LOGIC;
                 signal CORE_jtag_debug_module_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal CORE_jtag_debug_module_resetrequest : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CORE_data_master_granted_CORE_jtag_debug_module : OUT STD_LOGIC;
                 signal CORE_data_master_qualified_request_CORE_jtag_debug_module : OUT STD_LOGIC;
                 signal CORE_data_master_read_data_valid_CORE_jtag_debug_module : OUT STD_LOGIC;
                 signal CORE_data_master_requests_CORE_jtag_debug_module : OUT STD_LOGIC;
                 signal CORE_instruction_master_granted_CORE_jtag_debug_module : OUT STD_LOGIC;
                 signal CORE_instruction_master_qualified_request_CORE_jtag_debug_module : OUT STD_LOGIC;
                 signal CORE_instruction_master_read_data_valid_CORE_jtag_debug_module : OUT STD_LOGIC;
                 signal CORE_instruction_master_requests_CORE_jtag_debug_module : OUT STD_LOGIC;
                 signal CORE_jtag_debug_module_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                 signal CORE_jtag_debug_module_begintransfer : OUT STD_LOGIC;
                 signal CORE_jtag_debug_module_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal CORE_jtag_debug_module_chipselect : OUT STD_LOGIC;
                 signal CORE_jtag_debug_module_debugaccess : OUT STD_LOGIC;
                 signal CORE_jtag_debug_module_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal CORE_jtag_debug_module_reset_n : OUT STD_LOGIC;
                 signal CORE_jtag_debug_module_resetrequest_from_sa : OUT STD_LOGIC;
                 signal CORE_jtag_debug_module_write : OUT STD_LOGIC;
                 signal CORE_jtag_debug_module_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_CORE_jtag_debug_module_end_xfer : OUT STD_LOGIC
              );
end entity CORE_jtag_debug_module_arbitrator;


architecture europa of CORE_jtag_debug_module_arbitrator is
                signal CORE_data_master_arbiterlock :  STD_LOGIC;
                signal CORE_data_master_arbiterlock2 :  STD_LOGIC;
                signal CORE_data_master_continuerequest :  STD_LOGIC;
                signal CORE_data_master_saved_grant_CORE_jtag_debug_module :  STD_LOGIC;
                signal CORE_instruction_master_arbiterlock :  STD_LOGIC;
                signal CORE_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal CORE_instruction_master_continuerequest :  STD_LOGIC;
                signal CORE_instruction_master_saved_grant_CORE_jtag_debug_module :  STD_LOGIC;
                signal CORE_jtag_debug_module_allgrants :  STD_LOGIC;
                signal CORE_jtag_debug_module_allow_new_arb_cycle :  STD_LOGIC;
                signal CORE_jtag_debug_module_any_bursting_master_saved_grant :  STD_LOGIC;
                signal CORE_jtag_debug_module_any_continuerequest :  STD_LOGIC;
                signal CORE_jtag_debug_module_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CORE_jtag_debug_module_arb_counter_enable :  STD_LOGIC;
                signal CORE_jtag_debug_module_arb_share_counter :  STD_LOGIC;
                signal CORE_jtag_debug_module_arb_share_counter_next_value :  STD_LOGIC;
                signal CORE_jtag_debug_module_arb_share_set_values :  STD_LOGIC;
                signal CORE_jtag_debug_module_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CORE_jtag_debug_module_arbitration_holdoff_internal :  STD_LOGIC;
                signal CORE_jtag_debug_module_beginbursttransfer_internal :  STD_LOGIC;
                signal CORE_jtag_debug_module_begins_xfer :  STD_LOGIC;
                signal CORE_jtag_debug_module_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal CORE_jtag_debug_module_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CORE_jtag_debug_module_end_xfer :  STD_LOGIC;
                signal CORE_jtag_debug_module_firsttransfer :  STD_LOGIC;
                signal CORE_jtag_debug_module_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CORE_jtag_debug_module_in_a_read_cycle :  STD_LOGIC;
                signal CORE_jtag_debug_module_in_a_write_cycle :  STD_LOGIC;
                signal CORE_jtag_debug_module_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CORE_jtag_debug_module_non_bursting_master_requests :  STD_LOGIC;
                signal CORE_jtag_debug_module_reg_firsttransfer :  STD_LOGIC;
                signal CORE_jtag_debug_module_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal CORE_jtag_debug_module_slavearbiterlockenable :  STD_LOGIC;
                signal CORE_jtag_debug_module_slavearbiterlockenable2 :  STD_LOGIC;
                signal CORE_jtag_debug_module_unreg_firsttransfer :  STD_LOGIC;
                signal CORE_jtag_debug_module_waits_for_read :  STD_LOGIC;
                signal CORE_jtag_debug_module_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_CORE_jtag_debug_module :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CORE_data_master_granted_CORE_jtag_debug_module :  STD_LOGIC;
                signal internal_CORE_data_master_qualified_request_CORE_jtag_debug_module :  STD_LOGIC;
                signal internal_CORE_data_master_requests_CORE_jtag_debug_module :  STD_LOGIC;
                signal internal_CORE_instruction_master_granted_CORE_jtag_debug_module :  STD_LOGIC;
                signal internal_CORE_instruction_master_qualified_request_CORE_jtag_debug_module :  STD_LOGIC;
                signal internal_CORE_instruction_master_requests_CORE_jtag_debug_module :  STD_LOGIC;
                signal last_cycle_CORE_data_master_granted_slave_CORE_jtag_debug_module :  STD_LOGIC;
                signal last_cycle_CORE_instruction_master_granted_slave_CORE_jtag_debug_module :  STD_LOGIC;
                signal shifted_address_to_CORE_jtag_debug_module_from_CORE_data_master :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal shifted_address_to_CORE_jtag_debug_module_from_CORE_instruction_master :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal wait_for_CORE_jtag_debug_module_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT CORE_jtag_debug_module_end_xfer;
    end if;

  end process;

  CORE_jtag_debug_module_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_CORE_data_master_qualified_request_CORE_jtag_debug_module OR internal_CORE_instruction_master_qualified_request_CORE_jtag_debug_module));
  --assign CORE_jtag_debug_module_readdata_from_sa = CORE_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  CORE_jtag_debug_module_readdata_from_sa <= CORE_jtag_debug_module_readdata;
  internal_CORE_data_master_requests_CORE_jtag_debug_module <= to_std_logic(((Std_Logic_Vector'(CORE_data_master_address_to_slave(17 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("100000100000000000")))) AND ((CORE_data_master_read OR CORE_data_master_write));
  --CORE_jtag_debug_module_arb_share_counter set values, which is an e_mux
  CORE_jtag_debug_module_arb_share_set_values <= std_logic'('1');
  --CORE_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  CORE_jtag_debug_module_non_bursting_master_requests <= ((internal_CORE_data_master_requests_CORE_jtag_debug_module OR internal_CORE_instruction_master_requests_CORE_jtag_debug_module) OR internal_CORE_data_master_requests_CORE_jtag_debug_module) OR internal_CORE_instruction_master_requests_CORE_jtag_debug_module;
  --CORE_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  CORE_jtag_debug_module_any_bursting_master_saved_grant <= std_logic'('0');
  --CORE_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  CORE_jtag_debug_module_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(CORE_jtag_debug_module_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CORE_jtag_debug_module_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(CORE_jtag_debug_module_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CORE_jtag_debug_module_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --CORE_jtag_debug_module_allgrants all slave grants, which is an e_mux
  CORE_jtag_debug_module_allgrants <= (((or_reduce(CORE_jtag_debug_module_grant_vector)) OR (or_reduce(CORE_jtag_debug_module_grant_vector))) OR (or_reduce(CORE_jtag_debug_module_grant_vector))) OR (or_reduce(CORE_jtag_debug_module_grant_vector));
  --CORE_jtag_debug_module_end_xfer assignment, which is an e_assign
  CORE_jtag_debug_module_end_xfer <= NOT ((CORE_jtag_debug_module_waits_for_read OR CORE_jtag_debug_module_waits_for_write));
  --end_xfer_arb_share_counter_term_CORE_jtag_debug_module arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_CORE_jtag_debug_module <= CORE_jtag_debug_module_end_xfer AND (((NOT CORE_jtag_debug_module_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --CORE_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  CORE_jtag_debug_module_arb_counter_enable <= ((end_xfer_arb_share_counter_term_CORE_jtag_debug_module AND CORE_jtag_debug_module_allgrants)) OR ((end_xfer_arb_share_counter_term_CORE_jtag_debug_module AND NOT CORE_jtag_debug_module_non_bursting_master_requests));
  --CORE_jtag_debug_module_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CORE_jtag_debug_module_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(CORE_jtag_debug_module_arb_counter_enable) = '1' then 
        CORE_jtag_debug_module_arb_share_counter <= CORE_jtag_debug_module_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --CORE_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CORE_jtag_debug_module_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(CORE_jtag_debug_module_master_qreq_vector) AND end_xfer_arb_share_counter_term_CORE_jtag_debug_module)) OR ((end_xfer_arb_share_counter_term_CORE_jtag_debug_module AND NOT CORE_jtag_debug_module_non_bursting_master_requests)))) = '1' then 
        CORE_jtag_debug_module_slavearbiterlockenable <= CORE_jtag_debug_module_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --CORE/data_master CORE/jtag_debug_module arbiterlock, which is an e_assign
  CORE_data_master_arbiterlock <= CORE_jtag_debug_module_slavearbiterlockenable AND CORE_data_master_continuerequest;
  --CORE_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  CORE_jtag_debug_module_slavearbiterlockenable2 <= CORE_jtag_debug_module_arb_share_counter_next_value;
  --CORE/data_master CORE/jtag_debug_module arbiterlock2, which is an e_assign
  CORE_data_master_arbiterlock2 <= CORE_jtag_debug_module_slavearbiterlockenable2 AND CORE_data_master_continuerequest;
  --CORE/instruction_master CORE/jtag_debug_module arbiterlock, which is an e_assign
  CORE_instruction_master_arbiterlock <= CORE_jtag_debug_module_slavearbiterlockenable AND CORE_instruction_master_continuerequest;
  --CORE/instruction_master CORE/jtag_debug_module arbiterlock2, which is an e_assign
  CORE_instruction_master_arbiterlock2 <= CORE_jtag_debug_module_slavearbiterlockenable2 AND CORE_instruction_master_continuerequest;
  --CORE/instruction_master granted CORE/jtag_debug_module last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_CORE_instruction_master_granted_slave_CORE_jtag_debug_module <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_CORE_instruction_master_granted_slave_CORE_jtag_debug_module <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(CORE_instruction_master_saved_grant_CORE_jtag_debug_module) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((CORE_jtag_debug_module_arbitration_holdoff_internal OR NOT internal_CORE_instruction_master_requests_CORE_jtag_debug_module))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_CORE_instruction_master_granted_slave_CORE_jtag_debug_module))))));
    end if;

  end process;

  --CORE_instruction_master_continuerequest continued request, which is an e_mux
  CORE_instruction_master_continuerequest <= last_cycle_CORE_instruction_master_granted_slave_CORE_jtag_debug_module AND internal_CORE_instruction_master_requests_CORE_jtag_debug_module;
  --CORE_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  CORE_jtag_debug_module_any_continuerequest <= CORE_instruction_master_continuerequest OR CORE_data_master_continuerequest;
  internal_CORE_data_master_qualified_request_CORE_jtag_debug_module <= internal_CORE_data_master_requests_CORE_jtag_debug_module AND NOT (((((NOT CORE_data_master_waitrequest) AND CORE_data_master_write)) OR CORE_instruction_master_arbiterlock));
  --CORE_jtag_debug_module_writedata mux, which is an e_mux
  CORE_jtag_debug_module_writedata <= CORE_data_master_writedata;
  internal_CORE_instruction_master_requests_CORE_jtag_debug_module <= ((to_std_logic(((Std_Logic_Vector'(CORE_instruction_master_address_to_slave(17 DOWNTO 11) & std_logic_vector'("00000000000")) = std_logic_vector'("100000100000000000")))) AND (CORE_instruction_master_read))) AND CORE_instruction_master_read;
  --CORE/data_master granted CORE/jtag_debug_module last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_CORE_data_master_granted_slave_CORE_jtag_debug_module <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_CORE_data_master_granted_slave_CORE_jtag_debug_module <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(CORE_data_master_saved_grant_CORE_jtag_debug_module) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((CORE_jtag_debug_module_arbitration_holdoff_internal OR NOT internal_CORE_data_master_requests_CORE_jtag_debug_module))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_CORE_data_master_granted_slave_CORE_jtag_debug_module))))));
    end if;

  end process;

  --CORE_data_master_continuerequest continued request, which is an e_mux
  CORE_data_master_continuerequest <= last_cycle_CORE_data_master_granted_slave_CORE_jtag_debug_module AND internal_CORE_data_master_requests_CORE_jtag_debug_module;
  internal_CORE_instruction_master_qualified_request_CORE_jtag_debug_module <= internal_CORE_instruction_master_requests_CORE_jtag_debug_module AND NOT (CORE_data_master_arbiterlock);
  --allow new arb cycle for CORE/jtag_debug_module, which is an e_assign
  CORE_jtag_debug_module_allow_new_arb_cycle <= NOT CORE_data_master_arbiterlock AND NOT CORE_instruction_master_arbiterlock;
  --CORE/instruction_master assignment into master qualified-requests vector for CORE/jtag_debug_module, which is an e_assign
  CORE_jtag_debug_module_master_qreq_vector(0) <= internal_CORE_instruction_master_qualified_request_CORE_jtag_debug_module;
  --CORE/instruction_master grant CORE/jtag_debug_module, which is an e_assign
  internal_CORE_instruction_master_granted_CORE_jtag_debug_module <= CORE_jtag_debug_module_grant_vector(0);
  --CORE/instruction_master saved-grant CORE/jtag_debug_module, which is an e_assign
  CORE_instruction_master_saved_grant_CORE_jtag_debug_module <= CORE_jtag_debug_module_arb_winner(0) AND internal_CORE_instruction_master_requests_CORE_jtag_debug_module;
  --CORE/data_master assignment into master qualified-requests vector for CORE/jtag_debug_module, which is an e_assign
  CORE_jtag_debug_module_master_qreq_vector(1) <= internal_CORE_data_master_qualified_request_CORE_jtag_debug_module;
  --CORE/data_master grant CORE/jtag_debug_module, which is an e_assign
  internal_CORE_data_master_granted_CORE_jtag_debug_module <= CORE_jtag_debug_module_grant_vector(1);
  --CORE/data_master saved-grant CORE/jtag_debug_module, which is an e_assign
  CORE_data_master_saved_grant_CORE_jtag_debug_module <= CORE_jtag_debug_module_arb_winner(1) AND internal_CORE_data_master_requests_CORE_jtag_debug_module;
  --CORE/jtag_debug_module chosen-master double-vector, which is an e_assign
  CORE_jtag_debug_module_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((CORE_jtag_debug_module_master_qreq_vector & CORE_jtag_debug_module_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT CORE_jtag_debug_module_master_qreq_vector & NOT CORE_jtag_debug_module_master_qreq_vector))) + (std_logic_vector'("000") & (CORE_jtag_debug_module_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  CORE_jtag_debug_module_arb_winner <= A_WE_StdLogicVector((std_logic'(((CORE_jtag_debug_module_allow_new_arb_cycle AND or_reduce(CORE_jtag_debug_module_grant_vector)))) = '1'), CORE_jtag_debug_module_grant_vector, CORE_jtag_debug_module_saved_chosen_master_vector);
  --saved CORE_jtag_debug_module_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CORE_jtag_debug_module_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(CORE_jtag_debug_module_allow_new_arb_cycle) = '1' then 
        CORE_jtag_debug_module_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(CORE_jtag_debug_module_grant_vector)) = '1'), CORE_jtag_debug_module_grant_vector, CORE_jtag_debug_module_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  CORE_jtag_debug_module_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((CORE_jtag_debug_module_chosen_master_double_vector(1) OR CORE_jtag_debug_module_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((CORE_jtag_debug_module_chosen_master_double_vector(0) OR CORE_jtag_debug_module_chosen_master_double_vector(2)))));
  --CORE/jtag_debug_module chosen master rotated left, which is an e_assign
  CORE_jtag_debug_module_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(CORE_jtag_debug_module_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(CORE_jtag_debug_module_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --CORE/jtag_debug_module's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CORE_jtag_debug_module_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(CORE_jtag_debug_module_grant_vector)) = '1' then 
        CORE_jtag_debug_module_arb_addend <= A_WE_StdLogicVector((std_logic'(CORE_jtag_debug_module_end_xfer) = '1'), CORE_jtag_debug_module_chosen_master_rot_left, CORE_jtag_debug_module_grant_vector);
      end if;
    end if;

  end process;

  CORE_jtag_debug_module_begintransfer <= CORE_jtag_debug_module_begins_xfer;
  --CORE_jtag_debug_module_reset_n assignment, which is an e_assign
  CORE_jtag_debug_module_reset_n <= reset_n;
  --assign CORE_jtag_debug_module_resetrequest_from_sa = CORE_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  CORE_jtag_debug_module_resetrequest_from_sa <= CORE_jtag_debug_module_resetrequest;
  CORE_jtag_debug_module_chipselect <= internal_CORE_data_master_granted_CORE_jtag_debug_module OR internal_CORE_instruction_master_granted_CORE_jtag_debug_module;
  --CORE_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  CORE_jtag_debug_module_firsttransfer <= A_WE_StdLogic((std_logic'(CORE_jtag_debug_module_begins_xfer) = '1'), CORE_jtag_debug_module_unreg_firsttransfer, CORE_jtag_debug_module_reg_firsttransfer);
  --CORE_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  CORE_jtag_debug_module_unreg_firsttransfer <= NOT ((CORE_jtag_debug_module_slavearbiterlockenable AND CORE_jtag_debug_module_any_continuerequest));
  --CORE_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CORE_jtag_debug_module_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(CORE_jtag_debug_module_begins_xfer) = '1' then 
        CORE_jtag_debug_module_reg_firsttransfer <= CORE_jtag_debug_module_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --CORE_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  CORE_jtag_debug_module_beginbursttransfer_internal <= CORE_jtag_debug_module_begins_xfer;
  --CORE_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  CORE_jtag_debug_module_arbitration_holdoff_internal <= CORE_jtag_debug_module_begins_xfer AND CORE_jtag_debug_module_firsttransfer;
  --CORE_jtag_debug_module_write assignment, which is an e_mux
  CORE_jtag_debug_module_write <= internal_CORE_data_master_granted_CORE_jtag_debug_module AND CORE_data_master_write;
  shifted_address_to_CORE_jtag_debug_module_from_CORE_data_master <= CORE_data_master_address_to_slave;
  --CORE_jtag_debug_module_address mux, which is an e_mux
  CORE_jtag_debug_module_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CORE_data_master_granted_CORE_jtag_debug_module)) = '1'), (A_SRL(shifted_address_to_CORE_jtag_debug_module_from_CORE_data_master,std_logic_vector'("00000000000000000000000000000010"))), (A_SRL(shifted_address_to_CORE_jtag_debug_module_from_CORE_instruction_master,std_logic_vector'("00000000000000000000000000000010")))), 9);
  shifted_address_to_CORE_jtag_debug_module_from_CORE_instruction_master <= CORE_instruction_master_address_to_slave;
  --d1_CORE_jtag_debug_module_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_CORE_jtag_debug_module_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_CORE_jtag_debug_module_end_xfer <= CORE_jtag_debug_module_end_xfer;
    end if;

  end process;

  --CORE_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  CORE_jtag_debug_module_waits_for_read <= CORE_jtag_debug_module_in_a_read_cycle AND CORE_jtag_debug_module_begins_xfer;
  --CORE_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  CORE_jtag_debug_module_in_a_read_cycle <= ((internal_CORE_data_master_granted_CORE_jtag_debug_module AND CORE_data_master_read)) OR ((internal_CORE_instruction_master_granted_CORE_jtag_debug_module AND CORE_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= CORE_jtag_debug_module_in_a_read_cycle;
  --CORE_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  CORE_jtag_debug_module_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CORE_jtag_debug_module_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --CORE_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  CORE_jtag_debug_module_in_a_write_cycle <= internal_CORE_data_master_granted_CORE_jtag_debug_module AND CORE_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= CORE_jtag_debug_module_in_a_write_cycle;
  wait_for_CORE_jtag_debug_module_counter <= std_logic'('0');
  --CORE_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  CORE_jtag_debug_module_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CORE_data_master_granted_CORE_jtag_debug_module)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (CORE_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --debugaccess mux, which is an e_mux
  CORE_jtag_debug_module_debugaccess <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((internal_CORE_data_master_granted_CORE_jtag_debug_module)) = '1'), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CORE_data_master_debugaccess))), std_logic_vector'("00000000000000000000000000000000")));
  --vhdl renameroo for output signals
  CORE_data_master_granted_CORE_jtag_debug_module <= internal_CORE_data_master_granted_CORE_jtag_debug_module;
  --vhdl renameroo for output signals
  CORE_data_master_qualified_request_CORE_jtag_debug_module <= internal_CORE_data_master_qualified_request_CORE_jtag_debug_module;
  --vhdl renameroo for output signals
  CORE_data_master_requests_CORE_jtag_debug_module <= internal_CORE_data_master_requests_CORE_jtag_debug_module;
  --vhdl renameroo for output signals
  CORE_instruction_master_granted_CORE_jtag_debug_module <= internal_CORE_instruction_master_granted_CORE_jtag_debug_module;
  --vhdl renameroo for output signals
  CORE_instruction_master_qualified_request_CORE_jtag_debug_module <= internal_CORE_instruction_master_qualified_request_CORE_jtag_debug_module;
  --vhdl renameroo for output signals
  CORE_instruction_master_requests_CORE_jtag_debug_module <= internal_CORE_instruction_master_requests_CORE_jtag_debug_module;
--synthesis translate_off
    --CORE/jtag_debug_module enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_CORE_data_master_granted_CORE_jtag_debug_module))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_CORE_instruction_master_granted_CORE_jtag_debug_module))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line, now);
          write(write_line, string'(": "));
          write(write_line, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line.all);
          deallocate (write_line);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line1 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(CORE_data_master_saved_grant_CORE_jtag_debug_module))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(CORE_instruction_master_saved_grant_CORE_jtag_debug_module))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line1, now);
          write(write_line1, string'(": "));
          write(write_line1, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line1.all);
          deallocate (write_line1);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity CORE_data_master_arbitrator is 
        port (
              -- inputs:
                 signal CORE_data_master_address : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal CORE_data_master_granted_CORE_jtag_debug_module : IN STD_LOGIC;
                 signal CORE_data_master_granted_JTAG_DEBUG_avalon_jtag_slave : IN STD_LOGIC;
                 signal CORE_data_master_granted_PIO_LED_s1 : IN STD_LOGIC;
                 signal CORE_data_master_granted_RAM_s1 : IN STD_LOGIC;
                 signal CORE_data_master_qualified_request_CORE_jtag_debug_module : IN STD_LOGIC;
                 signal CORE_data_master_qualified_request_JTAG_DEBUG_avalon_jtag_slave : IN STD_LOGIC;
                 signal CORE_data_master_qualified_request_PIO_LED_s1 : IN STD_LOGIC;
                 signal CORE_data_master_qualified_request_RAM_s1 : IN STD_LOGIC;
                 signal CORE_data_master_read : IN STD_LOGIC;
                 signal CORE_data_master_read_data_valid_CORE_jtag_debug_module : IN STD_LOGIC;
                 signal CORE_data_master_read_data_valid_JTAG_DEBUG_avalon_jtag_slave : IN STD_LOGIC;
                 signal CORE_data_master_read_data_valid_PIO_LED_s1 : IN STD_LOGIC;
                 signal CORE_data_master_read_data_valid_RAM_s1 : IN STD_LOGIC;
                 signal CORE_data_master_requests_CORE_jtag_debug_module : IN STD_LOGIC;
                 signal CORE_data_master_requests_JTAG_DEBUG_avalon_jtag_slave : IN STD_LOGIC;
                 signal CORE_data_master_requests_PIO_LED_s1 : IN STD_LOGIC;
                 signal CORE_data_master_requests_RAM_s1 : IN STD_LOGIC;
                 signal CORE_data_master_write : IN STD_LOGIC;
                 signal CORE_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal JTAG_DEBUG_avalon_jtag_slave_irq_from_sa : IN STD_LOGIC;
                 signal JTAG_DEBUG_avalon_jtag_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal JTAG_DEBUG_avalon_jtag_slave_waitrequest_from_sa : IN STD_LOGIC;
                 signal PIO_LED_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal RAM_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal d1_CORE_jtag_debug_module_end_xfer : IN STD_LOGIC;
                 signal d1_JTAG_DEBUG_avalon_jtag_slave_end_xfer : IN STD_LOGIC;
                 signal d1_PIO_LED_s1_end_xfer : IN STD_LOGIC;
                 signal d1_RAM_s1_end_xfer : IN STD_LOGIC;
                 signal registered_CORE_data_master_read_data_valid_RAM_s1 : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CORE_data_master_address_to_slave : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal CORE_data_master_irq : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal CORE_data_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal CORE_data_master_waitrequest : OUT STD_LOGIC
              );
end entity CORE_data_master_arbitrator;


architecture europa of CORE_data_master_arbitrator is
                signal CORE_data_master_run :  STD_LOGIC;
                signal internal_CORE_data_master_address_to_slave :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal internal_CORE_data_master_waitrequest :  STD_LOGIC;
                signal p1_registered_CORE_data_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal r_0 :  STD_LOGIC;
                signal registered_CORE_data_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);

begin

  --r_0 master_run cascaded wait assignment, which is an e_assign
  r_0 <= Vector_To_Std_Logic((((((((((((((((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CORE_data_master_qualified_request_CORE_jtag_debug_module OR NOT CORE_data_master_requests_CORE_jtag_debug_module)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CORE_data_master_granted_CORE_jtag_debug_module OR NOT CORE_data_master_qualified_request_CORE_jtag_debug_module)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CORE_data_master_qualified_request_CORE_jtag_debug_module OR NOT CORE_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CORE_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CORE_data_master_qualified_request_CORE_jtag_debug_module OR NOT CORE_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CORE_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CORE_data_master_qualified_request_JTAG_DEBUG_avalon_jtag_slave OR NOT CORE_data_master_requests_JTAG_DEBUG_avalon_jtag_slave)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CORE_data_master_qualified_request_JTAG_DEBUG_avalon_jtag_slave OR NOT ((CORE_data_master_read OR CORE_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT JTAG_DEBUG_avalon_jtag_slave_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CORE_data_master_read OR CORE_data_master_write)))))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CORE_data_master_qualified_request_JTAG_DEBUG_avalon_jtag_slave OR NOT ((CORE_data_master_read OR CORE_data_master_write)))))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT JTAG_DEBUG_avalon_jtag_slave_waitrequest_from_sa)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CORE_data_master_read OR CORE_data_master_write)))))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CORE_data_master_qualified_request_PIO_LED_s1 OR NOT CORE_data_master_requests_PIO_LED_s1)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CORE_data_master_qualified_request_PIO_LED_s1 OR NOT CORE_data_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CORE_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CORE_data_master_qualified_request_PIO_LED_s1 OR NOT CORE_data_master_write)))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CORE_data_master_write)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((CORE_data_master_qualified_request_RAM_s1 OR registered_CORE_data_master_read_data_valid_RAM_s1) OR NOT CORE_data_master_requests_RAM_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CORE_data_master_granted_RAM_s1 OR NOT CORE_data_master_qualified_request_RAM_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT CORE_data_master_qualified_request_RAM_s1 OR NOT CORE_data_master_read) OR ((registered_CORE_data_master_read_data_valid_RAM_s1 AND CORE_data_master_read)))))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CORE_data_master_qualified_request_RAM_s1 OR NOT ((CORE_data_master_read OR CORE_data_master_write)))))) OR ((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CORE_data_master_read OR CORE_data_master_write)))))))))));
  --cascaded wait assignment, which is an e_assign
  CORE_data_master_run <= r_0;
  --optimize select-logic by passing only those address bits which matter.
  internal_CORE_data_master_address_to_slave <= CORE_data_master_address(17 DOWNTO 0);
  --CORE/data_master readdata mux, which is an e_mux
  CORE_data_master_readdata <= ((((A_REP(NOT CORE_data_master_requests_CORE_jtag_debug_module, 32) OR CORE_jtag_debug_module_readdata_from_sa)) AND ((A_REP(NOT CORE_data_master_requests_JTAG_DEBUG_avalon_jtag_slave, 32) OR registered_CORE_data_master_readdata))) AND ((A_REP(NOT CORE_data_master_requests_PIO_LED_s1, 32) OR (std_logic_vector'("000000000000000000000000") & (PIO_LED_s1_readdata_from_sa))))) AND ((A_REP(NOT CORE_data_master_requests_RAM_s1, 32) OR RAM_s1_readdata_from_sa));
  --actual waitrequest port, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      internal_CORE_data_master_waitrequest <= Vector_To_Std_Logic(NOT std_logic_vector'("00000000000000000000000000000000"));
    elsif clk'event and clk = '1' then
      internal_CORE_data_master_waitrequest <= Vector_To_Std_Logic(NOT (A_WE_StdLogicVector((std_logic'((NOT ((CORE_data_master_read OR CORE_data_master_write)))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CORE_data_master_run AND internal_CORE_data_master_waitrequest))))))));
    end if;

  end process;

  --unpredictable registered wait state incoming data, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      registered_CORE_data_master_readdata <= std_logic_vector'("00000000000000000000000000000000");
    elsif clk'event and clk = '1' then
      registered_CORE_data_master_readdata <= p1_registered_CORE_data_master_readdata;
    end if;

  end process;

  --registered readdata mux, which is an e_mux
  p1_registered_CORE_data_master_readdata <= A_REP(NOT CORE_data_master_requests_JTAG_DEBUG_avalon_jtag_slave, 32) OR JTAG_DEBUG_avalon_jtag_slave_readdata_from_sa;
  --irq assign, which is an e_assign
  CORE_data_master_irq <= Std_Logic_Vector'(A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(std_logic'('0')) & A_ToStdLogicVector(JTAG_DEBUG_avalon_jtag_slave_irq_from_sa));
  --vhdl renameroo for output signals
  CORE_data_master_address_to_slave <= internal_CORE_data_master_address_to_slave;
  --vhdl renameroo for output signals
  CORE_data_master_waitrequest <= internal_CORE_data_master_waitrequest;

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity CORE_instruction_master_arbitrator is 
        port (
              -- inputs:
                 signal CORE_instruction_master_address : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal CORE_instruction_master_granted_CORE_jtag_debug_module : IN STD_LOGIC;
                 signal CORE_instruction_master_granted_RAM_s1 : IN STD_LOGIC;
                 signal CORE_instruction_master_qualified_request_CORE_jtag_debug_module : IN STD_LOGIC;
                 signal CORE_instruction_master_qualified_request_RAM_s1 : IN STD_LOGIC;
                 signal CORE_instruction_master_read : IN STD_LOGIC;
                 signal CORE_instruction_master_read_data_valid_CORE_jtag_debug_module : IN STD_LOGIC;
                 signal CORE_instruction_master_read_data_valid_RAM_s1 : IN STD_LOGIC;
                 signal CORE_instruction_master_requests_CORE_jtag_debug_module : IN STD_LOGIC;
                 signal CORE_instruction_master_requests_RAM_s1 : IN STD_LOGIC;
                 signal CORE_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal RAM_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal d1_CORE_jtag_debug_module_end_xfer : IN STD_LOGIC;
                 signal d1_RAM_s1_end_xfer : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CORE_instruction_master_address_to_slave : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal CORE_instruction_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal CORE_instruction_master_waitrequest : OUT STD_LOGIC
              );
end entity CORE_instruction_master_arbitrator;


architecture europa of CORE_instruction_master_arbitrator is
                signal CORE_instruction_master_address_last_time :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal CORE_instruction_master_read_last_time :  STD_LOGIC;
                signal CORE_instruction_master_run :  STD_LOGIC;
                signal active_and_waiting_last_time :  STD_LOGIC;
                signal internal_CORE_instruction_master_address_to_slave :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal internal_CORE_instruction_master_waitrequest :  STD_LOGIC;
                signal r_0 :  STD_LOGIC;

begin

  --r_0 master_run cascaded wait assignment, which is an e_assign
  r_0 <= Vector_To_Std_Logic((((((((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CORE_instruction_master_qualified_request_CORE_jtag_debug_module OR NOT CORE_instruction_master_requests_CORE_jtag_debug_module)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CORE_instruction_master_granted_CORE_jtag_debug_module OR NOT CORE_instruction_master_qualified_request_CORE_jtag_debug_module)))))) AND (((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((NOT CORE_instruction_master_qualified_request_CORE_jtag_debug_module OR NOT CORE_instruction_master_read)))) OR (((std_logic_vector'("00000000000000000000000000000001") AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT d1_CORE_jtag_debug_module_end_xfer)))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CORE_instruction_master_read)))))))) AND std_logic_vector'("00000000000000000000000000000001")) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((CORE_instruction_master_qualified_request_RAM_s1 OR CORE_instruction_master_read_data_valid_RAM_s1) OR NOT CORE_instruction_master_requests_RAM_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(((CORE_instruction_master_granted_RAM_s1 OR NOT CORE_instruction_master_qualified_request_RAM_s1)))))) AND (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR((((NOT CORE_instruction_master_qualified_request_RAM_s1 OR NOT CORE_instruction_master_read) OR ((CORE_instruction_master_read_data_valid_RAM_s1 AND CORE_instruction_master_read)))))))));
  --cascaded wait assignment, which is an e_assign
  CORE_instruction_master_run <= r_0;
  --optimize select-logic by passing only those address bits which matter.
  internal_CORE_instruction_master_address_to_slave <= CORE_instruction_master_address(17 DOWNTO 0);
  --CORE/instruction_master readdata mux, which is an e_mux
  CORE_instruction_master_readdata <= ((A_REP(NOT CORE_instruction_master_requests_CORE_jtag_debug_module, 32) OR CORE_jtag_debug_module_readdata_from_sa)) AND ((A_REP(NOT CORE_instruction_master_requests_RAM_s1, 32) OR RAM_s1_readdata_from_sa));
  --actual waitrequest port, which is an e_assign
  internal_CORE_instruction_master_waitrequest <= NOT CORE_instruction_master_run;
  --vhdl renameroo for output signals
  CORE_instruction_master_address_to_slave <= internal_CORE_instruction_master_address_to_slave;
  --vhdl renameroo for output signals
  CORE_instruction_master_waitrequest <= internal_CORE_instruction_master_waitrequest;
--synthesis translate_off
    --CORE_instruction_master_address check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        CORE_instruction_master_address_last_time <= std_logic_vector'("000000000000000000");
      elsif clk'event and clk = '1' then
        CORE_instruction_master_address_last_time <= CORE_instruction_master_address;
      end if;

    end process;

    --CORE/instruction_master waited last time, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        active_and_waiting_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        active_and_waiting_last_time <= internal_CORE_instruction_master_waitrequest AND (CORE_instruction_master_read);
      end if;

    end process;

    --CORE_instruction_master_address matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line2 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((CORE_instruction_master_address /= CORE_instruction_master_address_last_time))))) = '1' then 
          write(write_line2, now);
          write(write_line2, string'(": "));
          write(write_line2, string'("CORE_instruction_master_address did not heed wait!!!"));
          write(output, write_line2.all);
          deallocate (write_line2);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --CORE_instruction_master_read check against wait, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        CORE_instruction_master_read_last_time <= std_logic'('0');
      elsif clk'event and clk = '1' then
        CORE_instruction_master_read_last_time <= CORE_instruction_master_read;
      end if;

    end process;

    --CORE_instruction_master_read matches last port_name, which is an e_process
    process (clk)
    VARIABLE write_line3 : line;
    begin
      if clk'event and clk = '1' then
        if std_logic'((active_and_waiting_last_time AND to_std_logic(((std_logic'(CORE_instruction_master_read) /= std_logic'(CORE_instruction_master_read_last_time)))))) = '1' then 
          write(write_line3, now);
          write(write_line3, string'(": "));
          write(write_line3, string'("CORE_instruction_master_read did not heed wait!!!"));
          write(output, write_line3.all);
          deallocate (write_line3);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity JTAG_DEBUG_avalon_jtag_slave_arbitrator is 
        port (
              -- inputs:
                 signal CORE_data_master_address_to_slave : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal CORE_data_master_read : IN STD_LOGIC;
                 signal CORE_data_master_waitrequest : IN STD_LOGIC;
                 signal CORE_data_master_write : IN STD_LOGIC;
                 signal CORE_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal JTAG_DEBUG_avalon_jtag_slave_dataavailable : IN STD_LOGIC;
                 signal JTAG_DEBUG_avalon_jtag_slave_irq : IN STD_LOGIC;
                 signal JTAG_DEBUG_avalon_jtag_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal JTAG_DEBUG_avalon_jtag_slave_readyfordata : IN STD_LOGIC;
                 signal JTAG_DEBUG_avalon_jtag_slave_waitrequest : IN STD_LOGIC;
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CORE_data_master_granted_JTAG_DEBUG_avalon_jtag_slave : OUT STD_LOGIC;
                 signal CORE_data_master_qualified_request_JTAG_DEBUG_avalon_jtag_slave : OUT STD_LOGIC;
                 signal CORE_data_master_read_data_valid_JTAG_DEBUG_avalon_jtag_slave : OUT STD_LOGIC;
                 signal CORE_data_master_requests_JTAG_DEBUG_avalon_jtag_slave : OUT STD_LOGIC;
                 signal JTAG_DEBUG_avalon_jtag_slave_address : OUT STD_LOGIC;
                 signal JTAG_DEBUG_avalon_jtag_slave_chipselect : OUT STD_LOGIC;
                 signal JTAG_DEBUG_avalon_jtag_slave_dataavailable_from_sa : OUT STD_LOGIC;
                 signal JTAG_DEBUG_avalon_jtag_slave_irq_from_sa : OUT STD_LOGIC;
                 signal JTAG_DEBUG_avalon_jtag_slave_read_n : OUT STD_LOGIC;
                 signal JTAG_DEBUG_avalon_jtag_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal JTAG_DEBUG_avalon_jtag_slave_readyfordata_from_sa : OUT STD_LOGIC;
                 signal JTAG_DEBUG_avalon_jtag_slave_reset_n : OUT STD_LOGIC;
                 signal JTAG_DEBUG_avalon_jtag_slave_waitrequest_from_sa : OUT STD_LOGIC;
                 signal JTAG_DEBUG_avalon_jtag_slave_write_n : OUT STD_LOGIC;
                 signal JTAG_DEBUG_avalon_jtag_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_JTAG_DEBUG_avalon_jtag_slave_end_xfer : OUT STD_LOGIC
              );
end entity JTAG_DEBUG_avalon_jtag_slave_arbitrator;


architecture europa of JTAG_DEBUG_avalon_jtag_slave_arbitrator is
                signal CORE_data_master_arbiterlock :  STD_LOGIC;
                signal CORE_data_master_arbiterlock2 :  STD_LOGIC;
                signal CORE_data_master_continuerequest :  STD_LOGIC;
                signal CORE_data_master_saved_grant_JTAG_DEBUG_avalon_jtag_slave :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_allgrants :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_allow_new_arb_cycle :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_any_bursting_master_saved_grant :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_any_continuerequest :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_arb_counter_enable :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_arb_share_counter :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_arb_share_counter_next_value :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_arb_share_set_values :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_beginbursttransfer_internal :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_begins_xfer :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_end_xfer :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_firsttransfer :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_grant_vector :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_in_a_read_cycle :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_in_a_write_cycle :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_master_qreq_vector :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_non_bursting_master_requests :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_reg_firsttransfer :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_slavearbiterlockenable :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_slavearbiterlockenable2 :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_unreg_firsttransfer :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_waits_for_read :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_JTAG_DEBUG_avalon_jtag_slave :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CORE_data_master_granted_JTAG_DEBUG_avalon_jtag_slave :  STD_LOGIC;
                signal internal_CORE_data_master_qualified_request_JTAG_DEBUG_avalon_jtag_slave :  STD_LOGIC;
                signal internal_CORE_data_master_requests_JTAG_DEBUG_avalon_jtag_slave :  STD_LOGIC;
                signal internal_JTAG_DEBUG_avalon_jtag_slave_waitrequest_from_sa :  STD_LOGIC;
                signal shifted_address_to_JTAG_DEBUG_avalon_jtag_slave_from_CORE_data_master :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal wait_for_JTAG_DEBUG_avalon_jtag_slave_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT JTAG_DEBUG_avalon_jtag_slave_end_xfer;
    end if;

  end process;

  JTAG_DEBUG_avalon_jtag_slave_begins_xfer <= NOT d1_reasons_to_wait AND (internal_CORE_data_master_qualified_request_JTAG_DEBUG_avalon_jtag_slave);
  --assign JTAG_DEBUG_avalon_jtag_slave_readdata_from_sa = JTAG_DEBUG_avalon_jtag_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  JTAG_DEBUG_avalon_jtag_slave_readdata_from_sa <= JTAG_DEBUG_avalon_jtag_slave_readdata;
  internal_CORE_data_master_requests_JTAG_DEBUG_avalon_jtag_slave <= to_std_logic(((Std_Logic_Vector'(CORE_data_master_address_to_slave(17 DOWNTO 3) & std_logic_vector'("000")) = std_logic_vector'("100001000000010000")))) AND ((CORE_data_master_read OR CORE_data_master_write));
  --assign JTAG_DEBUG_avalon_jtag_slave_dataavailable_from_sa = JTAG_DEBUG_avalon_jtag_slave_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  JTAG_DEBUG_avalon_jtag_slave_dataavailable_from_sa <= JTAG_DEBUG_avalon_jtag_slave_dataavailable;
  --assign JTAG_DEBUG_avalon_jtag_slave_readyfordata_from_sa = JTAG_DEBUG_avalon_jtag_slave_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  JTAG_DEBUG_avalon_jtag_slave_readyfordata_from_sa <= JTAG_DEBUG_avalon_jtag_slave_readyfordata;
  --assign JTAG_DEBUG_avalon_jtag_slave_waitrequest_from_sa = JTAG_DEBUG_avalon_jtag_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  internal_JTAG_DEBUG_avalon_jtag_slave_waitrequest_from_sa <= JTAG_DEBUG_avalon_jtag_slave_waitrequest;
  --JTAG_DEBUG_avalon_jtag_slave_arb_share_counter set values, which is an e_mux
  JTAG_DEBUG_avalon_jtag_slave_arb_share_set_values <= std_logic'('1');
  --JTAG_DEBUG_avalon_jtag_slave_non_bursting_master_requests mux, which is an e_mux
  JTAG_DEBUG_avalon_jtag_slave_non_bursting_master_requests <= internal_CORE_data_master_requests_JTAG_DEBUG_avalon_jtag_slave;
  --JTAG_DEBUG_avalon_jtag_slave_any_bursting_master_saved_grant mux, which is an e_mux
  JTAG_DEBUG_avalon_jtag_slave_any_bursting_master_saved_grant <= std_logic'('0');
  --JTAG_DEBUG_avalon_jtag_slave_arb_share_counter_next_value assignment, which is an e_assign
  JTAG_DEBUG_avalon_jtag_slave_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(JTAG_DEBUG_avalon_jtag_slave_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(JTAG_DEBUG_avalon_jtag_slave_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(JTAG_DEBUG_avalon_jtag_slave_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(JTAG_DEBUG_avalon_jtag_slave_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --JTAG_DEBUG_avalon_jtag_slave_allgrants all slave grants, which is an e_mux
  JTAG_DEBUG_avalon_jtag_slave_allgrants <= JTAG_DEBUG_avalon_jtag_slave_grant_vector;
  --JTAG_DEBUG_avalon_jtag_slave_end_xfer assignment, which is an e_assign
  JTAG_DEBUG_avalon_jtag_slave_end_xfer <= NOT ((JTAG_DEBUG_avalon_jtag_slave_waits_for_read OR JTAG_DEBUG_avalon_jtag_slave_waits_for_write));
  --end_xfer_arb_share_counter_term_JTAG_DEBUG_avalon_jtag_slave arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_JTAG_DEBUG_avalon_jtag_slave <= JTAG_DEBUG_avalon_jtag_slave_end_xfer AND (((NOT JTAG_DEBUG_avalon_jtag_slave_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --JTAG_DEBUG_avalon_jtag_slave_arb_share_counter arbitration counter enable, which is an e_assign
  JTAG_DEBUG_avalon_jtag_slave_arb_counter_enable <= ((end_xfer_arb_share_counter_term_JTAG_DEBUG_avalon_jtag_slave AND JTAG_DEBUG_avalon_jtag_slave_allgrants)) OR ((end_xfer_arb_share_counter_term_JTAG_DEBUG_avalon_jtag_slave AND NOT JTAG_DEBUG_avalon_jtag_slave_non_bursting_master_requests));
  --JTAG_DEBUG_avalon_jtag_slave_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      JTAG_DEBUG_avalon_jtag_slave_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(JTAG_DEBUG_avalon_jtag_slave_arb_counter_enable) = '1' then 
        JTAG_DEBUG_avalon_jtag_slave_arb_share_counter <= JTAG_DEBUG_avalon_jtag_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --JTAG_DEBUG_avalon_jtag_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      JTAG_DEBUG_avalon_jtag_slave_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((JTAG_DEBUG_avalon_jtag_slave_master_qreq_vector AND end_xfer_arb_share_counter_term_JTAG_DEBUG_avalon_jtag_slave)) OR ((end_xfer_arb_share_counter_term_JTAG_DEBUG_avalon_jtag_slave AND NOT JTAG_DEBUG_avalon_jtag_slave_non_bursting_master_requests)))) = '1' then 
        JTAG_DEBUG_avalon_jtag_slave_slavearbiterlockenable <= JTAG_DEBUG_avalon_jtag_slave_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --CORE/data_master JTAG_DEBUG/avalon_jtag_slave arbiterlock, which is an e_assign
  CORE_data_master_arbiterlock <= JTAG_DEBUG_avalon_jtag_slave_slavearbiterlockenable AND CORE_data_master_continuerequest;
  --JTAG_DEBUG_avalon_jtag_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  JTAG_DEBUG_avalon_jtag_slave_slavearbiterlockenable2 <= JTAG_DEBUG_avalon_jtag_slave_arb_share_counter_next_value;
  --CORE/data_master JTAG_DEBUG/avalon_jtag_slave arbiterlock2, which is an e_assign
  CORE_data_master_arbiterlock2 <= JTAG_DEBUG_avalon_jtag_slave_slavearbiterlockenable2 AND CORE_data_master_continuerequest;
  --JTAG_DEBUG_avalon_jtag_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  JTAG_DEBUG_avalon_jtag_slave_any_continuerequest <= std_logic'('1');
  --CORE_data_master_continuerequest continued request, which is an e_assign
  CORE_data_master_continuerequest <= std_logic'('1');
  internal_CORE_data_master_qualified_request_JTAG_DEBUG_avalon_jtag_slave <= internal_CORE_data_master_requests_JTAG_DEBUG_avalon_jtag_slave AND NOT ((((CORE_data_master_read AND (NOT CORE_data_master_waitrequest))) OR (((NOT CORE_data_master_waitrequest) AND CORE_data_master_write))));
  --JTAG_DEBUG_avalon_jtag_slave_writedata mux, which is an e_mux
  JTAG_DEBUG_avalon_jtag_slave_writedata <= CORE_data_master_writedata;
  --master is always granted when requested
  internal_CORE_data_master_granted_JTAG_DEBUG_avalon_jtag_slave <= internal_CORE_data_master_qualified_request_JTAG_DEBUG_avalon_jtag_slave;
  --CORE/data_master saved-grant JTAG_DEBUG/avalon_jtag_slave, which is an e_assign
  CORE_data_master_saved_grant_JTAG_DEBUG_avalon_jtag_slave <= internal_CORE_data_master_requests_JTAG_DEBUG_avalon_jtag_slave;
  --allow new arb cycle for JTAG_DEBUG/avalon_jtag_slave, which is an e_assign
  JTAG_DEBUG_avalon_jtag_slave_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  JTAG_DEBUG_avalon_jtag_slave_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  JTAG_DEBUG_avalon_jtag_slave_master_qreq_vector <= std_logic'('1');
  --JTAG_DEBUG_avalon_jtag_slave_reset_n assignment, which is an e_assign
  JTAG_DEBUG_avalon_jtag_slave_reset_n <= reset_n;
  JTAG_DEBUG_avalon_jtag_slave_chipselect <= internal_CORE_data_master_granted_JTAG_DEBUG_avalon_jtag_slave;
  --JTAG_DEBUG_avalon_jtag_slave_firsttransfer first transaction, which is an e_assign
  JTAG_DEBUG_avalon_jtag_slave_firsttransfer <= A_WE_StdLogic((std_logic'(JTAG_DEBUG_avalon_jtag_slave_begins_xfer) = '1'), JTAG_DEBUG_avalon_jtag_slave_unreg_firsttransfer, JTAG_DEBUG_avalon_jtag_slave_reg_firsttransfer);
  --JTAG_DEBUG_avalon_jtag_slave_unreg_firsttransfer first transaction, which is an e_assign
  JTAG_DEBUG_avalon_jtag_slave_unreg_firsttransfer <= NOT ((JTAG_DEBUG_avalon_jtag_slave_slavearbiterlockenable AND JTAG_DEBUG_avalon_jtag_slave_any_continuerequest));
  --JTAG_DEBUG_avalon_jtag_slave_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      JTAG_DEBUG_avalon_jtag_slave_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(JTAG_DEBUG_avalon_jtag_slave_begins_xfer) = '1' then 
        JTAG_DEBUG_avalon_jtag_slave_reg_firsttransfer <= JTAG_DEBUG_avalon_jtag_slave_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --JTAG_DEBUG_avalon_jtag_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  JTAG_DEBUG_avalon_jtag_slave_beginbursttransfer_internal <= JTAG_DEBUG_avalon_jtag_slave_begins_xfer;
  --~JTAG_DEBUG_avalon_jtag_slave_read_n assignment, which is an e_mux
  JTAG_DEBUG_avalon_jtag_slave_read_n <= NOT ((internal_CORE_data_master_granted_JTAG_DEBUG_avalon_jtag_slave AND CORE_data_master_read));
  --~JTAG_DEBUG_avalon_jtag_slave_write_n assignment, which is an e_mux
  JTAG_DEBUG_avalon_jtag_slave_write_n <= NOT ((internal_CORE_data_master_granted_JTAG_DEBUG_avalon_jtag_slave AND CORE_data_master_write));
  shifted_address_to_JTAG_DEBUG_avalon_jtag_slave_from_CORE_data_master <= CORE_data_master_address_to_slave;
  --JTAG_DEBUG_avalon_jtag_slave_address mux, which is an e_mux
  JTAG_DEBUG_avalon_jtag_slave_address <= Vector_To_Std_Logic(A_SRL(shifted_address_to_JTAG_DEBUG_avalon_jtag_slave_from_CORE_data_master,std_logic_vector'("00000000000000000000000000000010")));
  --d1_JTAG_DEBUG_avalon_jtag_slave_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_JTAG_DEBUG_avalon_jtag_slave_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_JTAG_DEBUG_avalon_jtag_slave_end_xfer <= JTAG_DEBUG_avalon_jtag_slave_end_xfer;
    end if;

  end process;

  --JTAG_DEBUG_avalon_jtag_slave_waits_for_read in a cycle, which is an e_mux
  JTAG_DEBUG_avalon_jtag_slave_waits_for_read <= JTAG_DEBUG_avalon_jtag_slave_in_a_read_cycle AND internal_JTAG_DEBUG_avalon_jtag_slave_waitrequest_from_sa;
  --JTAG_DEBUG_avalon_jtag_slave_in_a_read_cycle assignment, which is an e_assign
  JTAG_DEBUG_avalon_jtag_slave_in_a_read_cycle <= internal_CORE_data_master_granted_JTAG_DEBUG_avalon_jtag_slave AND CORE_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= JTAG_DEBUG_avalon_jtag_slave_in_a_read_cycle;
  --JTAG_DEBUG_avalon_jtag_slave_waits_for_write in a cycle, which is an e_mux
  JTAG_DEBUG_avalon_jtag_slave_waits_for_write <= JTAG_DEBUG_avalon_jtag_slave_in_a_write_cycle AND internal_JTAG_DEBUG_avalon_jtag_slave_waitrequest_from_sa;
  --JTAG_DEBUG_avalon_jtag_slave_in_a_write_cycle assignment, which is an e_assign
  JTAG_DEBUG_avalon_jtag_slave_in_a_write_cycle <= internal_CORE_data_master_granted_JTAG_DEBUG_avalon_jtag_slave AND CORE_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= JTAG_DEBUG_avalon_jtag_slave_in_a_write_cycle;
  wait_for_JTAG_DEBUG_avalon_jtag_slave_counter <= std_logic'('0');
  --assign JTAG_DEBUG_avalon_jtag_slave_irq_from_sa = JTAG_DEBUG_avalon_jtag_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  JTAG_DEBUG_avalon_jtag_slave_irq_from_sa <= JTAG_DEBUG_avalon_jtag_slave_irq;
  --vhdl renameroo for output signals
  CORE_data_master_granted_JTAG_DEBUG_avalon_jtag_slave <= internal_CORE_data_master_granted_JTAG_DEBUG_avalon_jtag_slave;
  --vhdl renameroo for output signals
  CORE_data_master_qualified_request_JTAG_DEBUG_avalon_jtag_slave <= internal_CORE_data_master_qualified_request_JTAG_DEBUG_avalon_jtag_slave;
  --vhdl renameroo for output signals
  CORE_data_master_requests_JTAG_DEBUG_avalon_jtag_slave <= internal_CORE_data_master_requests_JTAG_DEBUG_avalon_jtag_slave;
  --vhdl renameroo for output signals
  JTAG_DEBUG_avalon_jtag_slave_waitrequest_from_sa <= internal_JTAG_DEBUG_avalon_jtag_slave_waitrequest_from_sa;
--synthesis translate_off
    --JTAG_DEBUG/avalon_jtag_slave enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PIO_LED_s1_arbitrator is 
        port (
              -- inputs:
                 signal CORE_data_master_address_to_slave : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal CORE_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal CORE_data_master_read : IN STD_LOGIC;
                 signal CORE_data_master_waitrequest : IN STD_LOGIC;
                 signal CORE_data_master_write : IN STD_LOGIC;
                 signal CORE_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal PIO_LED_s1_readdata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CORE_data_master_granted_PIO_LED_s1 : OUT STD_LOGIC;
                 signal CORE_data_master_qualified_request_PIO_LED_s1 : OUT STD_LOGIC;
                 signal CORE_data_master_read_data_valid_PIO_LED_s1 : OUT STD_LOGIC;
                 signal CORE_data_master_requests_PIO_LED_s1 : OUT STD_LOGIC;
                 signal PIO_LED_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                 signal PIO_LED_s1_chipselect : OUT STD_LOGIC;
                 signal PIO_LED_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal PIO_LED_s1_reset_n : OUT STD_LOGIC;
                 signal PIO_LED_s1_write_n : OUT STD_LOGIC;
                 signal PIO_LED_s1_writedata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                 signal d1_PIO_LED_s1_end_xfer : OUT STD_LOGIC
              );
end entity PIO_LED_s1_arbitrator;


architecture europa of PIO_LED_s1_arbitrator is
                signal CORE_data_master_arbiterlock :  STD_LOGIC;
                signal CORE_data_master_arbiterlock2 :  STD_LOGIC;
                signal CORE_data_master_continuerequest :  STD_LOGIC;
                signal CORE_data_master_saved_grant_PIO_LED_s1 :  STD_LOGIC;
                signal PIO_LED_s1_allgrants :  STD_LOGIC;
                signal PIO_LED_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal PIO_LED_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal PIO_LED_s1_any_continuerequest :  STD_LOGIC;
                signal PIO_LED_s1_arb_counter_enable :  STD_LOGIC;
                signal PIO_LED_s1_arb_share_counter :  STD_LOGIC;
                signal PIO_LED_s1_arb_share_counter_next_value :  STD_LOGIC;
                signal PIO_LED_s1_arb_share_set_values :  STD_LOGIC;
                signal PIO_LED_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal PIO_LED_s1_begins_xfer :  STD_LOGIC;
                signal PIO_LED_s1_end_xfer :  STD_LOGIC;
                signal PIO_LED_s1_firsttransfer :  STD_LOGIC;
                signal PIO_LED_s1_grant_vector :  STD_LOGIC;
                signal PIO_LED_s1_in_a_read_cycle :  STD_LOGIC;
                signal PIO_LED_s1_in_a_write_cycle :  STD_LOGIC;
                signal PIO_LED_s1_master_qreq_vector :  STD_LOGIC;
                signal PIO_LED_s1_non_bursting_master_requests :  STD_LOGIC;
                signal PIO_LED_s1_pretend_byte_enable :  STD_LOGIC;
                signal PIO_LED_s1_reg_firsttransfer :  STD_LOGIC;
                signal PIO_LED_s1_slavearbiterlockenable :  STD_LOGIC;
                signal PIO_LED_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal PIO_LED_s1_unreg_firsttransfer :  STD_LOGIC;
                signal PIO_LED_s1_waits_for_read :  STD_LOGIC;
                signal PIO_LED_s1_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_PIO_LED_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CORE_data_master_granted_PIO_LED_s1 :  STD_LOGIC;
                signal internal_CORE_data_master_qualified_request_PIO_LED_s1 :  STD_LOGIC;
                signal internal_CORE_data_master_requests_PIO_LED_s1 :  STD_LOGIC;
                signal shifted_address_to_PIO_LED_s1_from_CORE_data_master :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal wait_for_PIO_LED_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT PIO_LED_s1_end_xfer;
    end if;

  end process;

  PIO_LED_s1_begins_xfer <= NOT d1_reasons_to_wait AND (internal_CORE_data_master_qualified_request_PIO_LED_s1);
  --assign PIO_LED_s1_readdata_from_sa = PIO_LED_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  PIO_LED_s1_readdata_from_sa <= PIO_LED_s1_readdata;
  internal_CORE_data_master_requests_PIO_LED_s1 <= to_std_logic(((Std_Logic_Vector'(CORE_data_master_address_to_slave(17 DOWNTO 4) & std_logic_vector'("0000")) = std_logic_vector'("100001000000000000")))) AND ((CORE_data_master_read OR CORE_data_master_write));
  --PIO_LED_s1_arb_share_counter set values, which is an e_mux
  PIO_LED_s1_arb_share_set_values <= std_logic'('1');
  --PIO_LED_s1_non_bursting_master_requests mux, which is an e_mux
  PIO_LED_s1_non_bursting_master_requests <= internal_CORE_data_master_requests_PIO_LED_s1;
  --PIO_LED_s1_any_bursting_master_saved_grant mux, which is an e_mux
  PIO_LED_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --PIO_LED_s1_arb_share_counter_next_value assignment, which is an e_assign
  PIO_LED_s1_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(PIO_LED_s1_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(PIO_LED_s1_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(PIO_LED_s1_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(PIO_LED_s1_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --PIO_LED_s1_allgrants all slave grants, which is an e_mux
  PIO_LED_s1_allgrants <= PIO_LED_s1_grant_vector;
  --PIO_LED_s1_end_xfer assignment, which is an e_assign
  PIO_LED_s1_end_xfer <= NOT ((PIO_LED_s1_waits_for_read OR PIO_LED_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_PIO_LED_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_PIO_LED_s1 <= PIO_LED_s1_end_xfer AND (((NOT PIO_LED_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --PIO_LED_s1_arb_share_counter arbitration counter enable, which is an e_assign
  PIO_LED_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_PIO_LED_s1 AND PIO_LED_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_PIO_LED_s1 AND NOT PIO_LED_s1_non_bursting_master_requests));
  --PIO_LED_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PIO_LED_s1_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(PIO_LED_s1_arb_counter_enable) = '1' then 
        PIO_LED_s1_arb_share_counter <= PIO_LED_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --PIO_LED_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PIO_LED_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((PIO_LED_s1_master_qreq_vector AND end_xfer_arb_share_counter_term_PIO_LED_s1)) OR ((end_xfer_arb_share_counter_term_PIO_LED_s1 AND NOT PIO_LED_s1_non_bursting_master_requests)))) = '1' then 
        PIO_LED_s1_slavearbiterlockenable <= PIO_LED_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --CORE/data_master PIO_LED/s1 arbiterlock, which is an e_assign
  CORE_data_master_arbiterlock <= PIO_LED_s1_slavearbiterlockenable AND CORE_data_master_continuerequest;
  --PIO_LED_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  PIO_LED_s1_slavearbiterlockenable2 <= PIO_LED_s1_arb_share_counter_next_value;
  --CORE/data_master PIO_LED/s1 arbiterlock2, which is an e_assign
  CORE_data_master_arbiterlock2 <= PIO_LED_s1_slavearbiterlockenable2 AND CORE_data_master_continuerequest;
  --PIO_LED_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  PIO_LED_s1_any_continuerequest <= std_logic'('1');
  --CORE_data_master_continuerequest continued request, which is an e_assign
  CORE_data_master_continuerequest <= std_logic'('1');
  internal_CORE_data_master_qualified_request_PIO_LED_s1 <= internal_CORE_data_master_requests_PIO_LED_s1 AND NOT (((NOT CORE_data_master_waitrequest) AND CORE_data_master_write));
  --PIO_LED_s1_writedata mux, which is an e_mux
  PIO_LED_s1_writedata <= CORE_data_master_writedata (7 DOWNTO 0);
  --master is always granted when requested
  internal_CORE_data_master_granted_PIO_LED_s1 <= internal_CORE_data_master_qualified_request_PIO_LED_s1;
  --CORE/data_master saved-grant PIO_LED/s1, which is an e_assign
  CORE_data_master_saved_grant_PIO_LED_s1 <= internal_CORE_data_master_requests_PIO_LED_s1;
  --allow new arb cycle for PIO_LED/s1, which is an e_assign
  PIO_LED_s1_allow_new_arb_cycle <= std_logic'('1');
  --placeholder chosen master
  PIO_LED_s1_grant_vector <= std_logic'('1');
  --placeholder vector of master qualified-requests
  PIO_LED_s1_master_qreq_vector <= std_logic'('1');
  --PIO_LED_s1_reset_n assignment, which is an e_assign
  PIO_LED_s1_reset_n <= reset_n;
  PIO_LED_s1_chipselect <= internal_CORE_data_master_granted_PIO_LED_s1;
  --PIO_LED_s1_firsttransfer first transaction, which is an e_assign
  PIO_LED_s1_firsttransfer <= A_WE_StdLogic((std_logic'(PIO_LED_s1_begins_xfer) = '1'), PIO_LED_s1_unreg_firsttransfer, PIO_LED_s1_reg_firsttransfer);
  --PIO_LED_s1_unreg_firsttransfer first transaction, which is an e_assign
  PIO_LED_s1_unreg_firsttransfer <= NOT ((PIO_LED_s1_slavearbiterlockenable AND PIO_LED_s1_any_continuerequest));
  --PIO_LED_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      PIO_LED_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(PIO_LED_s1_begins_xfer) = '1' then 
        PIO_LED_s1_reg_firsttransfer <= PIO_LED_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --PIO_LED_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  PIO_LED_s1_beginbursttransfer_internal <= PIO_LED_s1_begins_xfer;
  --~PIO_LED_s1_write_n assignment, which is an e_mux
  PIO_LED_s1_write_n <= NOT ((((internal_CORE_data_master_granted_PIO_LED_s1 AND CORE_data_master_write)) AND PIO_LED_s1_pretend_byte_enable));
  shifted_address_to_PIO_LED_s1_from_CORE_data_master <= CORE_data_master_address_to_slave;
  --PIO_LED_s1_address mux, which is an e_mux
  PIO_LED_s1_address <= A_EXT (A_SRL(shifted_address_to_PIO_LED_s1_from_CORE_data_master,std_logic_vector'("00000000000000000000000000000010")), 2);
  --d1_PIO_LED_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_PIO_LED_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_PIO_LED_s1_end_xfer <= PIO_LED_s1_end_xfer;
    end if;

  end process;

  --PIO_LED_s1_waits_for_read in a cycle, which is an e_mux
  PIO_LED_s1_waits_for_read <= PIO_LED_s1_in_a_read_cycle AND PIO_LED_s1_begins_xfer;
  --PIO_LED_s1_in_a_read_cycle assignment, which is an e_assign
  PIO_LED_s1_in_a_read_cycle <= internal_CORE_data_master_granted_PIO_LED_s1 AND CORE_data_master_read;
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= PIO_LED_s1_in_a_read_cycle;
  --PIO_LED_s1_waits_for_write in a cycle, which is an e_mux
  PIO_LED_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(PIO_LED_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --PIO_LED_s1_in_a_write_cycle assignment, which is an e_assign
  PIO_LED_s1_in_a_write_cycle <= internal_CORE_data_master_granted_PIO_LED_s1 AND CORE_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= PIO_LED_s1_in_a_write_cycle;
  wait_for_PIO_LED_s1_counter <= std_logic'('0');
  --PIO_LED_s1_pretend_byte_enable byte enable port mux, which is an e_mux
  PIO_LED_s1_pretend_byte_enable <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'((internal_CORE_data_master_granted_PIO_LED_s1)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (CORE_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))));
  --vhdl renameroo for output signals
  CORE_data_master_granted_PIO_LED_s1 <= internal_CORE_data_master_granted_PIO_LED_s1;
  --vhdl renameroo for output signals
  CORE_data_master_qualified_request_PIO_LED_s1 <= internal_CORE_data_master_qualified_request_PIO_LED_s1;
  --vhdl renameroo for output signals
  CORE_data_master_requests_PIO_LED_s1 <= internal_CORE_data_master_requests_PIO_LED_s1;
--synthesis translate_off
    --PIO_LED/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity RAM_s1_arbitrator is 
        port (
              -- inputs:
                 signal CORE_data_master_address_to_slave : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal CORE_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal CORE_data_master_read : IN STD_LOGIC;
                 signal CORE_data_master_waitrequest : IN STD_LOGIC;
                 signal CORE_data_master_write : IN STD_LOGIC;
                 signal CORE_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal CORE_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                 signal CORE_instruction_master_read : IN STD_LOGIC;
                 signal RAM_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal clk : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal CORE_data_master_granted_RAM_s1 : OUT STD_LOGIC;
                 signal CORE_data_master_qualified_request_RAM_s1 : OUT STD_LOGIC;
                 signal CORE_data_master_read_data_valid_RAM_s1 : OUT STD_LOGIC;
                 signal CORE_data_master_requests_RAM_s1 : OUT STD_LOGIC;
                 signal CORE_instruction_master_granted_RAM_s1 : OUT STD_LOGIC;
                 signal CORE_instruction_master_qualified_request_RAM_s1 : OUT STD_LOGIC;
                 signal CORE_instruction_master_read_data_valid_RAM_s1 : OUT STD_LOGIC;
                 signal CORE_instruction_master_requests_RAM_s1 : OUT STD_LOGIC;
                 signal RAM_s1_address : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);
                 signal RAM_s1_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                 signal RAM_s1_chipselect : OUT STD_LOGIC;
                 signal RAM_s1_clken : OUT STD_LOGIC;
                 signal RAM_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal RAM_s1_write : OUT STD_LOGIC;
                 signal RAM_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                 signal d1_RAM_s1_end_xfer : OUT STD_LOGIC;
                 signal registered_CORE_data_master_read_data_valid_RAM_s1 : OUT STD_LOGIC
              );
end entity RAM_s1_arbitrator;


architecture europa of RAM_s1_arbitrator is
                signal CORE_data_master_arbiterlock :  STD_LOGIC;
                signal CORE_data_master_arbiterlock2 :  STD_LOGIC;
                signal CORE_data_master_continuerequest :  STD_LOGIC;
                signal CORE_data_master_read_data_valid_RAM_s1_shift_register :  STD_LOGIC;
                signal CORE_data_master_read_data_valid_RAM_s1_shift_register_in :  STD_LOGIC;
                signal CORE_data_master_saved_grant_RAM_s1 :  STD_LOGIC;
                signal CORE_instruction_master_arbiterlock :  STD_LOGIC;
                signal CORE_instruction_master_arbiterlock2 :  STD_LOGIC;
                signal CORE_instruction_master_continuerequest :  STD_LOGIC;
                signal CORE_instruction_master_read_data_valid_RAM_s1_shift_register :  STD_LOGIC;
                signal CORE_instruction_master_read_data_valid_RAM_s1_shift_register_in :  STD_LOGIC;
                signal CORE_instruction_master_saved_grant_RAM_s1 :  STD_LOGIC;
                signal RAM_s1_allgrants :  STD_LOGIC;
                signal RAM_s1_allow_new_arb_cycle :  STD_LOGIC;
                signal RAM_s1_any_bursting_master_saved_grant :  STD_LOGIC;
                signal RAM_s1_any_continuerequest :  STD_LOGIC;
                signal RAM_s1_arb_addend :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal RAM_s1_arb_counter_enable :  STD_LOGIC;
                signal RAM_s1_arb_share_counter :  STD_LOGIC;
                signal RAM_s1_arb_share_counter_next_value :  STD_LOGIC;
                signal RAM_s1_arb_share_set_values :  STD_LOGIC;
                signal RAM_s1_arb_winner :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal RAM_s1_arbitration_holdoff_internal :  STD_LOGIC;
                signal RAM_s1_beginbursttransfer_internal :  STD_LOGIC;
                signal RAM_s1_begins_xfer :  STD_LOGIC;
                signal RAM_s1_chosen_master_double_vector :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal RAM_s1_chosen_master_rot_left :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal RAM_s1_end_xfer :  STD_LOGIC;
                signal RAM_s1_firsttransfer :  STD_LOGIC;
                signal RAM_s1_grant_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal RAM_s1_in_a_read_cycle :  STD_LOGIC;
                signal RAM_s1_in_a_write_cycle :  STD_LOGIC;
                signal RAM_s1_master_qreq_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal RAM_s1_non_bursting_master_requests :  STD_LOGIC;
                signal RAM_s1_reg_firsttransfer :  STD_LOGIC;
                signal RAM_s1_saved_chosen_master_vector :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal RAM_s1_slavearbiterlockenable :  STD_LOGIC;
                signal RAM_s1_slavearbiterlockenable2 :  STD_LOGIC;
                signal RAM_s1_unreg_firsttransfer :  STD_LOGIC;
                signal RAM_s1_waits_for_read :  STD_LOGIC;
                signal RAM_s1_waits_for_write :  STD_LOGIC;
                signal d1_reasons_to_wait :  STD_LOGIC;
                signal enable_nonzero_assertions :  STD_LOGIC;
                signal end_xfer_arb_share_counter_term_RAM_s1 :  STD_LOGIC;
                signal in_a_read_cycle :  STD_LOGIC;
                signal in_a_write_cycle :  STD_LOGIC;
                signal internal_CORE_data_master_granted_RAM_s1 :  STD_LOGIC;
                signal internal_CORE_data_master_qualified_request_RAM_s1 :  STD_LOGIC;
                signal internal_CORE_data_master_requests_RAM_s1 :  STD_LOGIC;
                signal internal_CORE_instruction_master_granted_RAM_s1 :  STD_LOGIC;
                signal internal_CORE_instruction_master_qualified_request_RAM_s1 :  STD_LOGIC;
                signal internal_CORE_instruction_master_requests_RAM_s1 :  STD_LOGIC;
                signal last_cycle_CORE_data_master_granted_slave_RAM_s1 :  STD_LOGIC;
                signal last_cycle_CORE_instruction_master_granted_slave_RAM_s1 :  STD_LOGIC;
                signal p1_CORE_data_master_read_data_valid_RAM_s1_shift_register :  STD_LOGIC;
                signal p1_CORE_instruction_master_read_data_valid_RAM_s1_shift_register :  STD_LOGIC;
                signal shifted_address_to_RAM_s1_from_CORE_data_master :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal shifted_address_to_RAM_s1_from_CORE_instruction_master :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal wait_for_RAM_s1_counter :  STD_LOGIC;

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_reasons_to_wait <= std_logic'('0');
    elsif clk'event and clk = '1' then
      d1_reasons_to_wait <= NOT RAM_s1_end_xfer;
    end if;

  end process;

  RAM_s1_begins_xfer <= NOT d1_reasons_to_wait AND ((internal_CORE_data_master_qualified_request_RAM_s1 OR internal_CORE_instruction_master_qualified_request_RAM_s1));
  --assign RAM_s1_readdata_from_sa = RAM_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  RAM_s1_readdata_from_sa <= RAM_s1_readdata;
  internal_CORE_data_master_requests_RAM_s1 <= to_std_logic(((Std_Logic_Vector'(CORE_data_master_address_to_slave(17 DOWNTO 16) & std_logic_vector'("0000000000000000")) = std_logic_vector'("010000000000000000")))) AND ((CORE_data_master_read OR CORE_data_master_write));
  --registered rdv signal_name registered_CORE_data_master_read_data_valid_RAM_s1 assignment, which is an e_assign
  registered_CORE_data_master_read_data_valid_RAM_s1 <= CORE_data_master_read_data_valid_RAM_s1_shift_register_in;
  --RAM_s1_arb_share_counter set values, which is an e_mux
  RAM_s1_arb_share_set_values <= std_logic'('1');
  --RAM_s1_non_bursting_master_requests mux, which is an e_mux
  RAM_s1_non_bursting_master_requests <= ((internal_CORE_data_master_requests_RAM_s1 OR internal_CORE_instruction_master_requests_RAM_s1) OR internal_CORE_data_master_requests_RAM_s1) OR internal_CORE_instruction_master_requests_RAM_s1;
  --RAM_s1_any_bursting_master_saved_grant mux, which is an e_mux
  RAM_s1_any_bursting_master_saved_grant <= std_logic'('0');
  --RAM_s1_arb_share_counter_next_value assignment, which is an e_assign
  RAM_s1_arb_share_counter_next_value <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(RAM_s1_firsttransfer) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(RAM_s1_arb_share_set_values))) - std_logic_vector'("000000000000000000000000000000001"))), A_WE_StdLogicVector((std_logic'(RAM_s1_arb_share_counter) = '1'), (((std_logic_vector'("00000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(RAM_s1_arb_share_counter))) - std_logic_vector'("000000000000000000000000000000001"))), std_logic_vector'("000000000000000000000000000000000"))));
  --RAM_s1_allgrants all slave grants, which is an e_mux
  RAM_s1_allgrants <= (((or_reduce(RAM_s1_grant_vector)) OR (or_reduce(RAM_s1_grant_vector))) OR (or_reduce(RAM_s1_grant_vector))) OR (or_reduce(RAM_s1_grant_vector));
  --RAM_s1_end_xfer assignment, which is an e_assign
  RAM_s1_end_xfer <= NOT ((RAM_s1_waits_for_read OR RAM_s1_waits_for_write));
  --end_xfer_arb_share_counter_term_RAM_s1 arb share counter enable term, which is an e_assign
  end_xfer_arb_share_counter_term_RAM_s1 <= RAM_s1_end_xfer AND (((NOT RAM_s1_any_bursting_master_saved_grant OR in_a_read_cycle) OR in_a_write_cycle));
  --RAM_s1_arb_share_counter arbitration counter enable, which is an e_assign
  RAM_s1_arb_counter_enable <= ((end_xfer_arb_share_counter_term_RAM_s1 AND RAM_s1_allgrants)) OR ((end_xfer_arb_share_counter_term_RAM_s1 AND NOT RAM_s1_non_bursting_master_requests));
  --RAM_s1_arb_share_counter counter, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      RAM_s1_arb_share_counter <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'(RAM_s1_arb_counter_enable) = '1' then 
        RAM_s1_arb_share_counter <= RAM_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --RAM_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      RAM_s1_slavearbiterlockenable <= std_logic'('0');
    elsif clk'event and clk = '1' then
      if std_logic'((((or_reduce(RAM_s1_master_qreq_vector) AND end_xfer_arb_share_counter_term_RAM_s1)) OR ((end_xfer_arb_share_counter_term_RAM_s1 AND NOT RAM_s1_non_bursting_master_requests)))) = '1' then 
        RAM_s1_slavearbiterlockenable <= RAM_s1_arb_share_counter_next_value;
      end if;
    end if;

  end process;

  --CORE/data_master RAM/s1 arbiterlock, which is an e_assign
  CORE_data_master_arbiterlock <= RAM_s1_slavearbiterlockenable AND CORE_data_master_continuerequest;
  --RAM_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  RAM_s1_slavearbiterlockenable2 <= RAM_s1_arb_share_counter_next_value;
  --CORE/data_master RAM/s1 arbiterlock2, which is an e_assign
  CORE_data_master_arbiterlock2 <= RAM_s1_slavearbiterlockenable2 AND CORE_data_master_continuerequest;
  --CORE/instruction_master RAM/s1 arbiterlock, which is an e_assign
  CORE_instruction_master_arbiterlock <= RAM_s1_slavearbiterlockenable AND CORE_instruction_master_continuerequest;
  --CORE/instruction_master RAM/s1 arbiterlock2, which is an e_assign
  CORE_instruction_master_arbiterlock2 <= RAM_s1_slavearbiterlockenable2 AND CORE_instruction_master_continuerequest;
  --CORE/instruction_master granted RAM/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_CORE_instruction_master_granted_slave_RAM_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_CORE_instruction_master_granted_slave_RAM_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(CORE_instruction_master_saved_grant_RAM_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((RAM_s1_arbitration_holdoff_internal OR NOT internal_CORE_instruction_master_requests_RAM_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_CORE_instruction_master_granted_slave_RAM_s1))))));
    end if;

  end process;

  --CORE_instruction_master_continuerequest continued request, which is an e_mux
  CORE_instruction_master_continuerequest <= last_cycle_CORE_instruction_master_granted_slave_RAM_s1 AND internal_CORE_instruction_master_requests_RAM_s1;
  --RAM_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  RAM_s1_any_continuerequest <= CORE_instruction_master_continuerequest OR CORE_data_master_continuerequest;
  internal_CORE_data_master_qualified_request_RAM_s1 <= internal_CORE_data_master_requests_RAM_s1 AND NOT (((((CORE_data_master_read AND (CORE_data_master_read_data_valid_RAM_s1_shift_register))) OR (((NOT CORE_data_master_waitrequest) AND CORE_data_master_write))) OR CORE_instruction_master_arbiterlock));
  --CORE_data_master_read_data_valid_RAM_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  CORE_data_master_read_data_valid_RAM_s1_shift_register_in <= ((internal_CORE_data_master_granted_RAM_s1 AND CORE_data_master_read) AND NOT RAM_s1_waits_for_read) AND NOT (CORE_data_master_read_data_valid_RAM_s1_shift_register);
  --shift register p1 CORE_data_master_read_data_valid_RAM_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_CORE_data_master_read_data_valid_RAM_s1_shift_register <= Vector_To_Std_Logic(Std_Logic_Vector'(A_ToStdLogicVector(CORE_data_master_read_data_valid_RAM_s1_shift_register) & A_ToStdLogicVector(CORE_data_master_read_data_valid_RAM_s1_shift_register_in)));
  --CORE_data_master_read_data_valid_RAM_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CORE_data_master_read_data_valid_RAM_s1_shift_register <= std_logic'('0');
    elsif clk'event and clk = '1' then
      CORE_data_master_read_data_valid_RAM_s1_shift_register <= p1_CORE_data_master_read_data_valid_RAM_s1_shift_register;
    end if;

  end process;

  --local readdatavalid CORE_data_master_read_data_valid_RAM_s1, which is an e_mux
  CORE_data_master_read_data_valid_RAM_s1 <= CORE_data_master_read_data_valid_RAM_s1_shift_register;
  --RAM_s1_writedata mux, which is an e_mux
  RAM_s1_writedata <= CORE_data_master_writedata;
  --mux RAM_s1_clken, which is an e_mux
  RAM_s1_clken <= std_logic'('1');
  internal_CORE_instruction_master_requests_RAM_s1 <= ((to_std_logic(((Std_Logic_Vector'(CORE_instruction_master_address_to_slave(17 DOWNTO 16) & std_logic_vector'("0000000000000000")) = std_logic_vector'("010000000000000000")))) AND (CORE_instruction_master_read))) AND CORE_instruction_master_read;
  --CORE/data_master granted RAM/s1 last time, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      last_cycle_CORE_data_master_granted_slave_RAM_s1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      last_cycle_CORE_data_master_granted_slave_RAM_s1 <= Vector_To_Std_Logic(A_WE_StdLogicVector((std_logic'(CORE_data_master_saved_grant_RAM_s1) = '1'), std_logic_vector'("00000000000000000000000000000001"), A_WE_StdLogicVector((std_logic'(((RAM_s1_arbitration_holdoff_internal OR NOT internal_CORE_data_master_requests_RAM_s1))) = '1'), std_logic_vector'("00000000000000000000000000000000"), (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(last_cycle_CORE_data_master_granted_slave_RAM_s1))))));
    end if;

  end process;

  --CORE_data_master_continuerequest continued request, which is an e_mux
  CORE_data_master_continuerequest <= last_cycle_CORE_data_master_granted_slave_RAM_s1 AND internal_CORE_data_master_requests_RAM_s1;
  internal_CORE_instruction_master_qualified_request_RAM_s1 <= internal_CORE_instruction_master_requests_RAM_s1 AND NOT ((((CORE_instruction_master_read AND (CORE_instruction_master_read_data_valid_RAM_s1_shift_register))) OR CORE_data_master_arbiterlock));
  --CORE_instruction_master_read_data_valid_RAM_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  CORE_instruction_master_read_data_valid_RAM_s1_shift_register_in <= ((internal_CORE_instruction_master_granted_RAM_s1 AND CORE_instruction_master_read) AND NOT RAM_s1_waits_for_read) AND NOT (CORE_instruction_master_read_data_valid_RAM_s1_shift_register);
  --shift register p1 CORE_instruction_master_read_data_valid_RAM_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  p1_CORE_instruction_master_read_data_valid_RAM_s1_shift_register <= Vector_To_Std_Logic(Std_Logic_Vector'(A_ToStdLogicVector(CORE_instruction_master_read_data_valid_RAM_s1_shift_register) & A_ToStdLogicVector(CORE_instruction_master_read_data_valid_RAM_s1_shift_register_in)));
  --CORE_instruction_master_read_data_valid_RAM_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      CORE_instruction_master_read_data_valid_RAM_s1_shift_register <= std_logic'('0');
    elsif clk'event and clk = '1' then
      CORE_instruction_master_read_data_valid_RAM_s1_shift_register <= p1_CORE_instruction_master_read_data_valid_RAM_s1_shift_register;
    end if;

  end process;

  --local readdatavalid CORE_instruction_master_read_data_valid_RAM_s1, which is an e_mux
  CORE_instruction_master_read_data_valid_RAM_s1 <= CORE_instruction_master_read_data_valid_RAM_s1_shift_register;
  --allow new arb cycle for RAM/s1, which is an e_assign
  RAM_s1_allow_new_arb_cycle <= NOT CORE_data_master_arbiterlock AND NOT CORE_instruction_master_arbiterlock;
  --CORE/instruction_master assignment into master qualified-requests vector for RAM/s1, which is an e_assign
  RAM_s1_master_qreq_vector(0) <= internal_CORE_instruction_master_qualified_request_RAM_s1;
  --CORE/instruction_master grant RAM/s1, which is an e_assign
  internal_CORE_instruction_master_granted_RAM_s1 <= RAM_s1_grant_vector(0);
  --CORE/instruction_master saved-grant RAM/s1, which is an e_assign
  CORE_instruction_master_saved_grant_RAM_s1 <= RAM_s1_arb_winner(0) AND internal_CORE_instruction_master_requests_RAM_s1;
  --CORE/data_master assignment into master qualified-requests vector for RAM/s1, which is an e_assign
  RAM_s1_master_qreq_vector(1) <= internal_CORE_data_master_qualified_request_RAM_s1;
  --CORE/data_master grant RAM/s1, which is an e_assign
  internal_CORE_data_master_granted_RAM_s1 <= RAM_s1_grant_vector(1);
  --CORE/data_master saved-grant RAM/s1, which is an e_assign
  CORE_data_master_saved_grant_RAM_s1 <= RAM_s1_arb_winner(1) AND internal_CORE_data_master_requests_RAM_s1;
  --RAM/s1 chosen-master double-vector, which is an e_assign
  RAM_s1_chosen_master_double_vector <= A_EXT (((std_logic_vector'("0") & ((RAM_s1_master_qreq_vector & RAM_s1_master_qreq_vector))) AND (((std_logic_vector'("0") & (Std_Logic_Vector'(NOT RAM_s1_master_qreq_vector & NOT RAM_s1_master_qreq_vector))) + (std_logic_vector'("000") & (RAM_s1_arb_addend))))), 4);
  --stable onehot encoding of arb winner
  RAM_s1_arb_winner <= A_WE_StdLogicVector((std_logic'(((RAM_s1_allow_new_arb_cycle AND or_reduce(RAM_s1_grant_vector)))) = '1'), RAM_s1_grant_vector, RAM_s1_saved_chosen_master_vector);
  --saved RAM_s1_grant_vector, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      RAM_s1_saved_chosen_master_vector <= std_logic_vector'("00");
    elsif clk'event and clk = '1' then
      if std_logic'(RAM_s1_allow_new_arb_cycle) = '1' then 
        RAM_s1_saved_chosen_master_vector <= A_WE_StdLogicVector((std_logic'(or_reduce(RAM_s1_grant_vector)) = '1'), RAM_s1_grant_vector, RAM_s1_saved_chosen_master_vector);
      end if;
    end if;

  end process;

  --onehot encoding of chosen master
  RAM_s1_grant_vector <= Std_Logic_Vector'(A_ToStdLogicVector(((RAM_s1_chosen_master_double_vector(1) OR RAM_s1_chosen_master_double_vector(3)))) & A_ToStdLogicVector(((RAM_s1_chosen_master_double_vector(0) OR RAM_s1_chosen_master_double_vector(2)))));
  --RAM/s1 chosen master rotated left, which is an e_assign
  RAM_s1_chosen_master_rot_left <= A_EXT (A_WE_StdLogicVector((((A_SLL(RAM_s1_arb_winner,std_logic_vector'("00000000000000000000000000000001")))) /= std_logic_vector'("00")), (std_logic_vector'("000000000000000000000000000000") & ((A_SLL(RAM_s1_arb_winner,std_logic_vector'("00000000000000000000000000000001"))))), std_logic_vector'("00000000000000000000000000000001")), 2);
  --RAM/s1's addend for next-master-grant
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      RAM_s1_arb_addend <= std_logic_vector'("01");
    elsif clk'event and clk = '1' then
      if std_logic'(or_reduce(RAM_s1_grant_vector)) = '1' then 
        RAM_s1_arb_addend <= A_WE_StdLogicVector((std_logic'(RAM_s1_end_xfer) = '1'), RAM_s1_chosen_master_rot_left, RAM_s1_grant_vector);
      end if;
    end if;

  end process;

  RAM_s1_chipselect <= internal_CORE_data_master_granted_RAM_s1 OR internal_CORE_instruction_master_granted_RAM_s1;
  --RAM_s1_firsttransfer first transaction, which is an e_assign
  RAM_s1_firsttransfer <= A_WE_StdLogic((std_logic'(RAM_s1_begins_xfer) = '1'), RAM_s1_unreg_firsttransfer, RAM_s1_reg_firsttransfer);
  --RAM_s1_unreg_firsttransfer first transaction, which is an e_assign
  RAM_s1_unreg_firsttransfer <= NOT ((RAM_s1_slavearbiterlockenable AND RAM_s1_any_continuerequest));
  --RAM_s1_reg_firsttransfer first transaction, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      RAM_s1_reg_firsttransfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      if std_logic'(RAM_s1_begins_xfer) = '1' then 
        RAM_s1_reg_firsttransfer <= RAM_s1_unreg_firsttransfer;
      end if;
    end if;

  end process;

  --RAM_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  RAM_s1_beginbursttransfer_internal <= RAM_s1_begins_xfer;
  --RAM_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  RAM_s1_arbitration_holdoff_internal <= RAM_s1_begins_xfer AND RAM_s1_firsttransfer;
  --RAM_s1_write assignment, which is an e_mux
  RAM_s1_write <= internal_CORE_data_master_granted_RAM_s1 AND CORE_data_master_write;
  shifted_address_to_RAM_s1_from_CORE_data_master <= CORE_data_master_address_to_slave;
  --RAM_s1_address mux, which is an e_mux
  RAM_s1_address <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CORE_data_master_granted_RAM_s1)) = '1'), (A_SRL(shifted_address_to_RAM_s1_from_CORE_data_master,std_logic_vector'("00000000000000000000000000000010"))), (A_SRL(shifted_address_to_RAM_s1_from_CORE_instruction_master,std_logic_vector'("00000000000000000000000000000010")))), 14);
  shifted_address_to_RAM_s1_from_CORE_instruction_master <= CORE_instruction_master_address_to_slave;
  --d1_RAM_s1_end_xfer register, which is an e_register
  process (clk, reset_n)
  begin
    if reset_n = '0' then
      d1_RAM_s1_end_xfer <= std_logic'('1');
    elsif clk'event and clk = '1' then
      d1_RAM_s1_end_xfer <= RAM_s1_end_xfer;
    end if;

  end process;

  --RAM_s1_waits_for_read in a cycle, which is an e_mux
  RAM_s1_waits_for_read <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(RAM_s1_in_a_read_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --RAM_s1_in_a_read_cycle assignment, which is an e_assign
  RAM_s1_in_a_read_cycle <= ((internal_CORE_data_master_granted_RAM_s1 AND CORE_data_master_read)) OR ((internal_CORE_instruction_master_granted_RAM_s1 AND CORE_instruction_master_read));
  --in_a_read_cycle assignment, which is an e_mux
  in_a_read_cycle <= RAM_s1_in_a_read_cycle;
  --RAM_s1_waits_for_write in a cycle, which is an e_mux
  RAM_s1_waits_for_write <= Vector_To_Std_Logic(((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(RAM_s1_in_a_write_cycle))) AND std_logic_vector'("00000000000000000000000000000000")));
  --RAM_s1_in_a_write_cycle assignment, which is an e_assign
  RAM_s1_in_a_write_cycle <= internal_CORE_data_master_granted_RAM_s1 AND CORE_data_master_write;
  --in_a_write_cycle assignment, which is an e_mux
  in_a_write_cycle <= RAM_s1_in_a_write_cycle;
  wait_for_RAM_s1_counter <= std_logic'('0');
  --RAM_s1_byteenable byte enable port mux, which is an e_mux
  RAM_s1_byteenable <= A_EXT (A_WE_StdLogicVector((std_logic'((internal_CORE_data_master_granted_RAM_s1)) = '1'), (std_logic_vector'("0000000000000000000000000000") & (CORE_data_master_byteenable)), -SIGNED(std_logic_vector'("00000000000000000000000000000001"))), 4);
  --vhdl renameroo for output signals
  CORE_data_master_granted_RAM_s1 <= internal_CORE_data_master_granted_RAM_s1;
  --vhdl renameroo for output signals
  CORE_data_master_qualified_request_RAM_s1 <= internal_CORE_data_master_qualified_request_RAM_s1;
  --vhdl renameroo for output signals
  CORE_data_master_requests_RAM_s1 <= internal_CORE_data_master_requests_RAM_s1;
  --vhdl renameroo for output signals
  CORE_instruction_master_granted_RAM_s1 <= internal_CORE_instruction_master_granted_RAM_s1;
  --vhdl renameroo for output signals
  CORE_instruction_master_qualified_request_RAM_s1 <= internal_CORE_instruction_master_qualified_request_RAM_s1;
  --vhdl renameroo for output signals
  CORE_instruction_master_requests_RAM_s1 <= internal_CORE_instruction_master_requests_RAM_s1;
--synthesis translate_off
    --RAM/s1 enable non-zero assertions, which is an e_register
    process (clk, reset_n)
    begin
      if reset_n = '0' then
        enable_nonzero_assertions <= std_logic'('0');
      elsif clk'event and clk = '1' then
        enable_nonzero_assertions <= std_logic'('1');
      end if;

    end process;

    --grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line4 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_CORE_data_master_granted_RAM_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(internal_CORE_instruction_master_granted_RAM_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line4, now);
          write(write_line4, string'(": "));
          write(write_line4, string'("> 1 of grant signals are active simultaneously"));
          write(output, write_line4.all);
          deallocate (write_line4);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

    --saved_grant signals are active simultaneously, which is an e_process
    process (clk)
    VARIABLE write_line5 : line;
    begin
      if clk'event and clk = '1' then
        if (std_logic_vector'("000000000000000000000000000000") & (((std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(CORE_data_master_saved_grant_RAM_s1))) + (std_logic_vector'("0") & (A_TOSTDLOGICVECTOR(CORE_instruction_master_saved_grant_RAM_s1))))))>std_logic_vector'("00000000000000000000000000000001") then 
          write(write_line5, now);
          write(write_line5, string'(": "));
          write(write_line5, string'("> 1 of saved_grant signals are active simultaneously"));
          write(output, write_line5.all);
          deallocate (write_line5);
          assert false report "VHDL STOP" severity failure;
        end if;
      end if;

    end process;

--synthesis translate_on

end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Nios2_reset_clk_0_domain_synch_module is 
        port (
              -- inputs:
                 signal clk : IN STD_LOGIC;
                 signal data_in : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- outputs:
                 signal data_out : OUT STD_LOGIC
              );
end entity Nios2_reset_clk_0_domain_synch_module;


architecture europa of Nios2_reset_clk_0_domain_synch_module is
                signal data_in_d1 :  STD_LOGIC;
attribute ALTERA_ATTRIBUTE : string;
attribute ALTERA_ATTRIBUTE of data_in_d1 : signal is "{-from ""*""} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";
attribute ALTERA_ATTRIBUTE of data_out : signal is "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101";

begin

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_in_d1 <= std_logic'('0');
    elsif clk'event and clk = '1' then
      data_in_d1 <= data_in;
    end if;

  end process;

  process (clk, reset_n)
  begin
    if reset_n = '0' then
      data_out <= std_logic'('0');
    elsif clk'event and clk = '1' then
      data_out <= data_in_d1;
    end if;

  end process;


end europa;



-- turn off superfluous VHDL processor warnings 
-- altera message_level Level1 
-- altera message_off 10034 10035 10036 10037 10230 10240 10030 

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Nios2 is 
        port (
              -- 1) global signals:
                 signal clk_0 : IN STD_LOGIC;
                 signal reset_n : IN STD_LOGIC;

              -- the_PIO_LED
                 signal out_port_from_the_PIO_LED : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
              );
end entity Nios2;


architecture europa of Nios2 is
component CORE_jtag_debug_module_arbitrator is 
           port (
                 -- inputs:
                    signal CORE_data_master_address_to_slave : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal CORE_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal CORE_data_master_debugaccess : IN STD_LOGIC;
                    signal CORE_data_master_read : IN STD_LOGIC;
                    signal CORE_data_master_waitrequest : IN STD_LOGIC;
                    signal CORE_data_master_write : IN STD_LOGIC;
                    signal CORE_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal CORE_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal CORE_instruction_master_read : IN STD_LOGIC;
                    signal CORE_jtag_debug_module_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal CORE_jtag_debug_module_resetrequest : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CORE_data_master_granted_CORE_jtag_debug_module : OUT STD_LOGIC;
                    signal CORE_data_master_qualified_request_CORE_jtag_debug_module : OUT STD_LOGIC;
                    signal CORE_data_master_read_data_valid_CORE_jtag_debug_module : OUT STD_LOGIC;
                    signal CORE_data_master_requests_CORE_jtag_debug_module : OUT STD_LOGIC;
                    signal CORE_instruction_master_granted_CORE_jtag_debug_module : OUT STD_LOGIC;
                    signal CORE_instruction_master_qualified_request_CORE_jtag_debug_module : OUT STD_LOGIC;
                    signal CORE_instruction_master_read_data_valid_CORE_jtag_debug_module : OUT STD_LOGIC;
                    signal CORE_instruction_master_requests_CORE_jtag_debug_module : OUT STD_LOGIC;
                    signal CORE_jtag_debug_module_address : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal CORE_jtag_debug_module_begintransfer : OUT STD_LOGIC;
                    signal CORE_jtag_debug_module_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal CORE_jtag_debug_module_chipselect : OUT STD_LOGIC;
                    signal CORE_jtag_debug_module_debugaccess : OUT STD_LOGIC;
                    signal CORE_jtag_debug_module_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal CORE_jtag_debug_module_reset_n : OUT STD_LOGIC;
                    signal CORE_jtag_debug_module_resetrequest_from_sa : OUT STD_LOGIC;
                    signal CORE_jtag_debug_module_write : OUT STD_LOGIC;
                    signal CORE_jtag_debug_module_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_CORE_jtag_debug_module_end_xfer : OUT STD_LOGIC
                 );
end component CORE_jtag_debug_module_arbitrator;

component CORE_data_master_arbitrator is 
           port (
                 -- inputs:
                    signal CORE_data_master_address : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal CORE_data_master_granted_CORE_jtag_debug_module : IN STD_LOGIC;
                    signal CORE_data_master_granted_JTAG_DEBUG_avalon_jtag_slave : IN STD_LOGIC;
                    signal CORE_data_master_granted_PIO_LED_s1 : IN STD_LOGIC;
                    signal CORE_data_master_granted_RAM_s1 : IN STD_LOGIC;
                    signal CORE_data_master_qualified_request_CORE_jtag_debug_module : IN STD_LOGIC;
                    signal CORE_data_master_qualified_request_JTAG_DEBUG_avalon_jtag_slave : IN STD_LOGIC;
                    signal CORE_data_master_qualified_request_PIO_LED_s1 : IN STD_LOGIC;
                    signal CORE_data_master_qualified_request_RAM_s1 : IN STD_LOGIC;
                    signal CORE_data_master_read : IN STD_LOGIC;
                    signal CORE_data_master_read_data_valid_CORE_jtag_debug_module : IN STD_LOGIC;
                    signal CORE_data_master_read_data_valid_JTAG_DEBUG_avalon_jtag_slave : IN STD_LOGIC;
                    signal CORE_data_master_read_data_valid_PIO_LED_s1 : IN STD_LOGIC;
                    signal CORE_data_master_read_data_valid_RAM_s1 : IN STD_LOGIC;
                    signal CORE_data_master_requests_CORE_jtag_debug_module : IN STD_LOGIC;
                    signal CORE_data_master_requests_JTAG_DEBUG_avalon_jtag_slave : IN STD_LOGIC;
                    signal CORE_data_master_requests_PIO_LED_s1 : IN STD_LOGIC;
                    signal CORE_data_master_requests_RAM_s1 : IN STD_LOGIC;
                    signal CORE_data_master_write : IN STD_LOGIC;
                    signal CORE_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal JTAG_DEBUG_avalon_jtag_slave_irq_from_sa : IN STD_LOGIC;
                    signal JTAG_DEBUG_avalon_jtag_slave_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal JTAG_DEBUG_avalon_jtag_slave_waitrequest_from_sa : IN STD_LOGIC;
                    signal PIO_LED_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal RAM_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal d1_CORE_jtag_debug_module_end_xfer : IN STD_LOGIC;
                    signal d1_JTAG_DEBUG_avalon_jtag_slave_end_xfer : IN STD_LOGIC;
                    signal d1_PIO_LED_s1_end_xfer : IN STD_LOGIC;
                    signal d1_RAM_s1_end_xfer : IN STD_LOGIC;
                    signal registered_CORE_data_master_read_data_valid_RAM_s1 : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CORE_data_master_address_to_slave : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal CORE_data_master_irq : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal CORE_data_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal CORE_data_master_waitrequest : OUT STD_LOGIC
                 );
end component CORE_data_master_arbitrator;

component CORE_instruction_master_arbitrator is 
           port (
                 -- inputs:
                    signal CORE_instruction_master_address : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal CORE_instruction_master_granted_CORE_jtag_debug_module : IN STD_LOGIC;
                    signal CORE_instruction_master_granted_RAM_s1 : IN STD_LOGIC;
                    signal CORE_instruction_master_qualified_request_CORE_jtag_debug_module : IN STD_LOGIC;
                    signal CORE_instruction_master_qualified_request_RAM_s1 : IN STD_LOGIC;
                    signal CORE_instruction_master_read : IN STD_LOGIC;
                    signal CORE_instruction_master_read_data_valid_CORE_jtag_debug_module : IN STD_LOGIC;
                    signal CORE_instruction_master_read_data_valid_RAM_s1 : IN STD_LOGIC;
                    signal CORE_instruction_master_requests_CORE_jtag_debug_module : IN STD_LOGIC;
                    signal CORE_instruction_master_requests_RAM_s1 : IN STD_LOGIC;
                    signal CORE_jtag_debug_module_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal RAM_s1_readdata_from_sa : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal d1_CORE_jtag_debug_module_end_xfer : IN STD_LOGIC;
                    signal d1_RAM_s1_end_xfer : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CORE_instruction_master_address_to_slave : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal CORE_instruction_master_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal CORE_instruction_master_waitrequest : OUT STD_LOGIC
                 );
end component CORE_instruction_master_arbitrator;

component CORE is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal d_irq : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d_waitrequest : IN STD_LOGIC;
                    signal i_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal i_waitrequest : IN STD_LOGIC;
                    signal jtag_debug_module_address : IN STD_LOGIC_VECTOR (8 DOWNTO 0);
                    signal jtag_debug_module_begintransfer : IN STD_LOGIC;
                    signal jtag_debug_module_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal jtag_debug_module_debugaccess : IN STD_LOGIC;
                    signal jtag_debug_module_select : IN STD_LOGIC;
                    signal jtag_debug_module_write : IN STD_LOGIC;
                    signal jtag_debug_module_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal d_address : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal d_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal d_read : OUT STD_LOGIC;
                    signal d_write : OUT STD_LOGIC;
                    signal d_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal i_address : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal i_read : OUT STD_LOGIC;
                    signal jtag_debug_module_debugaccess_to_roms : OUT STD_LOGIC;
                    signal jtag_debug_module_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal jtag_debug_module_resetrequest : OUT STD_LOGIC
                 );
end component CORE;

component JTAG_DEBUG_avalon_jtag_slave_arbitrator is 
           port (
                 -- inputs:
                    signal CORE_data_master_address_to_slave : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal CORE_data_master_read : IN STD_LOGIC;
                    signal CORE_data_master_waitrequest : IN STD_LOGIC;
                    signal CORE_data_master_write : IN STD_LOGIC;
                    signal CORE_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal JTAG_DEBUG_avalon_jtag_slave_dataavailable : IN STD_LOGIC;
                    signal JTAG_DEBUG_avalon_jtag_slave_irq : IN STD_LOGIC;
                    signal JTAG_DEBUG_avalon_jtag_slave_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal JTAG_DEBUG_avalon_jtag_slave_readyfordata : IN STD_LOGIC;
                    signal JTAG_DEBUG_avalon_jtag_slave_waitrequest : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CORE_data_master_granted_JTAG_DEBUG_avalon_jtag_slave : OUT STD_LOGIC;
                    signal CORE_data_master_qualified_request_JTAG_DEBUG_avalon_jtag_slave : OUT STD_LOGIC;
                    signal CORE_data_master_read_data_valid_JTAG_DEBUG_avalon_jtag_slave : OUT STD_LOGIC;
                    signal CORE_data_master_requests_JTAG_DEBUG_avalon_jtag_slave : OUT STD_LOGIC;
                    signal JTAG_DEBUG_avalon_jtag_slave_address : OUT STD_LOGIC;
                    signal JTAG_DEBUG_avalon_jtag_slave_chipselect : OUT STD_LOGIC;
                    signal JTAG_DEBUG_avalon_jtag_slave_dataavailable_from_sa : OUT STD_LOGIC;
                    signal JTAG_DEBUG_avalon_jtag_slave_irq_from_sa : OUT STD_LOGIC;
                    signal JTAG_DEBUG_avalon_jtag_slave_read_n : OUT STD_LOGIC;
                    signal JTAG_DEBUG_avalon_jtag_slave_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal JTAG_DEBUG_avalon_jtag_slave_readyfordata_from_sa : OUT STD_LOGIC;
                    signal JTAG_DEBUG_avalon_jtag_slave_reset_n : OUT STD_LOGIC;
                    signal JTAG_DEBUG_avalon_jtag_slave_waitrequest_from_sa : OUT STD_LOGIC;
                    signal JTAG_DEBUG_avalon_jtag_slave_write_n : OUT STD_LOGIC;
                    signal JTAG_DEBUG_avalon_jtag_slave_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_JTAG_DEBUG_avalon_jtag_slave_end_xfer : OUT STD_LOGIC
                 );
end component JTAG_DEBUG_avalon_jtag_slave_arbitrator;

component JTAG_DEBUG is 
           port (
                 -- inputs:
                    signal av_address : IN STD_LOGIC;
                    signal av_chipselect : IN STD_LOGIC;
                    signal av_read_n : IN STD_LOGIC;
                    signal av_write_n : IN STD_LOGIC;
                    signal av_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal rst_n : IN STD_LOGIC;

                 -- outputs:
                    signal av_irq : OUT STD_LOGIC;
                    signal av_readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal av_waitrequest : OUT STD_LOGIC;
                    signal dataavailable : OUT STD_LOGIC;
                    signal readyfordata : OUT STD_LOGIC
                 );
end component JTAG_DEBUG;

component PIO_LED_s1_arbitrator is 
           port (
                 -- inputs:
                    signal CORE_data_master_address_to_slave : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal CORE_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal CORE_data_master_read : IN STD_LOGIC;
                    signal CORE_data_master_waitrequest : IN STD_LOGIC;
                    signal CORE_data_master_write : IN STD_LOGIC;
                    signal CORE_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal PIO_LED_s1_readdata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CORE_data_master_granted_PIO_LED_s1 : OUT STD_LOGIC;
                    signal CORE_data_master_qualified_request_PIO_LED_s1 : OUT STD_LOGIC;
                    signal CORE_data_master_read_data_valid_PIO_LED_s1 : OUT STD_LOGIC;
                    signal CORE_data_master_requests_PIO_LED_s1 : OUT STD_LOGIC;
                    signal PIO_LED_s1_address : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal PIO_LED_s1_chipselect : OUT STD_LOGIC;
                    signal PIO_LED_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal PIO_LED_s1_reset_n : OUT STD_LOGIC;
                    signal PIO_LED_s1_write_n : OUT STD_LOGIC;
                    signal PIO_LED_s1_writedata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal d1_PIO_LED_s1_end_xfer : OUT STD_LOGIC
                 );
end component PIO_LED_s1_arbitrator;

component PIO_LED is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;
                    signal write_n : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (7 DOWNTO 0);

                 -- outputs:
                    signal out_port : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                    signal readdata : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
                 );
end component PIO_LED;

component RAM_s1_arbitrator is 
           port (
                 -- inputs:
                    signal CORE_data_master_address_to_slave : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal CORE_data_master_byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal CORE_data_master_read : IN STD_LOGIC;
                    signal CORE_data_master_waitrequest : IN STD_LOGIC;
                    signal CORE_data_master_write : IN STD_LOGIC;
                    signal CORE_data_master_writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal CORE_instruction_master_address_to_slave : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
                    signal CORE_instruction_master_read : IN STD_LOGIC;
                    signal RAM_s1_readdata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal clk : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal CORE_data_master_granted_RAM_s1 : OUT STD_LOGIC;
                    signal CORE_data_master_qualified_request_RAM_s1 : OUT STD_LOGIC;
                    signal CORE_data_master_read_data_valid_RAM_s1 : OUT STD_LOGIC;
                    signal CORE_data_master_requests_RAM_s1 : OUT STD_LOGIC;
                    signal CORE_instruction_master_granted_RAM_s1 : OUT STD_LOGIC;
                    signal CORE_instruction_master_qualified_request_RAM_s1 : OUT STD_LOGIC;
                    signal CORE_instruction_master_read_data_valid_RAM_s1 : OUT STD_LOGIC;
                    signal CORE_instruction_master_requests_RAM_s1 : OUT STD_LOGIC;
                    signal RAM_s1_address : OUT STD_LOGIC_VECTOR (13 DOWNTO 0);
                    signal RAM_s1_byteenable : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal RAM_s1_chipselect : OUT STD_LOGIC;
                    signal RAM_s1_clken : OUT STD_LOGIC;
                    signal RAM_s1_readdata_from_sa : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal RAM_s1_write : OUT STD_LOGIC;
                    signal RAM_s1_writedata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
                    signal d1_RAM_s1_end_xfer : OUT STD_LOGIC;
                    signal registered_CORE_data_master_read_data_valid_RAM_s1 : OUT STD_LOGIC
                 );
end component RAM_s1_arbitrator;

component RAM is 
           port (
                 -- inputs:
                    signal address : IN STD_LOGIC_VECTOR (13 DOWNTO 0);
                    signal byteenable : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                    signal chipselect : IN STD_LOGIC;
                    signal clk : IN STD_LOGIC;
                    signal clken : IN STD_LOGIC;
                    signal write : IN STD_LOGIC;
                    signal writedata : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

                 -- outputs:
                    signal readdata : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
                 );
end component RAM;

component Nios2_reset_clk_0_domain_synch_module is 
           port (
                 -- inputs:
                    signal clk : IN STD_LOGIC;
                    signal data_in : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- outputs:
                    signal data_out : OUT STD_LOGIC
                 );
end component Nios2_reset_clk_0_domain_synch_module;

                signal CORE_data_master_address :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal CORE_data_master_address_to_slave :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal CORE_data_master_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal CORE_data_master_debugaccess :  STD_LOGIC;
                signal CORE_data_master_granted_CORE_jtag_debug_module :  STD_LOGIC;
                signal CORE_data_master_granted_JTAG_DEBUG_avalon_jtag_slave :  STD_LOGIC;
                signal CORE_data_master_granted_PIO_LED_s1 :  STD_LOGIC;
                signal CORE_data_master_granted_RAM_s1 :  STD_LOGIC;
                signal CORE_data_master_irq :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal CORE_data_master_qualified_request_CORE_jtag_debug_module :  STD_LOGIC;
                signal CORE_data_master_qualified_request_JTAG_DEBUG_avalon_jtag_slave :  STD_LOGIC;
                signal CORE_data_master_qualified_request_PIO_LED_s1 :  STD_LOGIC;
                signal CORE_data_master_qualified_request_RAM_s1 :  STD_LOGIC;
                signal CORE_data_master_read :  STD_LOGIC;
                signal CORE_data_master_read_data_valid_CORE_jtag_debug_module :  STD_LOGIC;
                signal CORE_data_master_read_data_valid_JTAG_DEBUG_avalon_jtag_slave :  STD_LOGIC;
                signal CORE_data_master_read_data_valid_PIO_LED_s1 :  STD_LOGIC;
                signal CORE_data_master_read_data_valid_RAM_s1 :  STD_LOGIC;
                signal CORE_data_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal CORE_data_master_requests_CORE_jtag_debug_module :  STD_LOGIC;
                signal CORE_data_master_requests_JTAG_DEBUG_avalon_jtag_slave :  STD_LOGIC;
                signal CORE_data_master_requests_PIO_LED_s1 :  STD_LOGIC;
                signal CORE_data_master_requests_RAM_s1 :  STD_LOGIC;
                signal CORE_data_master_waitrequest :  STD_LOGIC;
                signal CORE_data_master_write :  STD_LOGIC;
                signal CORE_data_master_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal CORE_instruction_master_address :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal CORE_instruction_master_address_to_slave :  STD_LOGIC_VECTOR (17 DOWNTO 0);
                signal CORE_instruction_master_granted_CORE_jtag_debug_module :  STD_LOGIC;
                signal CORE_instruction_master_granted_RAM_s1 :  STD_LOGIC;
                signal CORE_instruction_master_qualified_request_CORE_jtag_debug_module :  STD_LOGIC;
                signal CORE_instruction_master_qualified_request_RAM_s1 :  STD_LOGIC;
                signal CORE_instruction_master_read :  STD_LOGIC;
                signal CORE_instruction_master_read_data_valid_CORE_jtag_debug_module :  STD_LOGIC;
                signal CORE_instruction_master_read_data_valid_RAM_s1 :  STD_LOGIC;
                signal CORE_instruction_master_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal CORE_instruction_master_requests_CORE_jtag_debug_module :  STD_LOGIC;
                signal CORE_instruction_master_requests_RAM_s1 :  STD_LOGIC;
                signal CORE_instruction_master_waitrequest :  STD_LOGIC;
                signal CORE_jtag_debug_module_address :  STD_LOGIC_VECTOR (8 DOWNTO 0);
                signal CORE_jtag_debug_module_begintransfer :  STD_LOGIC;
                signal CORE_jtag_debug_module_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal CORE_jtag_debug_module_chipselect :  STD_LOGIC;
                signal CORE_jtag_debug_module_debugaccess :  STD_LOGIC;
                signal CORE_jtag_debug_module_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal CORE_jtag_debug_module_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal CORE_jtag_debug_module_reset_n :  STD_LOGIC;
                signal CORE_jtag_debug_module_resetrequest :  STD_LOGIC;
                signal CORE_jtag_debug_module_resetrequest_from_sa :  STD_LOGIC;
                signal CORE_jtag_debug_module_write :  STD_LOGIC;
                signal CORE_jtag_debug_module_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal JTAG_DEBUG_avalon_jtag_slave_address :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_chipselect :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_dataavailable :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_dataavailable_from_sa :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_irq :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_irq_from_sa :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_read_n :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal JTAG_DEBUG_avalon_jtag_slave_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal JTAG_DEBUG_avalon_jtag_slave_readyfordata :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_readyfordata_from_sa :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_reset_n :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_waitrequest :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_waitrequest_from_sa :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_write_n :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal PIO_LED_s1_address :  STD_LOGIC_VECTOR (1 DOWNTO 0);
                signal PIO_LED_s1_chipselect :  STD_LOGIC;
                signal PIO_LED_s1_readdata :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal PIO_LED_s1_readdata_from_sa :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal PIO_LED_s1_reset_n :  STD_LOGIC;
                signal PIO_LED_s1_write_n :  STD_LOGIC;
                signal PIO_LED_s1_writedata :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal RAM_s1_address :  STD_LOGIC_VECTOR (13 DOWNTO 0);
                signal RAM_s1_byteenable :  STD_LOGIC_VECTOR (3 DOWNTO 0);
                signal RAM_s1_chipselect :  STD_LOGIC;
                signal RAM_s1_clken :  STD_LOGIC;
                signal RAM_s1_readdata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal RAM_s1_readdata_from_sa :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal RAM_s1_write :  STD_LOGIC;
                signal RAM_s1_writedata :  STD_LOGIC_VECTOR (31 DOWNTO 0);
                signal clk_0_reset_n :  STD_LOGIC;
                signal d1_CORE_jtag_debug_module_end_xfer :  STD_LOGIC;
                signal d1_JTAG_DEBUG_avalon_jtag_slave_end_xfer :  STD_LOGIC;
                signal d1_PIO_LED_s1_end_xfer :  STD_LOGIC;
                signal d1_RAM_s1_end_xfer :  STD_LOGIC;
                signal internal_out_port_from_the_PIO_LED :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal module_input :  STD_LOGIC;
                signal registered_CORE_data_master_read_data_valid_RAM_s1 :  STD_LOGIC;
                signal reset_n_sources :  STD_LOGIC;

begin

  --the_CORE_jtag_debug_module, which is an e_instance
  the_CORE_jtag_debug_module : CORE_jtag_debug_module_arbitrator
    port map(
      CORE_data_master_granted_CORE_jtag_debug_module => CORE_data_master_granted_CORE_jtag_debug_module,
      CORE_data_master_qualified_request_CORE_jtag_debug_module => CORE_data_master_qualified_request_CORE_jtag_debug_module,
      CORE_data_master_read_data_valid_CORE_jtag_debug_module => CORE_data_master_read_data_valid_CORE_jtag_debug_module,
      CORE_data_master_requests_CORE_jtag_debug_module => CORE_data_master_requests_CORE_jtag_debug_module,
      CORE_instruction_master_granted_CORE_jtag_debug_module => CORE_instruction_master_granted_CORE_jtag_debug_module,
      CORE_instruction_master_qualified_request_CORE_jtag_debug_module => CORE_instruction_master_qualified_request_CORE_jtag_debug_module,
      CORE_instruction_master_read_data_valid_CORE_jtag_debug_module => CORE_instruction_master_read_data_valid_CORE_jtag_debug_module,
      CORE_instruction_master_requests_CORE_jtag_debug_module => CORE_instruction_master_requests_CORE_jtag_debug_module,
      CORE_jtag_debug_module_address => CORE_jtag_debug_module_address,
      CORE_jtag_debug_module_begintransfer => CORE_jtag_debug_module_begintransfer,
      CORE_jtag_debug_module_byteenable => CORE_jtag_debug_module_byteenable,
      CORE_jtag_debug_module_chipselect => CORE_jtag_debug_module_chipselect,
      CORE_jtag_debug_module_debugaccess => CORE_jtag_debug_module_debugaccess,
      CORE_jtag_debug_module_readdata_from_sa => CORE_jtag_debug_module_readdata_from_sa,
      CORE_jtag_debug_module_reset_n => CORE_jtag_debug_module_reset_n,
      CORE_jtag_debug_module_resetrequest_from_sa => CORE_jtag_debug_module_resetrequest_from_sa,
      CORE_jtag_debug_module_write => CORE_jtag_debug_module_write,
      CORE_jtag_debug_module_writedata => CORE_jtag_debug_module_writedata,
      d1_CORE_jtag_debug_module_end_xfer => d1_CORE_jtag_debug_module_end_xfer,
      CORE_data_master_address_to_slave => CORE_data_master_address_to_slave,
      CORE_data_master_byteenable => CORE_data_master_byteenable,
      CORE_data_master_debugaccess => CORE_data_master_debugaccess,
      CORE_data_master_read => CORE_data_master_read,
      CORE_data_master_waitrequest => CORE_data_master_waitrequest,
      CORE_data_master_write => CORE_data_master_write,
      CORE_data_master_writedata => CORE_data_master_writedata,
      CORE_instruction_master_address_to_slave => CORE_instruction_master_address_to_slave,
      CORE_instruction_master_read => CORE_instruction_master_read,
      CORE_jtag_debug_module_readdata => CORE_jtag_debug_module_readdata,
      CORE_jtag_debug_module_resetrequest => CORE_jtag_debug_module_resetrequest,
      clk => clk_0,
      reset_n => clk_0_reset_n
    );


  --the_CORE_data_master, which is an e_instance
  the_CORE_data_master : CORE_data_master_arbitrator
    port map(
      CORE_data_master_address_to_slave => CORE_data_master_address_to_slave,
      CORE_data_master_irq => CORE_data_master_irq,
      CORE_data_master_readdata => CORE_data_master_readdata,
      CORE_data_master_waitrequest => CORE_data_master_waitrequest,
      CORE_data_master_address => CORE_data_master_address,
      CORE_data_master_granted_CORE_jtag_debug_module => CORE_data_master_granted_CORE_jtag_debug_module,
      CORE_data_master_granted_JTAG_DEBUG_avalon_jtag_slave => CORE_data_master_granted_JTAG_DEBUG_avalon_jtag_slave,
      CORE_data_master_granted_PIO_LED_s1 => CORE_data_master_granted_PIO_LED_s1,
      CORE_data_master_granted_RAM_s1 => CORE_data_master_granted_RAM_s1,
      CORE_data_master_qualified_request_CORE_jtag_debug_module => CORE_data_master_qualified_request_CORE_jtag_debug_module,
      CORE_data_master_qualified_request_JTAG_DEBUG_avalon_jtag_slave => CORE_data_master_qualified_request_JTAG_DEBUG_avalon_jtag_slave,
      CORE_data_master_qualified_request_PIO_LED_s1 => CORE_data_master_qualified_request_PIO_LED_s1,
      CORE_data_master_qualified_request_RAM_s1 => CORE_data_master_qualified_request_RAM_s1,
      CORE_data_master_read => CORE_data_master_read,
      CORE_data_master_read_data_valid_CORE_jtag_debug_module => CORE_data_master_read_data_valid_CORE_jtag_debug_module,
      CORE_data_master_read_data_valid_JTAG_DEBUG_avalon_jtag_slave => CORE_data_master_read_data_valid_JTAG_DEBUG_avalon_jtag_slave,
      CORE_data_master_read_data_valid_PIO_LED_s1 => CORE_data_master_read_data_valid_PIO_LED_s1,
      CORE_data_master_read_data_valid_RAM_s1 => CORE_data_master_read_data_valid_RAM_s1,
      CORE_data_master_requests_CORE_jtag_debug_module => CORE_data_master_requests_CORE_jtag_debug_module,
      CORE_data_master_requests_JTAG_DEBUG_avalon_jtag_slave => CORE_data_master_requests_JTAG_DEBUG_avalon_jtag_slave,
      CORE_data_master_requests_PIO_LED_s1 => CORE_data_master_requests_PIO_LED_s1,
      CORE_data_master_requests_RAM_s1 => CORE_data_master_requests_RAM_s1,
      CORE_data_master_write => CORE_data_master_write,
      CORE_jtag_debug_module_readdata_from_sa => CORE_jtag_debug_module_readdata_from_sa,
      JTAG_DEBUG_avalon_jtag_slave_irq_from_sa => JTAG_DEBUG_avalon_jtag_slave_irq_from_sa,
      JTAG_DEBUG_avalon_jtag_slave_readdata_from_sa => JTAG_DEBUG_avalon_jtag_slave_readdata_from_sa,
      JTAG_DEBUG_avalon_jtag_slave_waitrequest_from_sa => JTAG_DEBUG_avalon_jtag_slave_waitrequest_from_sa,
      PIO_LED_s1_readdata_from_sa => PIO_LED_s1_readdata_from_sa,
      RAM_s1_readdata_from_sa => RAM_s1_readdata_from_sa,
      clk => clk_0,
      d1_CORE_jtag_debug_module_end_xfer => d1_CORE_jtag_debug_module_end_xfer,
      d1_JTAG_DEBUG_avalon_jtag_slave_end_xfer => d1_JTAG_DEBUG_avalon_jtag_slave_end_xfer,
      d1_PIO_LED_s1_end_xfer => d1_PIO_LED_s1_end_xfer,
      d1_RAM_s1_end_xfer => d1_RAM_s1_end_xfer,
      registered_CORE_data_master_read_data_valid_RAM_s1 => registered_CORE_data_master_read_data_valid_RAM_s1,
      reset_n => clk_0_reset_n
    );


  --the_CORE_instruction_master, which is an e_instance
  the_CORE_instruction_master : CORE_instruction_master_arbitrator
    port map(
      CORE_instruction_master_address_to_slave => CORE_instruction_master_address_to_slave,
      CORE_instruction_master_readdata => CORE_instruction_master_readdata,
      CORE_instruction_master_waitrequest => CORE_instruction_master_waitrequest,
      CORE_instruction_master_address => CORE_instruction_master_address,
      CORE_instruction_master_granted_CORE_jtag_debug_module => CORE_instruction_master_granted_CORE_jtag_debug_module,
      CORE_instruction_master_granted_RAM_s1 => CORE_instruction_master_granted_RAM_s1,
      CORE_instruction_master_qualified_request_CORE_jtag_debug_module => CORE_instruction_master_qualified_request_CORE_jtag_debug_module,
      CORE_instruction_master_qualified_request_RAM_s1 => CORE_instruction_master_qualified_request_RAM_s1,
      CORE_instruction_master_read => CORE_instruction_master_read,
      CORE_instruction_master_read_data_valid_CORE_jtag_debug_module => CORE_instruction_master_read_data_valid_CORE_jtag_debug_module,
      CORE_instruction_master_read_data_valid_RAM_s1 => CORE_instruction_master_read_data_valid_RAM_s1,
      CORE_instruction_master_requests_CORE_jtag_debug_module => CORE_instruction_master_requests_CORE_jtag_debug_module,
      CORE_instruction_master_requests_RAM_s1 => CORE_instruction_master_requests_RAM_s1,
      CORE_jtag_debug_module_readdata_from_sa => CORE_jtag_debug_module_readdata_from_sa,
      RAM_s1_readdata_from_sa => RAM_s1_readdata_from_sa,
      clk => clk_0,
      d1_CORE_jtag_debug_module_end_xfer => d1_CORE_jtag_debug_module_end_xfer,
      d1_RAM_s1_end_xfer => d1_RAM_s1_end_xfer,
      reset_n => clk_0_reset_n
    );


  --the_CORE, which is an e_ptf_instance
  the_CORE : CORE
    port map(
      d_address => CORE_data_master_address,
      d_byteenable => CORE_data_master_byteenable,
      d_read => CORE_data_master_read,
      d_write => CORE_data_master_write,
      d_writedata => CORE_data_master_writedata,
      i_address => CORE_instruction_master_address,
      i_read => CORE_instruction_master_read,
      jtag_debug_module_debugaccess_to_roms => CORE_data_master_debugaccess,
      jtag_debug_module_readdata => CORE_jtag_debug_module_readdata,
      jtag_debug_module_resetrequest => CORE_jtag_debug_module_resetrequest,
      clk => clk_0,
      d_irq => CORE_data_master_irq,
      d_readdata => CORE_data_master_readdata,
      d_waitrequest => CORE_data_master_waitrequest,
      i_readdata => CORE_instruction_master_readdata,
      i_waitrequest => CORE_instruction_master_waitrequest,
      jtag_debug_module_address => CORE_jtag_debug_module_address,
      jtag_debug_module_begintransfer => CORE_jtag_debug_module_begintransfer,
      jtag_debug_module_byteenable => CORE_jtag_debug_module_byteenable,
      jtag_debug_module_debugaccess => CORE_jtag_debug_module_debugaccess,
      jtag_debug_module_select => CORE_jtag_debug_module_chipselect,
      jtag_debug_module_write => CORE_jtag_debug_module_write,
      jtag_debug_module_writedata => CORE_jtag_debug_module_writedata,
      reset_n => CORE_jtag_debug_module_reset_n
    );


  --the_JTAG_DEBUG_avalon_jtag_slave, which is an e_instance
  the_JTAG_DEBUG_avalon_jtag_slave : JTAG_DEBUG_avalon_jtag_slave_arbitrator
    port map(
      CORE_data_master_granted_JTAG_DEBUG_avalon_jtag_slave => CORE_data_master_granted_JTAG_DEBUG_avalon_jtag_slave,
      CORE_data_master_qualified_request_JTAG_DEBUG_avalon_jtag_slave => CORE_data_master_qualified_request_JTAG_DEBUG_avalon_jtag_slave,
      CORE_data_master_read_data_valid_JTAG_DEBUG_avalon_jtag_slave => CORE_data_master_read_data_valid_JTAG_DEBUG_avalon_jtag_slave,
      CORE_data_master_requests_JTAG_DEBUG_avalon_jtag_slave => CORE_data_master_requests_JTAG_DEBUG_avalon_jtag_slave,
      JTAG_DEBUG_avalon_jtag_slave_address => JTAG_DEBUG_avalon_jtag_slave_address,
      JTAG_DEBUG_avalon_jtag_slave_chipselect => JTAG_DEBUG_avalon_jtag_slave_chipselect,
      JTAG_DEBUG_avalon_jtag_slave_dataavailable_from_sa => JTAG_DEBUG_avalon_jtag_slave_dataavailable_from_sa,
      JTAG_DEBUG_avalon_jtag_slave_irq_from_sa => JTAG_DEBUG_avalon_jtag_slave_irq_from_sa,
      JTAG_DEBUG_avalon_jtag_slave_read_n => JTAG_DEBUG_avalon_jtag_slave_read_n,
      JTAG_DEBUG_avalon_jtag_slave_readdata_from_sa => JTAG_DEBUG_avalon_jtag_slave_readdata_from_sa,
      JTAG_DEBUG_avalon_jtag_slave_readyfordata_from_sa => JTAG_DEBUG_avalon_jtag_slave_readyfordata_from_sa,
      JTAG_DEBUG_avalon_jtag_slave_reset_n => JTAG_DEBUG_avalon_jtag_slave_reset_n,
      JTAG_DEBUG_avalon_jtag_slave_waitrequest_from_sa => JTAG_DEBUG_avalon_jtag_slave_waitrequest_from_sa,
      JTAG_DEBUG_avalon_jtag_slave_write_n => JTAG_DEBUG_avalon_jtag_slave_write_n,
      JTAG_DEBUG_avalon_jtag_slave_writedata => JTAG_DEBUG_avalon_jtag_slave_writedata,
      d1_JTAG_DEBUG_avalon_jtag_slave_end_xfer => d1_JTAG_DEBUG_avalon_jtag_slave_end_xfer,
      CORE_data_master_address_to_slave => CORE_data_master_address_to_slave,
      CORE_data_master_read => CORE_data_master_read,
      CORE_data_master_waitrequest => CORE_data_master_waitrequest,
      CORE_data_master_write => CORE_data_master_write,
      CORE_data_master_writedata => CORE_data_master_writedata,
      JTAG_DEBUG_avalon_jtag_slave_dataavailable => JTAG_DEBUG_avalon_jtag_slave_dataavailable,
      JTAG_DEBUG_avalon_jtag_slave_irq => JTAG_DEBUG_avalon_jtag_slave_irq,
      JTAG_DEBUG_avalon_jtag_slave_readdata => JTAG_DEBUG_avalon_jtag_slave_readdata,
      JTAG_DEBUG_avalon_jtag_slave_readyfordata => JTAG_DEBUG_avalon_jtag_slave_readyfordata,
      JTAG_DEBUG_avalon_jtag_slave_waitrequest => JTAG_DEBUG_avalon_jtag_slave_waitrequest,
      clk => clk_0,
      reset_n => clk_0_reset_n
    );


  --the_JTAG_DEBUG, which is an e_ptf_instance
  the_JTAG_DEBUG : JTAG_DEBUG
    port map(
      av_irq => JTAG_DEBUG_avalon_jtag_slave_irq,
      av_readdata => JTAG_DEBUG_avalon_jtag_slave_readdata,
      av_waitrequest => JTAG_DEBUG_avalon_jtag_slave_waitrequest,
      dataavailable => JTAG_DEBUG_avalon_jtag_slave_dataavailable,
      readyfordata => JTAG_DEBUG_avalon_jtag_slave_readyfordata,
      av_address => JTAG_DEBUG_avalon_jtag_slave_address,
      av_chipselect => JTAG_DEBUG_avalon_jtag_slave_chipselect,
      av_read_n => JTAG_DEBUG_avalon_jtag_slave_read_n,
      av_write_n => JTAG_DEBUG_avalon_jtag_slave_write_n,
      av_writedata => JTAG_DEBUG_avalon_jtag_slave_writedata,
      clk => clk_0,
      rst_n => JTAG_DEBUG_avalon_jtag_slave_reset_n
    );


  --the_PIO_LED_s1, which is an e_instance
  the_PIO_LED_s1 : PIO_LED_s1_arbitrator
    port map(
      CORE_data_master_granted_PIO_LED_s1 => CORE_data_master_granted_PIO_LED_s1,
      CORE_data_master_qualified_request_PIO_LED_s1 => CORE_data_master_qualified_request_PIO_LED_s1,
      CORE_data_master_read_data_valid_PIO_LED_s1 => CORE_data_master_read_data_valid_PIO_LED_s1,
      CORE_data_master_requests_PIO_LED_s1 => CORE_data_master_requests_PIO_LED_s1,
      PIO_LED_s1_address => PIO_LED_s1_address,
      PIO_LED_s1_chipselect => PIO_LED_s1_chipselect,
      PIO_LED_s1_readdata_from_sa => PIO_LED_s1_readdata_from_sa,
      PIO_LED_s1_reset_n => PIO_LED_s1_reset_n,
      PIO_LED_s1_write_n => PIO_LED_s1_write_n,
      PIO_LED_s1_writedata => PIO_LED_s1_writedata,
      d1_PIO_LED_s1_end_xfer => d1_PIO_LED_s1_end_xfer,
      CORE_data_master_address_to_slave => CORE_data_master_address_to_slave,
      CORE_data_master_byteenable => CORE_data_master_byteenable,
      CORE_data_master_read => CORE_data_master_read,
      CORE_data_master_waitrequest => CORE_data_master_waitrequest,
      CORE_data_master_write => CORE_data_master_write,
      CORE_data_master_writedata => CORE_data_master_writedata,
      PIO_LED_s1_readdata => PIO_LED_s1_readdata,
      clk => clk_0,
      reset_n => clk_0_reset_n
    );


  --the_PIO_LED, which is an e_ptf_instance
  the_PIO_LED : PIO_LED
    port map(
      out_port => internal_out_port_from_the_PIO_LED,
      readdata => PIO_LED_s1_readdata,
      address => PIO_LED_s1_address,
      chipselect => PIO_LED_s1_chipselect,
      clk => clk_0,
      reset_n => PIO_LED_s1_reset_n,
      write_n => PIO_LED_s1_write_n,
      writedata => PIO_LED_s1_writedata
    );


  --the_RAM_s1, which is an e_instance
  the_RAM_s1 : RAM_s1_arbitrator
    port map(
      CORE_data_master_granted_RAM_s1 => CORE_data_master_granted_RAM_s1,
      CORE_data_master_qualified_request_RAM_s1 => CORE_data_master_qualified_request_RAM_s1,
      CORE_data_master_read_data_valid_RAM_s1 => CORE_data_master_read_data_valid_RAM_s1,
      CORE_data_master_requests_RAM_s1 => CORE_data_master_requests_RAM_s1,
      CORE_instruction_master_granted_RAM_s1 => CORE_instruction_master_granted_RAM_s1,
      CORE_instruction_master_qualified_request_RAM_s1 => CORE_instruction_master_qualified_request_RAM_s1,
      CORE_instruction_master_read_data_valid_RAM_s1 => CORE_instruction_master_read_data_valid_RAM_s1,
      CORE_instruction_master_requests_RAM_s1 => CORE_instruction_master_requests_RAM_s1,
      RAM_s1_address => RAM_s1_address,
      RAM_s1_byteenable => RAM_s1_byteenable,
      RAM_s1_chipselect => RAM_s1_chipselect,
      RAM_s1_clken => RAM_s1_clken,
      RAM_s1_readdata_from_sa => RAM_s1_readdata_from_sa,
      RAM_s1_write => RAM_s1_write,
      RAM_s1_writedata => RAM_s1_writedata,
      d1_RAM_s1_end_xfer => d1_RAM_s1_end_xfer,
      registered_CORE_data_master_read_data_valid_RAM_s1 => registered_CORE_data_master_read_data_valid_RAM_s1,
      CORE_data_master_address_to_slave => CORE_data_master_address_to_slave,
      CORE_data_master_byteenable => CORE_data_master_byteenable,
      CORE_data_master_read => CORE_data_master_read,
      CORE_data_master_waitrequest => CORE_data_master_waitrequest,
      CORE_data_master_write => CORE_data_master_write,
      CORE_data_master_writedata => CORE_data_master_writedata,
      CORE_instruction_master_address_to_slave => CORE_instruction_master_address_to_slave,
      CORE_instruction_master_read => CORE_instruction_master_read,
      RAM_s1_readdata => RAM_s1_readdata,
      clk => clk_0,
      reset_n => clk_0_reset_n
    );


  --the_RAM, which is an e_ptf_instance
  the_RAM : RAM
    port map(
      readdata => RAM_s1_readdata,
      address => RAM_s1_address,
      byteenable => RAM_s1_byteenable,
      chipselect => RAM_s1_chipselect,
      clk => clk_0,
      clken => RAM_s1_clken,
      write => RAM_s1_write,
      writedata => RAM_s1_writedata
    );


  --reset is asserted asynchronously and deasserted synchronously
  Nios2_reset_clk_0_domain_synch : Nios2_reset_clk_0_domain_synch_module
    port map(
      data_out => clk_0_reset_n,
      clk => clk_0,
      data_in => module_input,
      reset_n => reset_n_sources
    );

  module_input <= std_logic'('1');

  --reset sources mux, which is an e_mux
  reset_n_sources <= Vector_To_Std_Logic(NOT (((((std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(NOT reset_n))) OR std_logic_vector'("00000000000000000000000000000000")) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CORE_jtag_debug_module_resetrequest_from_sa)))) OR (std_logic_vector'("0000000000000000000000000000000") & (A_TOSTDLOGICVECTOR(CORE_jtag_debug_module_resetrequest_from_sa))))));
  --vhdl renameroo for output signals
  out_port_from_the_PIO_LED <= internal_out_port_from_the_PIO_LED;

end europa;


--synthesis translate_off

library altera;
use altera.altera_europa_support_lib.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add your libraries here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>

entity test_bench is 
end entity test_bench;


architecture europa of test_bench is
component Nios2 is 
           port (
                 -- 1) global signals:
                    signal clk_0 : IN STD_LOGIC;
                    signal reset_n : IN STD_LOGIC;

                 -- the_PIO_LED
                    signal out_port_from_the_PIO_LED : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
                 );
end component Nios2;

                signal JTAG_DEBUG_avalon_jtag_slave_dataavailable_from_sa :  STD_LOGIC;
                signal JTAG_DEBUG_avalon_jtag_slave_readyfordata_from_sa :  STD_LOGIC;
                signal clk :  STD_LOGIC;
                signal clk_0 :  STD_LOGIC;
                signal out_port_from_the_PIO_LED :  STD_LOGIC_VECTOR (7 DOWNTO 0);
                signal reset_n :  STD_LOGIC;


-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add your component and signal declaration here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>


begin

  --Set us up the Dut
  DUT : Nios2
    port map(
      out_port_from_the_PIO_LED => out_port_from_the_PIO_LED,
      clk_0 => clk_0,
      reset_n => reset_n
    );


  process
  begin
    clk_0 <= '0';
    loop
       wait for 10 ns;
       clk_0 <= not clk_0;
    end loop;
  end process;
  PROCESS
    BEGIN
       reset_n <= '0';
       wait for 200 ns;
       reset_n <= '1'; 
    WAIT;
  END PROCESS;


-- <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
--add additional architecture here
-- AND HERE WILL BE PRESERVED </ALTERA_NOTE>


end europa;



--synthesis translate_on
