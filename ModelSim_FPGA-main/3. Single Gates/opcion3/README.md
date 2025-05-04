# Option #3: 
> [!IMPORTANT]
> This option is similar to Option 2 but instead of using components here we are using the equations directly.
<img src="https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/img/circuit.jpg" width=35% height=35%  align="center">

##  File Structure

> * Top Entity Definition
> * Top Arquitecture  Definition
>   - Signals Definitions
>   - Equations
>   - Other Signal updates

    
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


signal   A1, A2, A3, A4 : STD_LOGIC ;         

begin 

	  A1 <=  sw(0) NAND sw(1);
	  A2 <= sw(2) AND A1;
	  A3 <= NOT A2;
	  A4 <= NOT sw(3);
	  
	  led(2) <= A3  OR A4;
	  led(0) <= A1;
	  led(1) <= A3;
	  led(3) <= A4;
  
    
end Behavioral;

```

* [opcion3_Full.vhd](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion2/opcion3_full.vhd).
* [opcion3_Full_tb.vhd](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion2/opcion3_full_tb.vhd).

**Options:**
* [Option #1:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/3.%20Single%20Gates) Using a top-level module that instantiates several individual gates, each defined in separate VHDL files.
* [Option #2:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion2) Creating components and instantiating them within the same VHDL file.
* [Option #3:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion3) Implementing the design in a single VHDL file using a behavioral architecture derived from the logic equation.
* [Option #4:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion4) Implementing the design in a single VHDL file using a behavioral architecture based on a truth table.
* [Led Blink:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/5.%20Led_blink) Toggle each 0.5 secs.





 
 



