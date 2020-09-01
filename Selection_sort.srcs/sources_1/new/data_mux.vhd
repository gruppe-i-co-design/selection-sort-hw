library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity data_mux is
  Port (
        A, B: in std_logic_vector (7 downto 0);
        ctr: in std_logic;
        output : out std_logic_vector(7 downto 0)
     );
end;

architecture arch of data_mux is

begin

output <= A when ctr = '0' else
    B;
    
end;