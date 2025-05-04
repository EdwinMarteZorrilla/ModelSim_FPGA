library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

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

