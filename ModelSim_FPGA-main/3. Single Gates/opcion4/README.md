# Option #4: 
> [!IMPORTANT]
> Like the others this is similar, I checked basically the truth table to get things running.
<img src="https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/img/circuit.jpg" width=35% height=35%  align="center">

##  File Structure

> * Top Entity Definition
> * Top Arquitecture  Definition
>   - Process
>   - Case(sw)

    
> [!NOTE]
> **VHDL Files:** the code for the main module is shown below and the test bech basically is the same as per other options.

**See the code below:**
```
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity opcion2_full is
    Port ( 
    sw : in STD_LOGIC_VECTOR (3 downto 0);        
        --SW(1)  : in STD_LOGIC;
		--C1  : in STD_LOGIC;
        led  : out STD_LOGIC_VECTOR(3 downto 0)
		--led(1)  : out STD_LOGIC
    );
end opcion2_full;

architecture Behavioral of opcion2_full is
   

begin 

	   process(sw)
    begin
        case sw is
            when "0000" =>
                led <= "0000";
            when "0001" =>
                led <= "0001";
            when "0010" =>
                led <= "0010";
            when "0011" =>
                led <= "0011";
            when "0100" =>
                led <= "0100";
            when "0101" =>
                led <= "0101";
            when "0110" =>
                led <= "0110";
            when "0111" =>
                led <= "0111";
            when "1000" =>
                led <= "1000";
            when "1001" =>
                led <= "1001";
            when "1010" =>
                led <= "1010";
            when "1011" =>
                led <= "1011";
            when "1100" =>
                led <= "1100";
            when "1101" =>
                led <= "1101";
            when "1110" =>
                led <= "1110";
            when "1111" =>
                led <= "1111";
            when others =>
                led <= (others => '0');
        end case;
    end process;
end Behavioral;

```

* [opcion4_Full.vhd](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion4/opcion4_full.vhd).
* [opcion4_Full_tb.vhd](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion4/opcion4_full_tb.vhd).

**Options:**
* [Option #1:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/3.%20Single%20Gates) Using a top-level module that instantiates several individual gates, each defined in separate VHDL files.
* [Option #2:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion2) Creating components and instantiating them within the same VHDL file.
* [Option #3:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion3) Implementing the design in a single VHDL file using a behavioral architecture derived from the logic equation.
* [Option #4:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion4) Implementing the design in a single VHDL file using a behavioral architecture based on a truth table.
* [Led Blink:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/5.%20Led_blink) Toggle each 0.5 secs.






 
 



