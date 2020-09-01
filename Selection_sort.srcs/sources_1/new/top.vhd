library work;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is 
port (
    clk, rst : in std_logic
    );
end;
architecture arch of top is 
signal  comp_out: std_logic;

signal min_v_load, min_i_load, index_v_load, c_cnt_load, c_cnt_incr, i_cnt_incr, write, data_mux:  std_logic;
signal addr_mux: std_logic_vector(1 downto 0);
---------------------------------
signal ram_data_in,  ram_addr_in: std_logic_vector(7 downto 0);
signal ram_output:  std_logic_vector(7 downto 0);
----------------------------
signal i_cnt_output:  std_logic_vector(7 downto 0);
-------------------------------
signal c_cnt_output:  std_logic_vector(7 downto 0);
-------------------------------
signal     reg_min_v_output: std_logic_vector(7 downto 0);
signal     reg_min_i_output: std_logic_vector(7 downto 0);
signal     reg_index_v_output: std_logic_vector(7 downto 0);
signal  a: std_logic_vector(7 downto 0);
begin
a <= std_logic_vector(unsigned(i_cnt_output) +1);

control: entity work.control port map(
    clk => clk, rst => rst, 
    comp_out => comp_out,
    i_cnt_value=>i_cnt_output, c_cnt_value=>c_cnt_output, 
    min_v_load => min_v_load,  min_i_load=>min_i_load, index_v_load=>index_v_load,
     c_cnt_load=>c_cnt_load, c_cnt_incr=>c_cnt_incr, i_cnt_incr=>i_cnt_incr, write=> write, data_mux => data_mux, addr_mux=>addr_mux
    );

ram: entity work.ram port map(
      clk => clk, data_in =>ram_data_in, addr_in => ram_addr_in, output => ram_output, write => write
      );
      
i_cnt: entity work.counter port map(
input =>(others =>'0'),  output =>i_cnt_output, clk => clk, rst => rst, load => '0', incr => i_cnt_incr
);

c_cnt: entity work.counter port map(
input =>a,  output =>c_cnt_output, clk => clk, rst => rst, load => c_cnt_load, incr => c_cnt_incr
);
reg_min_v: entity work.reg port map(
clk => clk, rst => rst, input => ram_output, load => min_v_load, output => reg_min_v_output
);
reg_min_i: entity work.reg port map(
clk => clk, rst => rst, input => ram_addr_in, load => min_i_load, output => reg_min_i_output
);
reg_index_v: entity work.reg port map(
    clk => clk, rst => rst, input => ram_output, load => index_v_load, output => reg_index_v_output

);
addr_mux_en: entity work.addr_mux port map(
        A => c_cnt_output, B => i_cnt_output, C => reg_min_i_output, ctr => addr_mux, output => ram_addr_in
        );
data_mux_en: entity work.data_mux port map(
    A => reg_index_v_output, B => reg_min_v_output, output => ram_data_in, ctr => data_mux
    );
 comparator: entity work.comparator port map(
    A => reg_min_v_output, B => ram_output, output => comp_out
 );
end;
