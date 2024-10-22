LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY complementor_4Bit IS
    PORT(
        i_value : IN STD_LOGIC_VECTOR(3 downto 0);
        o_value : OUT STD_LOGIC_VECTOR(3 downto 0)
    );
END complementor_4Bit;

ARCHITECTURE rtl OF complementor_4Bit IS
    
    COMPONENT CLA4Bit 
        PORT(
            i_x, i_y : IN STD_LOGIC_VECTOR(3 downto 0);
            i_c : IN STD_LOGIC;
            o_s : OUT STD_LOGIC_VECTOR(3 downto 0);
            o_c : OUT STD_LOGIC
        );
    END COMPONENT;
    
BEGIN
    -- Component Assignment
    Adder : CLA4Bit
        PORT MAP(
            i_x => NOT i_value,
            i_y => "0000",   
            i_c => '1',
            o_c => open,
            o_s => o_value      
        );
        
END rtl;