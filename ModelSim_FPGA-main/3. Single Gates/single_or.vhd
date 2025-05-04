library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

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