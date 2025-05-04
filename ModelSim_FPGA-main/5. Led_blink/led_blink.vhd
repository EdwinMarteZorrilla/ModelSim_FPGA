library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity led_blink is
  generic (
        MAX_COUNT_VAL : integer := 50000000  -- default: 0.5s at 100 MHz
    );
    Port (
        clk : in  STD_LOGIC;             -- 100 MHz clock input
        led  : out STD_LOGIC_VECTOR(3 downto 0)              -- LED output
    );
end led_blink;

architecture Behavioral of led_blink is

    --constant MAX_COUNT : unsigned(25 downto 0) := to_unsigned(50_000_000 - 1, 26); -- 0.5 sec at 100 MHz
	constant MAX_COUNT : unsigned(25 downto 0) := to_unsigned(MAX_COUNT_VAL - 1, 26);
    signal counter     : unsigned(25 downto 0) := (others => '0');
    signal led_reg     : STD_LOGIC_vector(3 downto 0) := "0001";

begin

    process( clk)
    begin
       
        if rising_edge( clk) then
            if counter = MAX_COUNT then
                counter <= (others => '0');
                if led_reg ="0001" then
                    led_reg <= "0010";
                    elsif  led_reg = "0010" then
                    led_reg <= "0100";
                    elsif  led_reg = "0100" then
                    led_reg <= "1000";
                    else
                    led_reg <= "0001";
                      
                end if;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    led <= led_reg;

end Behavioral;
