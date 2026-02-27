library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.float_pkg.all;
use IEEE.fixed_float_types.all;

entity FP is
    port (
        A      : in  STD_LOGIC_VECTOR(31 downto 0);
        B      : in  STD_LOGIC_VECTOR(31 downto 0);
        Sel    : in  STD_LOGIC_VECTOR(1 downto 0);
        Result : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity;

architecture rtl of FP is
begin
    FP_PROC : process (A, B, Sel)
        variable A_float      : float32;
        variable B_float      : float32;
        variable Result_float : float32;
    begin
        A_float := to_float(A);
        B_float := to_float(B);

        if (Sel = "00") then
            Result_float := A_float + B_float;
        elsif (Sel = "01") then
            Result_float := A_float - B_float;
        elsif (Sel = "10") then
            Result_float := A_float * B_float;
        elsif (Sel = "11") then
            Result_float := A_float / B_float;
        else
            Result_float := x"FFFFFFFF";
        end if;

        Result <= To_Std_Logic_Vector(Result_float);
    end process;
end architecture;