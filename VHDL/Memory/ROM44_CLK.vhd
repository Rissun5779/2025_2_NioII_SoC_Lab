library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM44_CLK is
    port (
        CLK      : in STD_LOGIC;
        ADDRESS  : in  STD_LOGIC_VECTOR(1 downto 0);
        DATA_OUT : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;

architecture rtl of ROM44_CLK is
    type ROM_TYPE is array (0 to 3) of STD_LOGIC_VECTOR(3 downto 0);
    constant ROM : ROM_TYPE :=  (
        0 => "1110",
        1 => "0010",
        2 => "1111",
        3 => "0100"
    );
begin
    MEMORY : process (CLK)
    begin
        if rising_edge(CLK) then
            DATA_OUT <= ROM(TO_INTEGER(UNSIGNED(ADDRESS)));
        end if;
    end process;
end architecture;