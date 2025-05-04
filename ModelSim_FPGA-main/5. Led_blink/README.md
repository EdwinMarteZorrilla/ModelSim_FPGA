# LED Blink - Clock from a 100MHZ

This project is simple, it creates a sequence on LEDS on the ARTY S7 Board. The most relevant implementation here is counting 50^6 clock counts to get a half a second timer.
Also another relevant implementation was creating a maximum variable to speed up the simulation.

<ins>**Code:**</ins>
> [!NOTE]
>See the line: MAX_COUNT_VAL : integer := 50000000  -- default: 0.5s at 100 MHz. If no max values is passed the system assumes a 100MHZ clk.
```

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

```
System work both in Hardware and simulation!

**Testbench**

```
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
```
**Simulation**
 <img src="https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/img/led_blink.png"   align="center">  
**Options:**
* [Option #1:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/3.%20Single%20Gates) Using a top-level module that instantiates several individual gates, each defined in separate VHDL files.
* [Option #2:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion2) Creating components and instantiating them within the same VHDL file.
* [Option #3:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion3) Implementing the design in a single VHDL file using a behavioral architecture derived from the logic equation.
* [Option #4:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion4) Implementing the design in a single VHDL file using a behavioral architecture based on a truth table.
* [Led Blink:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/5.%20Led_blink) Toggle each 0.5 secs.


