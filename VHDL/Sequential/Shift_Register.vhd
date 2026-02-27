library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Shift_Register is
    port (
        CLK   : in  STD_LOGIC;
        RST   : in  STD_LOGIC;
        DIN   : in  STD_LOGIC_VECTOR(7 downto 0);
        Dout0 : out STD_LOGIC_VECTOR(7 downto 0);
        Dout1 : out STD_LOGIC_VECTOR(7 downto 0);
        Dout2 : out STD_LOGIC_VECTOR(7 downto 0);
        Dout3 : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;

architecture rtl of Shift_Register is
    signal D0 : STD_LOGIC_VECTOR(7 downto 0);
    signal D1 : STD_LOGIC_VECTOR(7 downto 0);
    signal D2 : STD_LOGIC_VECTOR(7 downto 0);
    signal D3 : STD_LOGIC_VECTOR(7 downto 0);
begin
    SHIFT: process (CLK, RST)
    begin
        if (RST = '0') then
            D0 <= x"00";
            D1 <= x"00";
            D2 <= x"00";
            D3 <= x"00";
        elsif rising_edge(CLK) then
            D0 <= DIN;
            D1 <= D0;
            D2 <= D1;
            D3 <= D2;
        end if;
    end process;

    Dout0 <= D0;
    Dout1 <= D1;
    Dout2 <= D2;
    Dout3 <= D3;
end architecture;