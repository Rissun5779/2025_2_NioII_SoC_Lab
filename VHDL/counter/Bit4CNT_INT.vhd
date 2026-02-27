library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Bit4CNT_INT is
    port (
        CLK     : in  STD_LOGIC;
        RST     : in  STD_LOGIC;
        OUT_PIN : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;

architecture rtl of Bit4CNT_INT is
    signal Counter : INTEGER range 0 to 15 := 0;
begin
    COUNTER_PROCL : process (CLK, RST)
    begin
        if (RST = '0') then
            Counter <= 0;
        elsif rising_edge(CLK) then
            if (Counter = 15) then
                Counter <= 0;
            else
                Counter <= Counter + 1;
            end if;
        end if;
    end process; 

    OUT_PIN <= STD_LOGIC_VECTOR(TO_UNSIGNED(Counter, 4));
end architecture;