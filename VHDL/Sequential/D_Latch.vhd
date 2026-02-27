library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity D_Latch is
    port (
        clk : in  std_logic;
        D   : in  std_logic;
        Q   : out std_logic;
        Qn  : out std_logic
    );
end entity;

architecture rtl of D_Latch is
begin
    D_LATCH : process (clk, D)
        begin
            if (clk='1') then
                Q  <= D;
                Qn <= not D; 
            end if;
    end process;
end architecture;