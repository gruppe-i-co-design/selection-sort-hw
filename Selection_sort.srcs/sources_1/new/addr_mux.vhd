----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/01/2020 01:37:22 PM
-- Design Name: 
-- Module Name: addr_mux - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity addr_mux is
  Port (
        A, B, C: in std_logic_vector (7 downto 0);
        ctr: in std_logic_vector(1 downto 0);
        output : out std_logic_vector(7 downto 0)
     );
end ;

architecture arch of addr_mux is

begin

output <= A when ctr = "00" else
    B when ctr = "01" else
    C;
    
end;
