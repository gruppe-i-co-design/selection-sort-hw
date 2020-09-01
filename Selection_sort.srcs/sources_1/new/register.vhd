library ieee;
use ieee.std_logic_1164.all;


entity reg is 
port 
(   
    clk, rst, load: in std_logic;
    input: in std_logic_vector(7 downto  0);
    output: out std_logic_vector(7 downto 0)
    
    );
end;

architecture arch of reg is 

begin
-- clk process
process(clk, rst)
begin
    if (rst='1') then
        output <=(others=>'0');
    elsif rising_edge(clk) and load='1' then
        output <= input;
    end if;
end process;

end;


