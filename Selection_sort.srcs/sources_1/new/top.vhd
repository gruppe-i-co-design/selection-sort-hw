LIBRARY work;
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY top IS
	PORT (
		clk, rst : IN STD_LOGIC
	);
END;
ARCHITECTURE arch OF top IS
	SIGNAL comp_out : STD_LOGIC;

	SIGNAL min_v_load, min_i_load, index_v_load, c_cnt_load, c_cnt_incr, i_cnt_incr, write, data_mux : STD_LOGIC;
	SIGNAL addr_mux : STD_LOGIC_VECTOR(1 DOWNTO 0);
	---------------------------------
	SIGNAL ram_data_in, ram_addr_in : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL ram_output : STD_LOGIC_VECTOR(7 DOWNTO 0);
	----------------------------
	SIGNAL i_cnt_output : STD_LOGIC_VECTOR(7 DOWNTO 0);
	-------------------------------
	SIGNAL c_cnt_output : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL c_cnt_input : STD_LOGIC_VECTOR(7 DOWNTO 0);
	-------------------------------
	SIGNAL reg_min_v_output : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL reg_min_i_output : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL reg_index_v_output : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

	control : ENTITY work.control PORT MAP(
		clk => clk,
		rst => rst,

		comp_out => comp_out,
		i_cnt_value => i_cnt_output,
		c_cnt_value => c_cnt_output,

		min_v_load => min_v_load,
		min_i_load => min_i_load,
		index_v_load => index_v_load,
		c_cnt_load => c_cnt_load,
		c_cnt_incr => c_cnt_incr,
		i_cnt_incr => i_cnt_incr,
		write => write,
		data_mux => data_mux,
		addr_mux => addr_mux
		);

	ram : ENTITY work.ram PORT MAP(
		clk => clk,
		data_in => ram_data_in,
		addr_in => ram_addr_in,
		output => ram_output,
		write => write
		);

	i_cnt : ENTITY work.counter PORT MAP(
		input => (OTHERS => '0'),
		output => i_cnt_output,
		clk => clk,
		rst => rst,
		load => '0',
		incr => i_cnt_incr
		);

	c_cnt_input <= STD_LOGIC_VECTOR(unsigned(i_cnt_output) + 1);
	c_cnt : ENTITY work.counter PORT MAP(
		input => c_cnt_input,
		output => c_cnt_output,
		clk => clk,
		rst => rst,
		load => c_cnt_load,
		incr => c_cnt_incr
		);
	reg_min_v : ENTITY work.reg PORT MAP(
		clk => clk,
		rst => rst,
		input => ram_output,
		load => min_v_load,
		output => reg_min_v_output
		);
	reg_min_i : ENTITY work.reg PORT MAP(
		clk => clk,
		rst => rst,
		input => ram_addr_in,
		load => min_i_load,
		output => reg_min_i_output
		);
	reg_index_v : ENTITY work.reg PORT MAP(
		clk => clk,
		rst => rst,
		input => ram_output,
		load => index_v_load,
		output => reg_index_v_output

		);
	addr_mux_en : ENTITY work.addr_mux PORT MAP(
		A => c_cnt_output,
		B => i_cnt_output,
		C => reg_min_i_output,
		ctr => addr_mux,
		output => ram_addr_in
		);
	data_mux_en : ENTITY work.data_mux PORT MAP(
		A => reg_index_v_output,
		B => reg_min_v_output,
		output => ram_data_in,
		ctr => data_mux
		);
	comparator : ENTITY work.comparator PORT MAP(
		A => reg_min_v_output,
		B => ram_output,
		output => comp_out
		);
END;