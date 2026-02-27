library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.numeric_std.all;

entity System is
    port (
        A: in  bit;
        B: in  bit;
        C: in  bit;
        F: out bit
    );
end entity;

architecture rtl of System is
    signal An : bit;
    signal Bn : bit;
    signal Cn : bit;
    signal A_0: bit;
    signal A_1: bit;
    signal A_2: bit;

    component INVI is
        port (
            IN_PIN : in  bit;
            OUT_PIN: out bit
        );
    end component;

    component AND_3 is
        port (
            IN1:    in bit;
            IN2:    in bit;
            IN3:    in bit;
            OUT_PIN:out bit
        );
    end component;

    component OR_3 is
        port (
            IN1:    in bit;
            IN2:    in bit;
            IN3:    in bit;
            OUT_PIN:out bit
        );
    end component;
begin
    INVI_0: INVI port map (
        IN_PIN =>A,
        OUT_PIN=>An
    );
    INVI_1: INVI port map (
        IN_PIN =>B,
        OUT_PIN=>Bn
    );
    INVI_2: INVI port map (
        IN_PIN =>C,
        OUT_PIN=>Cn
    );

    AND_0: AND_3 port map (
        IN1     => An,
        IN2     => Bn,
        IN3     => Cn,
        OUT_PIN => A_0 
    );
    AND_1: AND_3 port map (
        IN1     => An,
        IN2     => B,
        IN3     => Cn,
        OUT_PIN => A_1
    );
    AND_2: AND_3 port map (
        IN1     => A,
        IN2     => B,
        IN3     => Cn,
        OUT_PIN => A_2 
    );

    OR_0: OR_3 port map (
        IN1     => A_0,
        IN2     => A_1,
        IN3     => A_2,
        OUT_PIN => F
    );
end architecture;
