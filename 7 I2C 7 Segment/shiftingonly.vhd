library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ShiftRegisterSerial is
    Port (
        clk      : in  STD_LOGIC;                     -- System clock (e.g., 10 MHz)
        reset    : in  STD_LOGIC;                     -- Asynchronous reset
        load     : in  STD_LOGIC;                     -- Load signal
        data     : in  STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit data input
        dio      : inout STD_LOGIC;                   -- Bidirectional serial output
        clk_out  : inout STD_LOGIC;                   -- Bidirectional shift clock
        done     : out STD_LOGIC                      -- Done flag
    );
end ShiftRegisterSerial;

architecture Behavioral of ShiftRegisterSerial is
    signal shift_reg : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal bit_count : INTEGER range 0 to 8 := 0;
    signal shifting  : STD_LOGIC := '0';

    signal clk_div   : INTEGER := 0;
    signal clk_tick  : STD_LOGIC := '0';
	--signal data : STD_LOGIC_VECTOR(7 downto 0) := x"CA";
	signal prev_load         : STD_LOGIC := '0';
	signal shift_in_progress : STD_LOGIC := '0';

    --constant CLK_FREQ      : INTEGER := 10000000;      -- 10 MHz
	constant CLK_FREQ      : INTEGER := 10;      -- 10 MHz
    constant CLK_DIV_COUNT : INTEGER := CLK_FREQ / 5; -- 100 us
begin

    -- Clock divider: generates clk_tick every 100 us
    process(clk, reset)
    begin
        if reset = '1' then
            clk_div  <= 0;
            clk_tick <= '0';
        elsif rising_edge(clk) then
            if clk_div >= (CLK_DIV_COUNT / 2) then
                clk_div  <= 0;
                clk_tick <= not clk_tick;
            else
                clk_div <= clk_div + 1;
            end if;
        end if;
    end process;

    -- Shift logic on clk_tick rising edge
    -- Shifting and load control logic
    process(clk_tick, reset)
    begin
        if reset = '1' then
            shift_reg         <= (others => '0');
            bit_count         <= 0;
            shifting          <= '0';
            shift_in_progress <= '0';
            done              <= '0';
            prev_load         <= '0';

        elsif rising_edge(clk_tick) then

            -- Rising edge of load
            if load = '1' and prev_load = '0' then
                shift_reg         <= data;
                bit_count         <= 0;
                shifting          <= '1';
                shift_in_progress <= '1';
                done              <= '0';
            end if;

            -- Perform shifting if active
            if shifting = '1' then
                shift_reg <= shift_reg(6 downto 0) & '0';  -- Left shift
                bit_count <= bit_count + 1;

                if bit_count = 7 then
                    shifting          <= '0';
                    shift_in_progress <= '0';
                    done              <= '1';
                end if;
            end if;

            -- Update load tracking
            prev_load <= load;
        end if;
    end process;

    -- Bidirectional Output Logic: Drive '0' or release to 'Z' for '1'
	--dio <= shift_reg(7) when shifting = '1' else 'Z';
    dio <= '0' when shifting = '1' and shift_reg(7) = '0' else 'Z';
    clk_out <= '0' when clk_tick = '0' else 'Z';

end Behavioral;
