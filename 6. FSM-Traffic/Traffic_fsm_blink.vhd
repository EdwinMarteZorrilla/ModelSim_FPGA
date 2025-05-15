
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity moore is
  generic (
        MAX_COUNT_VAL1 : integer := 50000000  -- default: 0.5s at 100 MHz
    );
    port (
    
        clk      : in  std_logic;
        PC       : out std_logic_vector(2 downto 0);
        Light       : out std_logic_vector(2 downto 0)
        );
end moore;



-- This architecture show a simplified version of the previous architecture.

architecture one_process_2 of moore is

    type state_t is (STATE0, STATE1, STATE2);


    -- Internal signals
    signal state_r         : state_t := STATE0;
    signal output_r        : std_logic_vector(2 downto 0) := "001";
    signal counter         : unsigned(25 downto 0) := (others => '0');
    signal en              : std_logic := '0';
    signal max_count_val   : integer := MAX_COUNT_VAL1;
    signal timing_counter  : integer := 0;  -- Count how many times to trigger timing function
    signal max_count       : unsigned(25 downto 0);
    signal timing_target  : integer := 1;  -- How many times to delay before changing state

    
begin
  -- Convert max_count_val to unsigned for the counter process
    max_count <= to_unsigned(max_count_val - 1, 26);

    -- State machine process
    process(clk)
    begin
        --if (rst = '0') then
        --    output_r <= "001";
        --    state_r  <= STATE0;
		--	en <= '0' ;
            
        if(clk'event and clk = '1') then

            case state_r is
            
            
            
            when STATE0 =>
                    output_r      <= "001";
                    max_count_val <= 50000000;  -- Delay for this state
                    timing_target <= 10;          -- Wait 2 delay cycles

                    if en = '1' then
                        if timing_counter = timing_target - 1 then
                            state_r        <= STATE1;
                            timing_counter <= 0;
                        else
                            timing_counter <= timing_counter + 1;
                        end if;
                    end if;
                    
                    
                               
--                  when STATE1 =>
--                    output_r      <= "010"; -- Yellow
--                   max_count_val <= 50000000;  -- Delay for this state
--                    timing_target <= 6;

--                    if en = '1' then
--                        if timing_counter = timing_target - 1 then
--                            state_r        <= STATE2;
--                            timing_counter <= 0;
--                        else
--                            timing_counter <= timing_counter + 1;
--                        end if;
--                    end if;
                    
                    
                    when STATE1 =>
    -- Blink yellow: ON when even count, OFF when odd
    if (timing_counter mod 2 = 0) then
        output_r <= "010";  -- Yellow ON
    else
        output_r <= "000";  -- All OFF (Yellow OFF)
    end if;

    max_count_val <= 50000000;  -- 0.5 second per count
    timing_target <= 6;         -- Total duration: 3 seconds (6 × 0.5s)

    if en = '1' then
        if timing_counter = timing_target - 1 then
            state_r        <= STATE2;
            timing_counter <= 0;
        else
            timing_counter <= timing_counter + 1;
        end if;
    end if;
                    
                    
                    
                    
                    
                when STATE2 =>
                    output_r      <= "100";
                    max_count_val <= 50000000;  -- Delay for this state
                    timing_target <= 8;

                    if en = '1' then
                        if timing_counter = timing_target - 1 then
                            state_r        <= STATE0;
                            timing_counter <= 0;
                        else
                            timing_counter <= timing_counter + 1;
                        end if;
                    end if;


               
                    
                when others => null;
            end case;
        end if;
    end process;
	
	
	 process( clk)
    begin
       
        if rising_edge( clk) then
            if counter = MAX_COUNT then
                counter <= (others => '0');       
                en <= '1';   				
            else
                counter <= counter + 1;
                en <= '0';
            end if;
        end if;
    end process;

    -- Assign the output register directly to the output.
    PC <= output_r;
    Light <= output_r;
end one_process_2;

