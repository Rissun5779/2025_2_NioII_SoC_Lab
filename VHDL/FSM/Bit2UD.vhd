library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Bit2UD is
    port (
        CLK : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        UP  : in  STD_LOGIC;
        CNT : out STD_LOGIC_VECTOR(1 downto 0)
    );
end entity;

architecture rtl of Bit2UD is
    type   STATES is (C0, C1, C2, C3);
    signal current_stage : STATES;
    signal next_stage    : STATES;
begin
    CURRENT_STATES : process (CLK, RST)
    begin
        if (RST = '0') then
            current_stage <= C0;
        elsif rising_edge(CLK) then
            current_stage <= next_stage;
        end if;
    end process;
 
    NEXT_STATES : process (current_stage, UP)
    begin
        case current_stage is
            when C0 =>
                if (UP='1') then
                    next_stage <= C1;
                else
                    next_stage <= C3;
                end if;
            when C1 =>
                if (UP='1') then
                    next_stage <= C2;
                else
                    next_stage <= C0;
                end if;
            when C2 =>
                if (UP='1') then
                    next_stage <= C3;
                else
                    next_stage <= C1;
                end if;
            when C3 =>
                if (UP='1') then
                    next_stage <= C0;
                else
                    next_stage <= C2;
                end if;
            when others => next_stage <= C0;
        end case;
    end process;

    OUTPUT_LOGIC : process (current_stage)
    begin
        case (current_stage) is
            when C0     => CNT <= "00"; 
            when C1     => CNT <= "01"; 
            when C2     => CNT <= "10"; 
            when C3     => CNT <= "11"; 
            when others => CNT <= "00";
        end case;
    end process; 
end architecture;