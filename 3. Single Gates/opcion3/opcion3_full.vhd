library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity opcion2_full is
    Port ( 
    sw : in STD_LOGIC_VECTOR (3 downto 0);        
        --SW(1)  : in STD_LOGIC;
		--C1  : in STD_LOGIC;
        led  : out STD_LOGIC_VECTOR(3 downto 0)
		--led(1)  : out STD_LOGIC
    );
end opcion2_full;

architecture Behavioral of opcion2_full is


signal   A1, A2, A3, A4 : STD_LOGIC ;         

begin 

	  A1 <=  sw(0) NAND sw(1);
	  A2 <= sw(2) AND A1;
	  A3 <= NOT A2;
	  A4 <= NOT sw(3);
	  
	  led(2) <= A3  OR A4;
	  led(0) <= A1;
	  led(1) <= A3;
	  led(3) <= A4;
  
    
end Behavioral;
