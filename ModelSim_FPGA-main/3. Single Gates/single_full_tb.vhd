library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity single_full_tb is
-- Test bench does not have any ports
end single_full_tb;

architecture Behavioral of single_full_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component single_full
        Port (
            sw : in STD_LOGIC_VECTOR (3 downto 0);
            led : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    -- Signals to connect to UUT
    signal sw : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal led : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: single_full
        Port map (
            sw => sw,
            led => led
        );

    -- Stimulus process to iterate through all possible combinations of inputs
    stim_proc: process
    begin
        for i in 0 to 15 loop
            sw <= std_logic_vector(to_unsigned(i, 4)); -- Assign all 16 combinations of sw
            wait for 10 ns; -- Wait for the output to stabilize
        end loop;

        -- End simulation
        wait;
    end process;

end Behavioral;