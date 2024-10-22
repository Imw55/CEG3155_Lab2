LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fourbyonemux IS
	PORT(
		i_value : IN STD_LOGIC_VECTOR(3 downto 0);
		i_s1, i_s2 : IN STD_LOGIC;
		o_value : OUT STD_LOGIC
	);
END fourbyonemux;

ARCHITECTURE rtl of fourbyonemux IS
	SIGNAL int_value, sub_val1, sub_val2, sub_val3, sub_val4 : STD_LOGIC;
BEGIN
	-- Signal Assessment
	sub_val1   <=   i_value(0) and (not i_s1) and (not i_s2);
	sub_val2   <=   i_value(1) and (not i_s1) and i_s2;
	sub_val3   <=   i_value(2) and i_s1 and (not i_s2);
	sub_val4   <=   i_value(3) and i_s1 and i_s2;
	int_value  <=   sub_val1 or sub_val2 or sub_val3 or sub_val4;

	-- Driver
	o_value    <=   int_value;

END rtl;