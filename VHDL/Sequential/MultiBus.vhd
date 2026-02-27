library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MultiBus is
    port (
        CLK       : in  STD_LOGIC;
        RST       : in  STD_LOGIC;
        Data_Bus  : in  STD_LOGIC_VECTOR(7 downto 0);
        A_EN      : in  STD_LOGIC;
        B_EN      : in  STD_LOGIC;
        C_EN      : in  STD_LOGIC;
        A_OUT     : out STD_LOGIC_VECTOR(7 downto 0);
        B_OUT     : out STD_LOGIC_VECTOR(7 downto 0);
        C_OUT     : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;

architecture rtl of MultiBus is
  begin
    A_REG: process (CLK, RST)
      begin
        if (RST = '0') then
            A_OUT <= x"00";
        elsif rising_edge(CLK) then
            if (A_EN = '1') then
                A_OUT <= Data_Bus;
            end if;
        end if;    
    end process;

    B_REG: process (CLK, RST)
      begin
        if (RST = '0') then
            B_OUT <= x"00";
        elsif rising_edge(CLK) then
            if (B_EN = '1') then
                B_OUT <= Data_Bus;
            end if;
        end if;    
    end process;

    C_REG: process (CLK, RST)
      begin
        if (RST = '0') then
            C_OUT <= x"00";
        elsif rising_edge(CLK) then
            if (C_EN = '1') then
                C_OUT <= Data_Bus;
            end if;
        end if;    
    end process;
end architecture;