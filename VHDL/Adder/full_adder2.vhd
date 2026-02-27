library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity full_adder2 is
    port (
        IN1:  in  std_logic;
        IN2:  in  std_logic;
        Cin:  in  std_logic;
        sum:  out std_logic;
        carry:out std_logic
    );
end entity;

architecture rtl of full_adder2 is
    signal carry_1: std_logic;
    signal carry_2: std_logic;
    signal sum_1  : std_logic;

    component half_adder is
        port (
            IN1:  in  std_logic;
            IN2:  in  std_logic;
            sum:  out std_logic;
            carry:out std_logic
        );
    end component;
begin
    HA_0: half_adder port map (
        IN1   => IN1,
        IN2   => IN2,
        sum   => sum_1,
        carry => carry_1
    );

    HA_1: half_adder port map (
        IN1   => sum_1,
        IN2   => Cin,
        sum   => sum,
        carry => carry_2
    );

    carry <= carry_1 or carry_2;
end architecture;