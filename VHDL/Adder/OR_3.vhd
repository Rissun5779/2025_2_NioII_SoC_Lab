library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity OR_3 is
    port (
        IN1:    in bit;
        IN2:    in bit;
        IN3:    in bit;
        OUT_PIN:out bit
    );
end entity;

architecture rtl of OR_3 is
begin
    OUT_PIN <= IN1 or IN2 or IN3;
end architecture;