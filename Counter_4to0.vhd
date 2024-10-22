LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Counter_4to0 IS 
    PORT(
        i_SET, i_DEC, i_clock : IN STD_LOGIC;
        o_CNT0 : OUT STD_LOGIC;
		  o_CNT : OUT STD_LOGIC_VECTOR(2 downto 0)
    );
END Counter_4to0;

ARCHITECTURE rtl OF Counter_4to0 IS
    
    COMPONENT enARdFF_2
        PORT(
            i_resetBar : IN STD_LOGIC;
            i_d        : IN STD_LOGIC;
            i_enable   : IN STD_LOGIC;
            i_clock    : IN STD_LOGIC;
            o_q, o_qBar: OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL int_value : STD_LOGIC_VECTOR(2 downto 0);
    
BEGIN
    
    -- Determine D logic
    bittwo : enARdFF_2
        PORT MAP(
            i_resetBar => '1',
            i_enable => i_DEC or i_SET,
            i_clock => i_clock,
            i_d => i_SET,
            o_q => int_value(2),
            o_qBar => open  
        );
        
    bitone : enARdFF_2
        PORT MAP(
            i_resetBar => '1',  
            i_enable => i_DEC or i_SET,
            i_clock => i_clock,
            i_d => (not i_SET) and (i_DEC and (int_value(2) or (int_value(1) and int_value(0)))),
            o_q => int_value(1),
            o_qBar => open  
        );
        
    bitzero : enARdFF_2
        PORT MAP(
            i_resetBar => '1', 
            i_enable => i_DEC or i_SET,
            i_clock => i_clock,
            i_d => (not i_SET) and (i_DEC and (int_value(2) or (int_value(1) and (not int_value(0))))),
            o_q => int_value(0),
            o_qBar => open  
        );
    
    -- Signal Assessment
    o_CNT0 <= (not int_value(2)) and (not int_value(1)) and (not int_value(0));
	 o_CNT <= int_value;
    
END rtl;