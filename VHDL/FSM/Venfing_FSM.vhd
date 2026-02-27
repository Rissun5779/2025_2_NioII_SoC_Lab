library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Venfing_FSM is
    port (
        CLK      : in  STD_LOGIC;
        RST      : in  STD_LOGIC;
        D_IN     : in  STD_LOGIC;
        Q_IN     : in  STD_LOGIC;
        DISPENSE : out STD_LOGIC;
        CHANGE   : out STD_LOGIC
    );
end entity;

architecture rtl of Venfing_FSM is
    type   STATES is (SWAIT, S25, S50);
    signal current_stage, next_stage : STATES;
begin
    CURRENT_STATES: process (CLK, RST)
    begin
        if (RST = '0') then
            current_stage <= SWAIT;
        elsif rising_edge(CLK) then
            current_stage <= next_stage;
        end if;
    end process;

    NEXT_STATES: process (current_stage, D_IN, Q_IN)
    begin
        case current_stage is
            when SWAIT => 
                if (Q_IN = '1') then
                    next_stage <= S25;
                else
                    next_stage <= SWAIT;
                end if;
            when S25 =>
                if (Q_IN='1') then
                    next_stage <= S50;
                else
                    next_stage <= S25;
                end if;
            when S50 =>
                if (Q_IN='1') then
                    next_stage <= SWAIT;
                else
                    next_stage <= S50;
                end if;
            when others => next_stage <= SWAIT;
        end case;
    end process;

    OUTPUT_LOGIC: process (current_stage, D_IN, Q_IN)
    begin
        case (current_stage) is
            when SWAIT =>
                if (D_IN = '1') then
                    DISPENSE <= '1';
                    CHANGE   <= '1';
                else
                    DISPENSE <= '0';
                    CHANGE   <= '0';
                end if;
            when S25 => 
                DISPENSE <= '0';
                CHANGE   <= '0';
            when S50 =>
                if (Q_IN = '1') then
                    DISPENSE <= '1';
                    CHANGE   <= '0';
                else
                    DISPENSE <= '0';
                    CHANGE   <= '0';
                end if;
            when others =>
                DISPENSE <= '0';
                CHANGE   <= '0';
        end case;
    end process;
end architecture;