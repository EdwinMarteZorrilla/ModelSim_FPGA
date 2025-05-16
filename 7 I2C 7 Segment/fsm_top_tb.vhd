library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FSM_Top_tb is
end FSM_Top_tb;

architecture behavior of FSM_Top_tb is

    -- Component declaration for FSM_Top
    component FSM_Top
        Port (
            clk     : in  STD_LOGIC;
            reset   : in  STD_LOGIC;
            dio     : inout STD_LOGIC;
            clk_out : inout STD_LOGIC
        );
    end component;

    -- Signals to connect to the DUT
    signal clk     : STD_LOGIC := '0';
    signal reset   : STD_LOGIC := '0';
    signal dio     : STD_LOGIC := 'Z';
    signal clk_out : STD_LOGIC := 'Z';

    constant clk_period : time := 100 ns; -- 10 MHz

begin

    -- Instantiate the DUT (FSM_Top)
    uut: FSM_Top
        port map (
            clk     => clk,
            reset   => reset,
            dio     => dio,
            clk_out => clk_out
        );

    -- Clock generation process
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc : process
    begin
        -- Apply reset
        reset <= '1';
        wait for 200 ns;
        reset <= '0';
        report "Reset deasserted, FSM should begin shifting.";

        -- Let the FSM complete all three shift operations
        wait for 20 ms;

        report "Test completed. Check waveform for 3 serial transfers (CA, B2, 3F).";
        wait;
    end process;

end behavior;
