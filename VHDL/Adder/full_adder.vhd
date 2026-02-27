library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity full_adder is
    port (
        IN1:  in  std_logic;
        IN2:  in  std_logic;
        Cin:  in  std_logic;
        sum:  out std_logic;
        carry:out std_logic
    );
end entity;

architecture rtl of full_adder is
begin
    sum   <= IN1 xor IN2 xor Cin;
    carry <= (IN1 and IN2) or ((IN1 or IN2) and Cin);
end architecture;
