library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity shield_01_tb is
end shield_01_tb;

architecture Behavioral of shield_01_tb is

    component shield_01
        Port (
            clk   : in std_logic;
            --PC    : inout STD_LOGIC_VECTOR (7 downto 0);
			PC    : out STD_LOGIC_VECTOR (7 downto 0);
            start : in std_logic;
            PB    : in STD_LOGIC_VECTOR (7 downto 0)
        );
		
		-- PC7 is ACK
		-- PB6
		-- PB7
    end component;

    signal clk   : std_logic := '0';
    signal start : std_logic := '0';
    signal PB    : std_logic_vector(7 downto 0) := (others => '1');
    --signal PC    : std_logic_vector(7 downto 0) := (others => 'Z');
	signal PC    : std_logic_vector(7 downto 0) ;
	
	 function to_string(slv: std_logic_vector) return string is
    variable result: string(1 to slv'length);
begin
    for i in slv'range loop
        if slv(i) = '1' then
            result(i - slv'low + 1) := '1';
        else
            result(i - slv'low + 1) := '0';
        end if;
    end loop;
    return result;
end function;

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: shield_01 port map (
        clk   => clk,
        PC    => PC,
        start => start,
        PB    => PB
    );

    -- Clock generation
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initialization
        PB <= (others => '1');
        start <= '0';
        wait for 20 ns;

        -- Start the operation
        start <= '1';
        wait for 10 ns;

        -- 1. Write operation: simulate WR falling edge with data
        --PB(6 downto 0) <= "0001110";  -- Data to write
		PB(5 downto 0) <= "011011";  -- 6 bits for data
        PB(6) <= '1'; -- WR = high initially
        wait for 10 ns;
        PB(6) <= '0'; -- WR falling edge -> triggers write
        wait for 20 ns;
        PB(6) <= '1'; -- WR back high
        wait for 20 ns;

        -- 2. Read operation: simulate RD falling edge
        PB(7) <= '1'; -- RD = high initially
        wait for 10 ns;
        PB(7) <= '0'; -- RD falling edge -> triggers read
        wait for 20 ns;
        PB(7) <= '1'; -- RD back high
        wait for 20 ns;
		
		
        -- Final Report
        wait for 50 ns;
        report "Final PC = b" & to_string(PC);

        -- End of test
        wait;
        
    end process;

end Behavioral;

