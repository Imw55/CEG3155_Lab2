LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FullAdder1Bit IS 
    PORT(
        i_x, i_y, i_c : IN STD_LOGIC;
        o_s, o_c : OUT STD_LOGIC
    );
END FullAdder1Bit;

ARCHITECTURE rtl of FullAdder1Bit IS
    SIGNAL int_c, int_s : STD_LOGIC;
    SIGNAL xyXOR : STD_LOGIC;
BEGIN
    -- Signal Assessment
    xyXOR <= i_x XOR i_y;
    int_s <= i_c XOR xyXOR;
    int_c <= (i_c AND xyXOR) OR (i_x AND i_y);
    
    -- Output Driver
    o_s <= int_s;
    o_c <= int_c;
END rtl;