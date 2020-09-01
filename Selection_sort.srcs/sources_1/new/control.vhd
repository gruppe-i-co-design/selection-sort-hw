library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control is
port(
    clk, rst: in std_logic;
    comp_out: in std_logic;
    i_cnt_value, c_cnt_value: in std_logic_vector(7 downto 0);
    min_v_load, min_i_load, index_v_load, c_cnt_load, c_cnt_incr, i_cnt_incr, write, data_mux: out std_logic;
    addr_mux: out std_logic_vector(1 downto 0)
    );
end;

architecture arch of control is
type state is  (S0, S1, S2, S3, S4, S5);
signal current_state, next_state: state;

begin
-- clk process
process(rst, clk)
begin
    if rst ='1' then
        current_state <= S0;
    elsif rising_edge(clk) then
        current_state <= next_state;
     end if;
end process;

-- next-state logic
process (i_cnt_value, c_cnt_value,comp_out,current_state )
    begin
	   next_state <= current_state; -- stay in current state by default
	        addr_mux     <= "00";
			min_v_load   <= '0';
			min_i_load   <= '0';
			i_cnt_incr   <= '0';
			c_cnt_incr   <= '0';
			index_v_load <= '0';
			c_cnt_load   <= '0';
			data_mux     <= '0';
			write        <= '0';
	case current_state is
	
		when S0 =>
			addr_mux <= "01";
			min_v_load <= '1';
			min_i_load <= '1';
			index_v_load <= '1';
			c_cnt_load <= '1';
			next_state <= S1;
			
		when S1 =>
		    c_cnt_incr <= '1';    
			if i_cnt_value >= x"10" then next_state <= S5;
		    elsif c_cnt_value >= x"10" then next_state <= S2;
		    elsif comp_out ='1' then 
		      min_v_load   <= '1';
		      min_i_load <= '1';	    
			end if;
		when S2 => 
		    
		    addr_mux <= "10";
		    write    <= '1';
		    next_state <= S3;
		when S3 => 
		    addr_mux <= "01";
		    data_mux <= '1';
		    write <= '1';
		    next_state <= S4;
		when S4 =>
		    i_cnt_incr <= '1';
		    next_state <= S0;
		    
		when S5 => 
		  
		
	end case;
end process;
end;
