library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
entity counter is 
port (
        input: in std_logic_vector(7 downto 0);
        load, incr, clk, rst: in std_logic;
        output: out std_logic_vector(7 downto 0)
        
    );
end;

architecture arch of counter is 
signal current_value, next_value: unsigned(7 downto 0);  
begin
process(clk, rst)
begin
    if rst='1' then
        current_value <=(others=>'0');
    elsif rising_edge(clk)then
        current_value <= next_value;
    end if;
end process;
-- current_value logic
next_value <= current_value +1 when incr = '1' else
unsigned(input) when load = '1' else
current_value;
           
output <= std_logic_vector(current_value);
end;