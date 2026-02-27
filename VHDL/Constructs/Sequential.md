# Modeling  Sequential Functionality 
## process
- process_name: process(<signaL_name1>, <signaL_name2>, ....)
    --veriable decalarations
    begin
    sequential_signal_assignment_1 
    sequential_signal_assignment_2 
     : 
end process;

- Ex.
    FlipFlop  :  process  (Clock) 
    begin 
        Q <=  D;   
    end  process; 

## Wait  Statements 
- Ex. 
    Proc_Ex1  :  process 
        begin 
            Y1  <=  ’0’; 
            Y2  <=  ’1’; 
            wait; 
    end  process; 
- Ex2.
    Proc_Ex2  :  process 
        begin 
            CLK  <=  ’0’;  wait  for  5  ns; 
            CLK  <=  ’1’;  wait  for  5  ns; 
    end  process; 
- Ex3.
    Proc_Ex3  :  process 
    begin 
        wait  until  (Counter  >  15); -- first  wait  statement 
        RollOver  <=  ’1’;  wait  for  1  ns; -- second  wait  statement 
        RollOver  <=  ’0’; 
    end  process; 
## Sequential Signal Assignment
A <= B

## variable
- variable variable_name : <type> := <initial_value>;

## Conditional Programming Constructs
- Ex.
    if  boolean_condition  then  sequential_statement 
    end  if; 
    if  boolean_condition  then  sequential_statement_1 
    else  sequential_statement_2 
    end  if; 
    if  boolean_condition_1  then  sequential_statement_1 
    elsif  boolean_condition_2  then  sequential_statement_2 
    : 
    : 
    elsif  boolean_condition_n  then  sequential_statement_n 
    end  if; 
    if  boolean_condition_1  then  sequential_statement_1 
    elsif  boolean_condition_2  then  sequential_statement_2 
    : 
    : 
    elsif  boolean_condition_n  then  sequential_statement_n 
    else  sequential_statement_n+1 
    end  if;

| Attribute       | 說明                                                | 回傳型態     |
| --------------- | ------------------------------------------------- | -------- |
| `A’event`       | 當 signal A **值改變** 時為 true，否則 false               | boolean  |
| `A’active`      | 當 signal A **被賦值**（assignment 發生）時為 true，否則 false | boolean  |
| `A’last_event`  | signal A **上一次改變的時間**                             | time     |
| `A’last_active` | signal A **上一次被賦值的時間**                            | time     |
| `A’last_value`  | signal A **上一個值**                                 | 與 A 相同類型 |

| Attribute  | 說明                          | 回傳型態    |
| ---------- | --------------------------- | ------- |
| `B’length` | vector 的長度（例如 8 位元）         | integer |
| `B’left`   | vector 的左邊界（最高位 index，例如 7） | integer |
| `B’right`  | vector 的右邊界（最低位 index，例如 0） | integer |

# Package
## STD_LOGIC_1164
TYPE std_ulogic IS ( 'U',  -- Uninitialized
                         'X',  -- Forcing  Unknown
                         '0',  -- Forcing  0
                         '1',  -- Forcing  1
                         'Z',  -- High Impedance   
                         'W',  -- Weak     Unknown
                         'L',  -- Weak     0       
                         'H',  -- Weak     1       
                         '-'   -- Don't care
                       );

## NUMERIC_STD
- +, -, *, /, mod, rem and abs
- rising_edge()  and  falling_edge()  
- To_integer() unsigned integer 
  To_integer() signed integer 
  To_unsigned() integer,  <size> unsigned  (size-1  downto  0) 
  To_signed() integer,  <size> signed  (size-1  downto  0) 

## TEXTIO  and  STD_LOGIC_TEXTIO 
- file  Fout:  TEXT  open  WRITE_MODE  is  "output_file.txt";
- file  Fin:  TEXT  open  READ_MODE  is  "input_file.txt"; 

- variable  <line_variable_name>  :  line; 

- readline(<file_handle>,  <line_variable_name>); 
- writeline(<file_handle>,  <line_variable_name>); 

- read(<line_variable_name>,  <destination_variable>); 
- write(<line_variable_name>,  <source_variable>); 

## MATH_REAL
- library  IEEE; 
  use  IEEE.math_real.all;

MATH_E real 2.718 Value  of  e 
MATH_1_E real 0.367 Value  of  1/e 
MATH_PI real 3.141 Value  of  pi 
MATH_1_PI real 0.318 Value  of  1/pi 
MATH_LOG_OF_2 real 0.693 Natural  log  of  2 
MATH_LOG_OF_10 real 2.302 Natural  log  of10 
MATH_LOG2_OF_E real 1.442 Log  base  2  of  e 
MATH_LOG10_OF_E real 0.434 Log  base  10  of  e 
MATH_SQRT2 real 1.414 Sqrt  of  2 
MATH_SQRT1_2 real 0.707 Sqrt  of  1/2 
MATH_SQRT_PI real 1.772 Sqrt  of  pi 
MATH_DEG_TO_RAD real 0.017 Conversion  factor  from  degree  to  radian 
MATH_RAD_TO_DEG real 57.295 Conversion  factor  from  radian  to  degree 
