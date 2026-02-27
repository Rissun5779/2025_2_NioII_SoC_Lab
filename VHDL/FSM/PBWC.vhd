library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PBWC is
    port (
        CLK      : in  STD_LOGIC;
        RST      : in  STD_LOGIC;
        PRESS    : in  STD_LOGIC;
        OPEN_CW  : out STD_LOGIC;
        CLOSE_CW : out STD_LOGIC
    );
end entity;

architecture rtl of PBWC is
    type   STATES is (W_CLOSED, W_OPEN);
    signal current_state: STATES;
    signal next_state   : STATES;
begin
    CURRENT_STATES: process (CLK, RST)
    begin
        if (RST = '0') then
            current_state <= W_CLOSED;
        elsif rising_edge(CLK) then
            current_state <= next_state;
        end if;
    end process;

    NEXT_STATES: process (current_state, PRESS)
    begin
        case (current_state) is
            when W_CLOSED => if (PRESS='1') then
                next_state <= W_OPEN;
            else
                next_state <= W_CLOSED;
            end if;
            when W_OPEN => if (PRESS='1') then
                next_state <= W_CLOSED;
            else
                next_state <= W_OPEN;
            end if;
            when  others =>  next_state  <=  w_closed; 
        end case;
    end process;

    OUTPUT_LOGIC: process (current_state, PRESS)
    begin
        case (current_state) is
            when W_CLOSED => if (PRESS='1') then
                OPEN_CW  <= '1';
                CLOSE_CW <= '0';
            else
                OPEN_CW  <= '0';
                CLOSE_CW <= '0';
            end if;
            when W_OPEN => if (PRESS='1') then
                OPEN_CW  <= '0';
                CLOSE_CW <= '1';
            else
                OPEN_CW  <= '0';
                CLOSE_CW <= '0';
            end if;
            when others =>
                OPEN_CW  <= '0';
                CLOSE_CW <= '0';
        end case;
    end process;
end architecture;