library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.float_pkg.all;
use IEEE.fixed_float_types.all;

entity TB is
end entity;

architecture rtl of TB is
    signal A_TB      : STD_LOGIC_VECTOR(31 downto 0);
    signal B_TB      : STD_LOGIC_VECTOR(31 downto 0);
    signal RESULT_TB : STD_LOGIC_VECTOR(31 downto 0);
    signal Sel_TB    : STD_LOGIC_VECTOR(1 downto 0);

    component FP is
        port (
            A      : in  STD_LOGIC_VECTOR(31 downto 0);
            B      : in  STD_LOGIC_VECTOR(31 downto 0);
            Sel    : in  STD_LOGIC_VECTOR(1 downto 0);
            Result : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
begin
    DUT : FP port map (
        A      => A_TB,
        B      => B_TB,
        Sel    => Sel_TB,
        Result => RESULT_TB
    );

    SIM : process 
    begin
        -- ADD
        Sel_TB <= "00";
        A_TB   <= To_Std_Logic_Vector(to_float(+20.5));
        B_TB   <= To_Std_Logic_Vector(to_float(+35.75));
        wait for 50 ps;

        A_TB   <= To_Std_Logic_Vector(to_float(-35.75));
        B_TB   <= To_Std_Logic_Vector(to_float(+20.5));
        wait for 50 ps;

        -- SUB
        Sel_TB <= "01";
        A_TB   <= To_Std_Logic_Vector(to_float(+35.75));
        B_TB   <= To_Std_Logic_Vector(to_float(+20.5));
        wait for 50 ps;

        -- MUL
        Sel_TB <= "10";
        A_TB   <= To_Std_Logic_Vector(to_float(+12.375));
        B_TB   <= To_Std_Logic_Vector(to_float(-5.5));
        wait for 50 ps;

        -- DIV
        Sel_TB <= "11";
        A_TB   <= To_Std_Logic_Vector(to_float(-12.375));
        B_TB   <= To_Std_Logic_Vector(to_float(+5.5));
        wait for 50 ps;
    end process;
end architecture;