library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Bit4CNT is
    port (
        CLK     : in  STD_LOGIC;
        RST     : in  STD_LOGIC;
        OUT_PIN : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;

architecture rtl of Bit4CNT is
    signal Counter : UNSIGNED(3 downto 0) := (others => '0');
begin
    COUNTER_PROCL : process (CLK, RST)
    begin
        if (RST = '0') then
            Counter <= (others => '0');
        elsif rising_edge(CLK) then
            Counter <= Counter + 1;
        end if;
    end process; 

    OUT_PIN <= STD_LOGIC_VECTOR(Counter);
end architecture;