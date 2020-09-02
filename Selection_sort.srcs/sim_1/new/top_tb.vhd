LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
LIBRARY work;
ENTITY top_tb IS
END top_tb;
ARCHITECTURE tb OF top_tb IS
	SIGNAL clk, rst : STD_LOGIC;
	CONSTANT clk_period : TIME := 500 ns;
BEGIN
	uut : ENTITY work.top
		PORT MAP(clk => clk, rst => rst);
	clk_process : PROCESS
	BEGIN
		clk <= '0';
		WAIT FOR clk_period/2;
		clk <= '1';
		WAIT FOR clk_period/2;
	END PROCESS;
	-- Stimuli process 
	stim_proc : PROCESS
	BEGIN
		rst <= '1';
		WAIT FOR clk_period * 2;
		rst <= '0';
		WAIT FOR clk_period * 1000;
	END PROCESS;
END tb;