library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_opcion2_full is
end tb_opcion2_full;

architecture Behavioral of tb_opcion2_full is

    -- Component under test
    component opcion2_full
        Port (
            sw  : in  STD_LOGIC_VECTOR(3 downto 0);
            led : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Testbench signals
    signal sw  : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal led : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Instantiate the DUT (Device Under Test)
    uut: opcion2_full
        port map (
            sw  => sw,
            led => led
        );

    -- Stimulus process
    stim_proc: process
    begin
        for i in 0 to 15 loop
            sw <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
        end loop;
        wait;
    end process;

end Behavioral;
