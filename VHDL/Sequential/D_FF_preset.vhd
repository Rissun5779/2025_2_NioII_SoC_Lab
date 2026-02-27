library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity D_FF_preset is
  port (
    clk : in  std_logic;
    rst : in  std_logic;
    pre : in  std_logic;
    D   : in  std_logic;
    Q   : out std_logic;
    Qn  : out std_logic
  );
end entity;

architecture rtl of D_FF_preset is
begin
  D_FLIPFLOP : process (clk, rst, pre)
  begin
    if (rst = '0') then
        Q  <= '0';
        Qn <= '1';
    elsif (pre = '0') then
        Q  <= '1';
        Qn <= '0';
    elsif rising_edge(clk) then
        Q  <= D;
        Qn <= not D;
    end if;
  end process;
end architecture;