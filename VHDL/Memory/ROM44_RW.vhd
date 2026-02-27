library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM44_RW is
    port (
        WE       : in  STD_LOGIC;
        DATA_IN  : in  STD_LOGIC_VECTOR(3 downto 0);
        ADDRESS  : in  STD_LOGIC_VECTOR(1 downto 0);
        DATA_OUT : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;

architecture rtl of ROM44_RW is
    type ROM_TYPE is array (0 to 3) of STD_LOGIC_VECTOR(3 downto 0);
    signal RW : ROM_TYPE;
begin
    MEMORY : process (ADDRESS, WE, DATA_IN)
    begin
        if (WE = '1') then
            RW(TO_INTEGER(UNSIGNED(ADDRESS))) <= DATA_IN;
        else
            DATA_OUT <= RW(TO_INTEGER(UNSIGNED(ADDRESS)));
        end if;
    end process;
end architecture;