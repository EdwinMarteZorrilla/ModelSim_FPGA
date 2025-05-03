library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_or is
    Port (
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        Y : out STD_LOGIC
    );
end test_or;

architecture rtl of test_or is
begin
    Y <= A or B;
end rtl;