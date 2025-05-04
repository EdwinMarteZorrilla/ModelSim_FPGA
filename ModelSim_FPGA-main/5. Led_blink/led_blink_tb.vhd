library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_led_blink is
end tb_led_blink;

architecture Behavioral of tb_led_blink is

    signal clk : STD_LOGIC := '0';
    signal led : STD_LOGIC_VECTOR(3 downto 0);

    -- Clock generation process: 10 ns period (100 MHz)
    constant clk_period : time := 1 ns;

begin

    -- Instantiate the DUT
    uut: entity work.led_blink
        generic map (
            MAX_COUNT_VAL => 11   -- Faster simulation
        )
        port map (
            clk => clk,
            led => led
        );

    -- Clock generation
    clk_process: process
    begin
        while now < 1 us loop  -- Run simulation for 1 microsecond
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

end Behavioral;
