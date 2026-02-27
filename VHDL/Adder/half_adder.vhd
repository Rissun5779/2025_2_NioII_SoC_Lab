library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity half_adder is
    port (
        IN1:  in  std_logic;
        IN2:  in  std_logic;
        sum:  out std_logic;
        carry:out std_logic
    );
end entity;

architecture rtl of half_adder is
begin
    sum   <= IN1 xor IN2;
    carry <= IN1 and IN2;
end architecture;
