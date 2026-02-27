library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM44S is
    port (
        CLK      : in  STD_LOGIC;
        WE       : in  STD_LOGIC;
        DATA_IN  : in  STD_LOGIC_VECTOR(3 downto 0);
        ADDRESS  : in  STD_LOGIC_VECTOR(1 downto 0);
        DATA_OUT : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;

architecture rtl of RAM44S is
    type RAM_TYPE is array (0 to 3) of STD_LOGIC_VECTOR(3 downto 0);
    signal RW : RAM_TYPE;
begin
    MEMORY : process (CLK)
    begin
        if rising_edge(CLK) then
            if (WE = '1') then
                RW(TO_INTEGER(UNSIGNED(ADDRESS))) <= DATA_IN;
            else
                DATA_OUT <= RW(TO_INTEGER(UNSIGNED(ADDRESS)));
            end if;
        end if;
    end process;
end architecture;