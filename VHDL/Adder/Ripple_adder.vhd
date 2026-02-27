library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Ripple_adder is
    port (
        IN1:   in  STD_LOGIC_VECTOR(3 downto 0);
        IN2:   in  STD_LOGIC_VECTOR(3 downto 0);
        Cin:   in  std_logic;
        Sum:   out STD_LOGIC_VECTOR(3 downto 0);
        Carry: out std_logic
    );
end entity;

architecture rtl of Ripple_adder is
    signal Carry1: std_logic;
    signal Carry2: std_logic;
    signal Carry3: std_logic;

    component full_adder2 is
        port (
            IN1:  in  std_logic;
            IN2:  in  std_logic;
            Cin:  in  std_logic;
            sum:  out std_logic;
            carry:out std_logic
        );
    end component;
begin
    FA0: full_adder2 port map (
        IN1=> IN1(0),
        IN2=> IN2(0),
        Cin=> Cin,
        sum=> Sum(0),
        carry=>Carry1
    );
    FA1: full_adder2 port map (
        IN1=> IN1(1),
        IN2=> IN2(1),
        Cin=> Carry1,
        sum=> Sum(1),
        carry=>Carry2
    );
    FA2: full_adder2 port map (
        IN1=> IN1(2),
        IN2=> IN2(2),
        Cin=> Carry2,
        sum=> Sum(2),
        carry=>Carry3
    );
    FA3: full_adder2 port map (
        IN1=> IN1(3),
        IN2=> IN2(3),
        Cin=> Carry3,
        sum=> Sum(3),
        carry=>Carry
    );
end architecture;