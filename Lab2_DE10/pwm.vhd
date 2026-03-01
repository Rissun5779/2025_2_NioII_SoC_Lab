library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity pwm is
  port (
    CLK_50 : in std_logic;
    SW     : in std_logic_vector(7 downto 0);
    LED    : out std_logic
  );
end entity;

architecture rtl of pwm is
  signal B : std_logic_vector(7 downto 0);
begin
  process (CLK_50)
  begin
    if rising_edge(CLK_50) then
      B <= B - 1;
    end if;
  end process;
  LED <= '1' when SW > B else
    '0';
end architecture;