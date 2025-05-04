library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity single_and is
    Port ( 
        A  : in std_logic;
        B  : in STD_LOGIC;
        Y  : out STD_LOGIC
    );
end single_and;

architecture Behavioral of single_and is

    
begin

    Y <= A and B;

    
end Behavioral;

