LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY AdderSubtractor4Bit IS
    PORT(
        i_x, i_y : IN STD_LOGIC_VECTOR(3 downto 0);
        i_SUB : IN STD_LOGIC;
        o_s : OUT STD_LOGIC_VECTOR(3 downto 0);
        o_c : OUT STD_LOGIC
    );
END AdderSubtractor4Bit;

ARCHITECTURE rtl OF AdderSubtractor4Bit IS
    
    SIGNAL subVector, int_s : STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL int_c : STD_LOGIC;
    
    COMPONENT CLA4Bit 
        PORT(
            i_x, i_y : IN STD_LOGIC_VECTOR(3 downto 0);
            i_c : IN STD_LOGIC;
            o_s : OUT STD_LOGIC_VECTOR(3 downto 0);
            o_c : OUT STD_LOGIC
        );
    END COMPONENT;
    
BEGIN
    -- Signal Assessment
    subVector <= (others => i_SUB);
    
    Adder : CLA4Bit
        PORT MAP(
            i_x => i_x,
            i_y => (i_y XOR subVector),  
            i_c => i_SUB,
            o_s => int_s,
            o_c => int_c
        );
    
    -- Output Driver
    o_s <= int_s;
    o_c <= int_c;
    
END rtl;