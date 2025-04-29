library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity single_full is
    Port ( 
        A1  : in std_logic;
        B1  : in STD_LOGIC;
		C1  : in STD_LOGIC;
        X1  : out STD_LOGIC;
		Y1  : out STD_LOGIC
    );
end single_full;

architecture Behavioral of single_full is


component single_and is
    Port ( 
        A  : in std_logic;
        B  : in STD_LOGIC;
        Y  : out STD_LOGIC
    );
end component single_and;


component single_nand is
    Port ( 
        A  : in std_logic;
        B  : in STD_LOGIC;
        Y  : out STD_LOGIC
    );
end component single_nand;

component single_or is
    Port ( 
        A  : in std_logic;
        B  : in STD_LOGIC;
        Y  : out STD_LOGIC
    );
end component single_or;

component single_not is
    Port ( 
        A  : in std_logic;
        Y  : out STD_LOGIC
    );
end component single_not;


signal           S1, S2, S3 : STD_LOGIC ;         

begin 
  UUT1: single_and port map (A => S3, B => C1 , Y => X1 );
  
  UUT2: single_nand port map (A => A1, B => S1 , Y => S3);
  
  UUT3: single_or port map (A => S2, B => C1 , Y => Y1);
  
  UUT4: single_not port map (A => B1, Y => S2);
  
  UUT5: single_not port map (A => S1, Y => S2);
  
  
    


    
end Behavioral;