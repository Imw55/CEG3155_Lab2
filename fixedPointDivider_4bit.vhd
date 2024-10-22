LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fixedPointDivider_4bit IS 
    PORT(
        i_A, i_B : IN STD_LOGIC_VECTOR(3 downto 0);
        i_reset, i_clock : IN STD_LOGIC;
        o_result, o_remainder : OUT STD_LOGIC_VECTOR(3 downto 0);
        o_carry, o_overflow, o_END : OUT STD_LOGIC
    );
END fixedPointDivider_4bit;

ARCHITECTURE rtl OF fixedPointDivider_4bit IS

    -- Signal Declaration
    
    SIGNAL int_dval, int_qval, int_aval, int_mux1_0, int_mux2_0, int_mux3_0, int_mux1out, int_mux2out, int_mux3out: STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL S0, S1, S2, S3, S4, S5, S6, S7, S8: STD_LOGIC;
    SIGNAL LDD, LDA, LDQ, LDS, CLRS, SET, SEL, SUB, SHQR, SHQL, SHD, DEC : STD_LOGIC;
    SIGNAL CNT0, int_sval : STD_LOGIC;
    
    -- Component Declaration
    
    COMPONENT shiftRegister4bit
        PORT(
            i_resetBar, i_load : IN STD_LOGIC;
            i_clock, i_left, i_right, i_shiftL, i_shiftR: IN STD_LOGIC;
            i_Value : IN STD_LOGIC_VECTOR(3 downto 0);
            o_leftval, o_rightval : OUT STD_LOGIC;
            o_Value : OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;
    
    COMPONENT MUX_2X1_4Bit 
        PORT(
            i_value0, i_value1 : IN STD_LOGIC_VECTOR(3 downto 0);
            i_SEL : IN STD_LOGIC;
            o_value : OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;
    
    COMPONENT complementor_4Bit
        PORT(
            i_value : IN STD_LOGIC_VECTOR(3 downto 0);
            o_value : OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;
    
    COMPONENT Counter_4to0
        PORT(
            i_SET, i_DEC, i_clock : IN STD_LOGIC;
            o_CNT0 : OUT STD_LOGIC;
				o_CNT : OUT STD_LOGIC_VECTOR(2 downto 0)
        );
    END COMPONENT;
    
    COMPONENT AdderSubtractor4Bit
        PORT(
            i_x, i_y : IN STD_LOGIC_VECTOR(3 downto 0);
            i_SUB : IN STD_LOGIC;
            o_s : OUT STD_LOGIC_VECTOR(3 downto 0);
            o_c : OUT STD_LOGIC
        );
    END COMPONENT;
    
    COMPONENT enARdFF_2
        PORT(
            i_resetBar : IN STD_LOGIC;
            i_d        : IN STD_LOGIC;
            i_enable   : IN STD_LOGIC;
            i_clock    : IN STD_LOGIC;
            o_q, o_qBar: OUT STD_LOGIC
        );
    END COMPONENT;  

BEGIN

    -- Signal Assessment
    
    o_result <= int_qval;
    o_remainder <= int_aval;
    o_carry <= '0';
    o_overflow <= '0';
    o_END <= S8;
    
    -- Control Path
    
    S0FF : enARdFF_2
        PORT MAP(
            i_resetBar => '1',
            i_enable => '1',
            i_clock => i_clock,
            i_d => i_reset,
            o_q => S0,
            o_qBar => open
        );
        
    S1FF : enARdFF_2
        PORT MAP(
            i_resetBar => '1',
            i_enable => '1',
            i_clock => i_clock,
            i_d => S0 and int_dval(3),
            o_q => S1,
            o_qBar => open
        );
    
    S2FF : enARdFF_2
        PORT MAP(
            i_resetBar => '1',
            i_enable => '1',
            i_clock => i_clock,
            i_d => (S0 and int_qval(3) and (not int_dval(3))) or (S1 and int_qval(3)),
            o_q => S2,
            o_qBar => open
        );
        
    S3FF : enARdFF_2
        PORT MAP(
            i_resetBar => '1',
            i_enable => '1',
            i_clock => i_clock,
            i_d => (S0 and (not int_dval(3))and (not int_qval(3))) or (S1 and (not int_qval(3))) or S2 or ((not CNT0) and S6),
            o_q => S3,
            o_qBar => open
        );
        
    S4FF : enARdFF_2
        PORT MAP(
            i_resetBar => '1',
            i_enable => '1',
            i_clock => i_clock,
            i_d => (not int_aval(3)) and S3,
            o_q => S4,
            o_qBar => open
        );
        
    S5FF : enARdFF_2
        PORT MAP(
            i_resetBar => '1',
            i_enable => '1',
            i_clock => i_clock,
            i_d => int_aval(3) and S3,
            o_q => S5,
            o_qBar => open
        );
        
    S6FF : enARdFF_2
        PORT MAP(
            i_resetBar => '1',
            i_enable => '1',
            i_clock => i_clock,
            i_d => S4 or S5,
            o_q => S6,
            o_qBar => open
        );
        
    S7FF : enARdFF_2
        PORT MAP(
            i_resetBar => '1',
            i_enable => '1',
            i_clock => i_clock,
            i_d => CNT0 and int_sval and S6,
            o_q => S7,
            o_qBar => open
        );
        
    S8FF : enARdFF_2
        PORT MAP(
            i_resetBar => '1',
            i_enable => '1',
            i_clock => i_clock,
            i_d => S7 or (S6 and (not int_sval)),
            o_q => S8,
            o_qBar => open
        );
        
    LDD <= S0 or S1;
    LDA <= S0 or S3 or S4;
    LDQ <= S0 or S2 or S7;
    CLRS <= S0;
    SET <= S0;
    SEL <= S0;
    SUB <= S3;
    SHQR <= S5;
    SHQL <= S4;
    SHD <= S6;
    DEC <= S6;

    -- Component Assessment
    
    CNT : Counter_4to0
        PORT MAP(
            i_SET => SET,
            i_DEC => DEC,
            i_clock => i_clock,
            o_CNT0 => CNT0,
				o_CNT => open
        );
        
    MUX1 : MUX_2X1_4Bit
        PORT MAP(
            i_value1 => i_A,
            i_value0 => int_mux1_0,
            i_SEL => SEL,
            o_value => int_mux1out
        );
        
    MUX2 : MUX_2X1_4Bit
        PORT MAP(
            i_value1 => i_B,
            i_value0 => int_mux2_0,
            i_SEL => SEL,
            o_value => int_mux2out
        );
        
    MUX3 : MUX_2X1_4Bit
        PORT MAP(
            i_value1 => "0000",  
            i_value0 => int_mux3_0,
            i_SEL => SEL,
            o_value => int_mux3out
        );
        
    ADDER : AdderSubtractor4Bit
        PORT MAP(
            i_x => int_aval,
            i_y => int_dval,
            i_SUB => SUB,
            o_s => int_mux3_0,
            o_c => open
        );
        
    COMPLEMENTOR1 : complementor_4Bit
        PORT MAP(
            i_value => int_dval,
            o_value => int_mux1_0
        );
        
    COMPLEMENTOR2 : complementor_4Bit
        PORT MAP(
            i_value => int_qval,
            o_value => int_mux2_0
        );
        
    S : enARdFF_2
        PORT MAP(
            i_resetBar => CLRS,
            i_enable => LDS,
            i_d => not int_sval,
            i_clock => i_clock,
            o_q => int_sval,
            o_qBar => open
        );
        
    D : shiftRegister4bit
        PORT MAP(
            i_resetBar => '1',
            i_load => LDD,
            i_clock => i_clock,
				i_value => int_mux1out,
            i_left => '0',
            i_right => SHD,
            i_shiftL => '0',
            i_shiftR => '0',
            o_leftval => open,
            o_rightval => open,
            o_value => int_dval
        );
        
    Q : shiftRegister4bit
        PORT MAP(
            i_resetBar => '1',
            i_load => LDQ,
            i_clock => i_clock,
				i_value => int_mux2out,
            i_left => SHQL,
            i_right => SHQR,
            i_shiftL => '0',
            i_shiftR => '1',
            o_leftval => open,
            o_rightval => open,
            o_value => int_qval
        );
        
    A : shiftRegister4bit
        PORT MAP(
            i_resetBar => '1',
            i_load => LDA,
            i_clock => i_clock,
				i_value => int_mux3out,
            i_left => '0',
            i_right => '0',
            i_shiftL => '0',
            i_shiftR => '0',
            o_leftval => open,
            o_rightval => open,
            o_value => int_aval
        );
        
END rtl;