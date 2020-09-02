LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ram IS
	PORT (
		addr_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		write, clk : IN STD_LOGIC;
		output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END;

ARCHITECTURE arch OF ram IS
	TYPE t_data IS ARRAY (15 DOWNTO 0) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL data : t_data := (x"0A", x"0B", x"02", x"0F", x"03", x"0A", x"07", x"09", x"01", x"04", x"07", x"15",
	x"42", x"54", x"45", x"77");

BEGIN
	PROCESS (clk)
	BEGIN
		IF rising_edge (clk) AND write = '1' THEN
			data(to_integer(unsigned(addr_in(3 DOWNTO 0)))) <= data_in;
		END IF;
	END PROCESS;

	output <= data(to_integer(unsigned(addr_in(3 DOWNTO 0))));

END;