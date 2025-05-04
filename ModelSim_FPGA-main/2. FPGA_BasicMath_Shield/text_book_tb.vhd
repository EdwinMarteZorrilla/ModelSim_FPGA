library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity text_book_tb is
           
end text_book_tb;


architecture Behavioral of text_book_tb is

component text_book
	port (a,b,c : in std_logic;
			j,k : out std_logic
			);
end component;

signal           abc :  STD_LOGIC_VECTOR (2 downto 0);
signal           j_i,k_i : STD_LOGIC ;         

begin 
  UUT: text_book port map (a => abc(2), b => abc(1) , c => abc(0), j => j_i, k => k_i);
  
  estimulus:
 process
   begin
      abc <= "000";
	  wait for 100 ns;
	  
	  abc <= "001";
	  wait for 100 ns;
	  
	  abc <= "010";
	  wait for 100 ns;
	  
	  abc <= "011";
	  wait for 100 ns;
	  
	  abc <= "100";
	  wait for 100 ns;
	  
	  abc <= "101";
	  wait for 100 ns;
	  
	  abc <= "110";
	  wait for 100 ns;
	  
	  abc <= "111";
	  wait for 100 ns;
	  wait;

	end process ;
  




end Behavioral;
