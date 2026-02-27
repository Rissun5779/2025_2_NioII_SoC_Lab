library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FSM_0 is
    port (
        CLK : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        Din : in  STD_LOGIC;
        ERR : out STD_LOGIC
    );
end entity;

architecture rtl of FSM_0 is
    type   STATES is (START, D0_NOT_1, D0_IS_1, D1_NOT_1, D1_IS_1);
    signal current_state, next_state: STATES;
begin
    CURRENT_STATES: process (CLK, RST)
    begin
        if (RST = '0') then
            current_state <= START;
        elsif rising_edge(CLK) then
            current_state <= next_state;
        end if;
    end process;

    NEXT_STATES: process (current_state, Din)
    begin
        case (current_state) is
            when START => if (Din = '1') then
                next_state <= D0_IS_1;
            else 
                next_state <= D0_NOT_1;
            end if;
            when D0_IS_1 => if (Din = '1') then
                next_state <= D1_IS_1;
            else
                next_state <= D1_NOT_1;
            end if;
            when D0_NOT_1 => next_state <= D1_NOT_1;
            when D1_IS_1 => next_state <= START;
            when D1_NOT_1 => next_state <= START;
            when others => next_state <= START;
        end case;
    end process;

    OUTPUT_LOGIC: process (current_state, Din)
    begin
        case (current_state) is
            when D1_IS_1 => if (Din = '1') then
                ERR <= '1';
            else
                ERR <= '0';
            end if;
            when others => ERR <= '0';
        end case;
    end process;
end architecture;