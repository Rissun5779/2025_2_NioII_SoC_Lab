# Memory
- type name is array (<range>) of <element_type>
- Ex.
    type ROM_type is array (0 to 3) of std_logic_vector(3 downto 0);

- Ex.
    constant ROM : ROM_type := (0=> "1110", 
                                1=> "0010",
                                2=> "1111",
                                3=> "0100")

- Ex.
    data_out <= ROM(to_integer(unsigned(address)));

## Read/Write Memory
- Ex.
    type RW_type is array (0 to 3) std_logic_vector(3 downto 0);
    signal RW : RW_type;

- Ex.
    MEMORY : process(address, WE, data_in)
    begin
        if (WE='1') then
            RW(to_integer(unsigned(address))) <= data_in;
        else
            data_out <= RW(to_integer(unsigned(address)));
        end if;
    end process