library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity single_full is
    Port ( 
    sw : in STD_LOGIC_VECTOR (3 downto 0);        
        --SW(1)  : in STD_LOGIC;
		--C1  : in STD_LOGIC;
        led  : out STD_LOGIC_vector(3 downto 0)
		--led(1)  : out STD_LOGIC
    );
end single_full;



entity single_or is
    Port ( 
        A  : in std_logic;
        B  : in STD_LOGIC;
        Y  : out STD_LOGIC
    );
end single_or;

architecture Behavioral of single_or is

    
begin

    Y <= A or B;

    
end Behavioral;






entity single_not is
    Port ( 
        A  : in std_logic;
        Y  : out STD_LOGIC
    );
end single_not;

architecture Behavioral of single_not is

    
begin

    Y <= not A;

    
end Behavioral;


entity single_nand is
    Port ( 
        A  : in std_logic;
        B  : in STD_LOGIC;
        Y  : out STD_LOGIC
    );
end single_nand;

architecture Behavioral of single_nand is

    
begin

    Y <= not (A  and B);

    
end Behavioral;



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


signal   A1, A2, A3, A4 : STD_LOGIC ;         

begin 
  

  
  -- Funcionando Circuito X
  
 
  UUT1: single_and port map (A => sw(2), B => A1 , Y => A2 );
  UUT4: single_not port map (A => A2, Y => A3);
  UUT3: single_or port map (A => A3, B => A4 , Y => led(2));
  UUT5: single_not port map (A => sw(3), Y => A4);
  UUT2: single_nand port map (A => sw(0), B => sw(1) , Y => A1);
  
  led(0) <= A1;
  led(1) <= A3;
  led(3) <= A4;
  
    
end Behavioral;