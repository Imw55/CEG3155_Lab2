LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MUX_2X1_8Bit IS
    PORT(
        i_value0, i_value1 : IN STD_LOGIC_VECTOR(7 downto 0);
        i_SEL : IN STD_LOGIC;
        o_value : OUT STD_LOGIC_VECTOR(7 downto 0)
    );
END MUX_2X1_8Bit;

ARCHITECTURE rtl OF MUX_2X1_8Bit IS
    
    COMPONENT twobyonemux 
        PORT(
            i_value : IN STD_LOGIC_VECTOR(1 downto 0);
            i_SEL : IN STD_LOGIC;
            o_value : OUT STD_LOGIC
        );
    END COMPONENT;
    
BEGIN
    bitseven : twobyonemux
        PORT MAP(
            i_value => (i_value0(7), i_value1(7)), 
            i_SEL => i_SEL,
            o_value => o_value(7)
        );
        
    bitsix : twobyonemux
        PORT MAP(
            i_value => (i_value0(6), i_value1(6)),
            i_SEL => i_SEL,
            o_value => o_value(6)
        );
        
    bitfive : twobyonemux
        PORT MAP(
            i_value => (i_value0(5), i_value1(5)),
            i_SEL => i_SEL,
            o_value => o_value(5)
        );
        
    bitfour : twobyonemux
        PORT MAP(
            i_value => (i_value0(4), i_value1(4)),
            i_SEL => i_SEL,
            o_value => o_value(4)
        );

    bitthree : twobyonemux
        PORT MAP(
            i_value => (i_value0(3), i_value1(3)),
            i_SEL => i_SEL,
            o_value => o_value(3)
        );
        
    bittwo : twobyonemux
        PORT MAP(
            i_value => (i_value0(2), i_value1(2)),
            i_SEL => i_SEL,
            o_value => o_value(2)
        );
        
    bitone : twobyonemux
        PORT MAP(
            i_value => (i_value0(1), i_value1(1)),
            i_SEL => i_SEL,
            o_value => o_value(1)
        );
        
    bitzero : twobyonemux
        PORT MAP(
            i_value => (i_value0(0), i_value1(0)),
            i_SEL => i_SEL,
            o_value => o_value(0)
        );
END rtl;