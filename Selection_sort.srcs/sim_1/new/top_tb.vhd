library ieee;
use ieee.std_logic_1164.all;
library work;
entity top_tb is
end top_tb;
architecture tb of top_tb is
    signal clk, rst : std_logic;
    constant clk_period : time := 500 ns;
begin
	uut : entity work.top
    port map (clk => clk, rst => rst);
clk_process: process 
   begin
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      wait for clk_period/2;
   end process;
-- Stimuli process 
   stim_proc: process
      begin
         rst <= '1';      
         wait for clk_period*2;
         rst <= '0';      
         wait for clk_period*1000;
      end process ;
end tb;