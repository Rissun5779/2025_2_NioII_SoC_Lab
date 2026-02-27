library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity D_FF is
  port (
    clk : in std_logic;
    D   : in std_logic;
    Q   : out std_logic;
    Qn  : out std_logic
  );
end entity;

architecture rtl of D_FF is
begin
  D_FLIPFLOP : process (clk, D)
  begin
    if rising_edge(clk) then
      Q  <= D;
      Qn <= not D;
    end if;
  end process;
end architecture;