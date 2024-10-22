LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY CLA8Bit IS 
    PORT(
        i_x, i_y : IN STD_LOGIC_VECTOR(7 downto 0);
        i_c : IN STD_LOGIC;
        o_s : OUT STD_LOGIC_VECTOR(7 downto 0);
        o_c : OUT STD_LOGIC
    );
END CLA8Bit;  

ARCHITECTURE rtl OF CLA8Bit IS
    
    COMPONENT FullAdder1Bit
        PORT(
            i_x, i_y, i_c : IN STD_LOGIC;
            o_s, o_c : OUT STD_LOGIC
        );
    END COMPONENT;
    
    SIGNAL int_p, int_g, int_s : STD_LOGIC_VECTOR(7 downto 0); 
    SIGNAL c1, c2, c3, c4, c5, c6, c7 : STD_LOGIC;  

BEGIN
    -- Signal Assessment
    int_p <= i_x or i_y;  -- Propagate signals
    int_g <= i_x and i_y;  -- Generate signals

    -- Carry lookahead logic
    c1 <= int_g(0) or (int_p(0) and i_c);
    c2 <= int_g(1) or (int_p(1) and c1);
    c3 <= int_g(2) or (int_p(2) and c2);
    c4 <= int_g(3) or (int_p(3) and c3);
    c5 <= int_g(4) or (int_p(4) and c4);
    c6 <= int_g(5) or (int_p(5) and c5);
    c7 <= int_g(6) or (int_p(6) and c6);
    o_c <= int_g(7) or (int_p(7) and c7); 

    -- Component Declarations
    bitzero : FullAdder1Bit
        PORT MAP(
            i_x => i_x(0),
            i_y => i_y(0),
            i_c => i_c,
            o_s => int_s(0),
            o_c => open 
        );
        
    bitone : FullAdder1Bit
        PORT MAP(
            i_x => i_x(1),
            i_y => i_y(1),
            i_c => c1,  
            o_s => int_s(1),
            o_c => open 
        );
        
    bittwo : FullAdder1Bit
        PORT MAP(
            i_x => i_x(2),
            i_y => i_y(2),
            i_c => c2,  
            o_s => int_s(2),
            o_c => open  
        );
        
    bitthree : FullAdder1Bit
        PORT MAP(
            i_x => i_x(3),
            i_y => i_y(3),
            i_c => c3,  
            o_s => int_s(3),
            o_c => open  
        );
        
    bitfour : FullAdder1Bit
        PORT MAP(
            i_x => i_x(4),
            i_y => i_y(4),
            i_c => c4,  
            o_s => int_s(4),
            o_c => open  
        );
        
    bitfive : FullAdder1Bit
        PORT MAP(
            i_x => i_x(5),
            i_y => i_y(5),
            i_c => c5,  
            o_s => int_s(5),
            o_c => open  
        );
        
    bitsix : FullAdder1Bit
        PORT MAP(
            i_x => i_x(6),
            i_y => i_y(6),
            i_c => c6,  
            o_s => int_s(6),
            o_c => open  
        );
        
    bitseven : FullAdder1Bit
        PORT MAP(
            i_x => i_x(7),
            i_y => i_y(7),
            i_c => c7, 
            o_s => int_s(7),
            o_c => open  
        );
        
    -- Output Driver
    o_s <= int_s;
    
END rtl;