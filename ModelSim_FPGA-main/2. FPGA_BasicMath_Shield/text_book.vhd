----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2025 12:56:29 AM
-- Design Name: 
-- Module Name: shield_01 - Behavioral
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
use ieee.numeric_std.all;   --for math operations

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity text_book is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           j : out STD_LOGIC;
           c : in std_logic;
           k : out STD_LOGIC);
end text_book;

architecture Behavioral of text_book is
signal abc :  STD_LOGIC_VECTOR (2 downto 0);

begin

   abc <= a & b & C;
   
   j <=  '1' when (abc = "001" OR abc = "011") else
   '0' ;
   
process(abc)

begin
case abc is
 when "000" | "001" | "011" | "101" | "100" =>
   k <= '1';		
		when others =>
		   k <= '0';
		   end case;
end process;
end Behavioral;
