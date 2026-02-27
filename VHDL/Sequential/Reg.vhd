library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Reg is
    port (
        CLK     : in  STD_LOGIC;
        RST     : in  STD_LOGIC;
        REG_IN  : in  STD_LOGIC_VECTOR(7 downto 0);
        EN      : in  STD_LOGIC;
        REG_OUT : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;

architecture rtl of Reg is
begin
    REG_PROC : process (CLK, RST)
    begin
        if (RST = '0') then
            REG_OUT <= x"00";
        elsif rising_edge(CLK) then
            if (EN = '1') then
                REG_OUT <= REG_IN;
            end if;
        end if;
    end process;
end architecture;