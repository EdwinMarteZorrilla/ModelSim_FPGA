library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use ieee.numeric_std.all;

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