LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY shiftRegister4bit IS 
    PORT(
        i_resetBar, i_load : IN STD_LOGIC;
        i_clock, i_left, i_right, i_shiftL, i_shiftR : IN STD_LOGIC;
        i_Value : IN STD_LOGIC_VECTOR(3 downto 0);
        o_leftval, o_rightval : OUT STD_LOGIC;
        o_Value : OUT STD_LOGIC_VECTOR(3 downto 0)
    );
END shiftRegister4bit;

ARCHITECTURE rtl OF shiftRegister4bit IS
    
    SIGNAL int_val3, int_val2, int_val1, int_val0 : STD_LOGIC;
    SIGNAL internal_value : STD_LOGIC_VECTOR(3 downto 0);
    
    COMPONENT fourBitRegister
        PORT(
            i_resetBar, i_load : IN STD_LOGIC;
            i_clock : IN STD_LOGIC;
            i_Value : IN STD_LOGIC_VECTOR(3 downto 0);
            o_Value : OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;
    
BEGIN
    -- Signal Assessment
    o_rightval <= i_right AND internal_value(0);
    o_leftval <= i_left AND internal_value(3);
    int_val3 <= (i_load AND i_Value(3)) OR (i_left AND internal_value(2)) OR (i_right AND i_shiftR);
    int_val2 <= (i_load AND i_Value(2)) OR (i_left AND internal_value(1)) OR (i_right AND internal_value(3));
    int_val1 <= (i_load AND i_Value(1)) OR (i_left AND internal_value(0)) OR (i_right AND internal_value(2));
    int_val0 <= (i_load AND i_Value(0)) OR (i_left AND i_shiftL) OR (i_right AND internal_value(1));
    
    -- Component Maps
    REG : fourBitRegister
        PORT MAP(
            i_resetBar => i_resetBar,
            i_load => i_load OR i_right OR i_left,
            i_clock => i_clock,
            i_Value => (int_val3 & int_val2 & int_val1 & int_val0),
				o_value => internal_value
        );
		  
	-- Output Driver
	o_value <= internal_value;
	
END rtl;
