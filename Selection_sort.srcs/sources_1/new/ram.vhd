library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity ram is
port(
    addr_in: in std_logic_vector(7 downto 0);
    data_in: in std_logic_vector(7 downto 0);
    write, clk: in std_logic;
    output: out std_logic_vector(7 downto 0)
    );
end;

architecture arch of ram is 
type t_data is  array (15 downto 0) of std_logic_vector(7 downto 0);
signal data: t_data := (x"0A", x"0B",x"02",x"0F",x"03",x"0A",x"07",x"09",x"01",x"04",x"07",x"15",
x"42",x"54",x"45",x"77");

begin
process(clk)
begin
    if rising_edge (clk) and write ='1' then
        data(to_integer(unsigned(addr_in(3 downto 0)))) <= data_in;
     end if;
end process;
        
output <= data(to_integer(unsigned(addr_in(3 downto 0))));

end;