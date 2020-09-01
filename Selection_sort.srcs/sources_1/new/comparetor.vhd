library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator is 

port
    (
    A, B : in std_logic_vector(7 downto 0);
    output: out std_logic
    );
    
end;

architecture arch of comparator is 
begin

output <= '1' when A > B else
'0';

end;