# fonts
- bold : VHDL keyword
- italics: User-defined name
- <> : input, output etc.

## Enumerated Types
- bit: {0, 1}
- boolean: {false, true}
- character: {"Text...."}

## Range Types
- integer : -2,147,483,648 to 2,147,483,647
- real : $-1.7e^{38}$ to $1.7e^{38}$ 

## Defined Enumberated Types
- type {name} is (value1, value2 ....);
- Ex. type  traffic_light  is  (red,  yellow,  green); 

## Array Type
- type {name} is array (<range>) of <element_type>;
- Ex. type  block_8x16  is  array  (0  to  7)  bit_vector(15  downto  0); 
    signal  my_array  :  block_8x16; 

## Subtypes
- subtype  name  is  <type>  range  <min>  to  <max>; 
- Ex. subtype  NATURAL  is  integer  range  0  to  255; 
      subtype  POSTIVE  is  integer  range  1  to  256;

# Model 
- file type: {name}.vhd
    - Package
        - Ex.
        ```VHDL=1
        library IEEE;
        use IEEE.std_logic_1164.all;
        use IEEE.numeric_std.all;
        use IEEE.std_logic_textio.all;
        ```
    - Entuty
        - Ex.
        ```VHDL=1
        entity entity_name is
            port(
                port_name : <mode> <type>;
                port_name : <mode> <type>
            );
        end entity
        ```
    - Archutecture 
        - Ex.
        ```VHDL=1
        architecture  architecture_name  of  <entity  associated  with>  is
        -- user-defined  enumerated  type  declarations (optional)
        -- signal  declarations (optional)
        -- constant  declarations (optional)
        -- component  declarations (optional) 
        begin
        -- behavioral  description  of  the  system  goes  here 
        end  architecture; 
        ```

## Signal Declarations 
- signal name; <type>;
- Ex.
    signal  node1  :  bit; 
    signal  a1,  b1  :  integer; 
    signal  Bus3 :  bit_vector  (15  downto  0); 
    signal  C_int  :  integer  range  0  to  255; 

## Constant Declarations
- constant constant_name: <type> := <value>;
- Ex.
    constant  BUS_WIDTH  :  integer  :=  32; 
    or 
    signal  BUS_A  :  bit_vector  (BUS_WIDTH-1  downto  0); 

## Component  Declarations 
- Ex.
```VHDL=1
    component component_name
        port(
            port_name :<mode> <type>;
            port_name :<mode> <type>
        );
    end component
```

# Operators 
## Assignment Operator 
- Ex. 
```VHDL=1
    F1  <=  A; -- F1  and  A  must  be  the  same  size  and  type 
    F2  <=  ‘0’; -- F2  is  type  bit  in  this  example 
    F3  <=  “0000”; -- F3  is  type  bit_vector(3  downto  0)  in  this  example 
    F4  <=  “hello”; -- F4  is  type  string  in  this  example 
    F5  <=  3.14; -- F5  is  type  real  in  this  example 
    F6  <=  x”1A”; -- F6  is  type  bit_vector(7  downto  0),  x”1A”  is  in  HEX 
```
## Logical Operator
```VHDL=1
   not : Logical negation
   and : Logical AND
   nand: Logical NAND
   or  : Logical OR
   nor : Logical NOR
   xor : Logical XOR
   xnor: Logical XNOR
```
- Ex.
   F1  <=  not  A; 
   F2  <=  B  and  C; 
- Ex.2
    F3  <=  not  D  nand  E; 
    -- D  will  be  complemented  first,  the  result
    -- will  then  be  NAND’d  with  E,  then  the
    -- result  will  be  assigned  to  F3 
    F4  <=  not  (F  or  G); 
    -- the  parentheses  take  precedence  so
    -- F  will  be  OR’d  with  G  first,  then
    -- complemented,  and  then  assigned  to  F4. 
    F5  <=  H  nor  I  nor  J; 
    -- logic  operations  can  have  any  number  of
    -- inputs. 
    F6  <=  K  xor  L  xnor  M; 
    -- XOR  and  XNOR  have  the  same  priority  so  with
    -- no  parentheses  given,  the  logic  operations
    -- will  take  place  on  the  signals  from
    -- left  to  right.  K  will  be  XOR’d  with  L  first,
    -- then  the  result  will  be  XNOR’d  with  M.

## Numerical Operator
- + : Addition
  - : Subtraction 
  * : Mul
  / : div
  mod : Modulus
  rem : Remainder
  abs : Abs
  **  : Exp

## Relational Operator
- =  : Equal
  /= : Not equal
  <  : Less
  <= : Less or equal
  >  : Greater
  >= : Greater or equal

## Shift Operators 
- sll Shift  left  logical 
  srl Shift  right  logical 
  sla Shift  left  arithmetic 
  sra Shift  right  arithmetic 
  rol Rotate  left 
  ror Rotate  right 

## Concatenation Operator
- Ex.
  Bus1  <=  “11”  &  “00”; 
  -- Bus1  must  be  4-bits  and  will  be  assigned
  -- the  value  “1100” 
  Bus2  <=  BusA  &  BusB; -
  - If  BusA  and  BusB  are  4-bits,  then  Bus2
  -- must  be  8-bits. 
  Bus3  <=  ‘0’ &  BusA; 
  -- This  attaches  a  leading  ‘0’ to  BusA.  Bus3
  -- must  be  5-bits 

## Conditional  Signal  Assignments 
- signal_name  <= expression_1  when condition_1  else 
  expression_2  when condition_2  else 
  : 
  expression_n; 
- Example: 
F1  <=  ‘0’ when  A=‘0’ else  ‘1’; 
F2  <=  ‘1’ when  (A=’0’ and  B=’1’)  else  ‘0’; 
F3  <=  A  when  (C  =  D)  else  B; 

- with  input_name  select 
  signal_name  <= expression_1  when condition_1, 
  expression_2  when condition_2, 
   : 
  expression_n  when others; 

- Ex
    with  A  select 
    F1  <=  ‘1’ when  ‘0’, 
    -- F1  will  be  assigned  ‘1’ when  A=’0’ 
    ‘0’ when  ‘1’; 
    -- F1  will  be  assigned  ‘0’ when  A=’1’ 
    AB  <=  A&B; 
    -- concatenate  A  and  B  so  that  they  can  be  used  as  a  vector 
    with  AB  select 
    F2  <=  ‘0’ when  “00”, 
    -- F2  will  be  assigned  ‘0’ when  AB=”00” 
    ‘1’ when  “01”, 
    ‘1’ when  “10”, 
    ‘0’ when  “11”; 
    with  AB  select 
    F3  <=  ‘1’ when  “01”, 
    ‘1’when “10”,
    ‘0’when others;

# Component  Instantiation 
- instance_name  : <component  name>  port map (<port  connections>); 
## Port  Mapping 
- instance_name  : <component  name> port map (port1  =>  signal1,  port2  =>  signal2,  ...); 