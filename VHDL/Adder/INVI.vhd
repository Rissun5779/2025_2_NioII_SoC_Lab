library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity INVI is
    port (
        IN_PIN : in  bit;
        OUT_PIN: out bit
    );
end entity;

architecture rtl of INVI is
begin
    OUT_PIN <= IN_PIN;
end architecture;