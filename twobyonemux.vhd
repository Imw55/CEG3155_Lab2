LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY twobyonemux IS
	PORT(
		i_value : IN STD_LOGIC_VECTOR(1 downto 0);
		i_SEL : IN STD_LOGIC;
		o_value : OUT STD_LOGIC
	);
END twobyonemux;

ARCHITECTURE rtl of twobyonemux IS
	SIGNAL int_value : STD_LOGIC;

BEGIN
	-- Signal Assessment
	int_value <= (i_value(0) and (not i_SEL)) or (i_value(1) and i_SEL);
	
	-- Output Driver
	o_value <= int_value;
END rtl;