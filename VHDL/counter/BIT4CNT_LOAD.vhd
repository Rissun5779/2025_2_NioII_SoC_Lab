library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Bit4CNT_LOAD is
    port (
        CLK     : in  STD_LOGIC;
        RST     : in  STD_LOGIC;
        EN      : in  STD_LOGIC;
        LOAD    : in  STD_LOGIC;
        CNT_IN  : in  STD_LOGIC_VECTOR(3 downto 0);
        OUT_PIN : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;

architecture rtl of Bit4CNT_LOAD is
    signal Counter : INTEGER range 0 to 15 := 0;
begin
    COUNTER_PROCL : process (CLK, RST)
    begin
        if (RST = '0') then
            Counter <= 0;
        elsif rising_edge(CLK) then
            if (LOAD = '1') then
                Counter <= TO_INTEGER(UNSIGNED(CNT_IN));
            else
                if (EN = '1') then
                    if (Counter = 15) then
                        Counter <= 0;
                    else
                        Counter <= Counter + 1;
                    end if;
                end if;
            end if;
        end if;
    end process; 

    OUT_PIN <= STD_LOGIC_VECTOR(TO_UNSIGNED(Counter, 4));
end architecture;