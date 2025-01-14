LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fourBitRegister IS
	PORT(
		i_resetBar, i_load : IN STD_LOGIC;
		i_clock : IN	STD_LOGIC;
		i_Value : IN	STD_LOGIC_VECTOR(3 downto 0);
		o_Value : OUT	STD_LOGIC_VECTOR(3 downto 0)
	);
END fourBitRegister;

ARCHITECTURE rtl OF fourBitRegister IS
	SIGNAL int_Value : STD_LOGIC_VECTOR(3 downto 0);

	COMPONENT enARdFF_2
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC
		);
	END COMPONENT;

BEGIN
					 
	bitthree: enARdFF_2
		PORT MAP (i_resetBar => i_resetBar,
				  i_d => i_Value(3), 
				  i_enable => i_load,
				  i_clock => i_clock,
				  o_q => int_Value(3),
				  o_qBar => open);
					 
	bittwo: enARdFF_2
		PORT MAP (i_resetBar => i_resetBar,
				  i_d => i_Value(2), 
				  i_enable => i_load,
				  i_clock => i_clock,
				  o_q => int_Value(2),
				  o_qBar => open);
					 
	bitone: enARdFF_2
		PORT MAP (i_resetBar => i_resetBar,
				  i_d => i_Value(1), 
				  i_enable => i_load,
				  i_clock => i_clock,
				  o_q => int_Value(1),
				  o_qBar => open);
					 
	bitzero: enARdFF_2
		PORT MAP (i_resetBar => i_resetBar,
				  i_d => i_Value(0), 
				  i_enable => i_load,
				  i_clock => i_clock,
				  o_q => int_Value(0),
				  o_qBar => open);

		-- Output Driver
		o_Value		<= int_Value;

END rtl;