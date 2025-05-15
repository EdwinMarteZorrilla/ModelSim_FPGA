library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ShiftRegisterSerial_tb is
end ShiftRegisterSerial_tb;

architecture behavior of ShiftRegisterSerial_tb is

    -- Component declaration
    component ShiftRegisterSerial
        Port (
            clk      : in  STD_LOGIC;
            reset    : in  STD_LOGIC;
            load     : in  STD_LOGIC;
            data     : in  STD_LOGIC_VECTOR(7 downto 0);
            dio      : inout STD_LOGIC;
            clk_out  : inout STD_LOGIC;
            done     : out STD_LOGIC
        );
    end component;

    -- Testbench signals
    signal clk     : STD_LOGIC := '0';
    signal reset   : STD_LOGIC := '0';
    signal load    : STD_LOGIC := '0';
    signal data    : STD_LOGIC_VECTOR(7 downto 0) := x"CA";  -- 🟢 Set to hex CA
    signal dio     : STD_LOGIC;
    signal clk_out : STD_LOGIC;
    signal done    : STD_LOGIC;
	
	-- Simulated pull-ups
    --signal dio_bus     : STD_LOGIC;
    --signal clk_out_bus : STD_LOGIC;

    constant clk_period : time := 100 ns; -- 10 MHz

begin

  -- Simulated pull-ups (external bus driving '1' when undriven)
    --dio_bus <= dio when dio /= 'Z' else '1';
    --clk_out_bus <= clk_out when clk_out /= 'Z' else '1';

    -- Assign back to DUT ports
   -- dio <= dio_bus;
    --clk_out <= clk_out_bus;
	
	
    -- Instantiate the unit under test
    uut: ShiftRegisterSerial
        Port map (
            clk      => clk,
            reset    => reset,
            load     => load,
            data     => data,
            dio      => dio,
            clk_out  => clk_out,
            done     => done
        );

    -- Clock generation
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus
    stim_proc: process
    begin
        -- Reset pulse
        reset <= '1';
        wait for 2 ns;
        reset <= '0';

        -- Load data
        wait for 2 ns;
        load <= '1';
		    report "LOAD asserted. Data = x""CA"" (11001010)";
		
		        -- Wait until done becomes 1
        wait until done = '1';
		

        -- Clear load
        load <= '0';
		 report "DONE received. LOAD deasserted.";

   report "Testbench finished.";
        wait; -- Wait forever

		
    end process;

end behavior;
