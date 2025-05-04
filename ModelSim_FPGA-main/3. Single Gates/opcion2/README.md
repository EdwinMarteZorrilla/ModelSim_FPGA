# Option #2: 
> [!IMPORTANT]
> This option is similar to Option 1, using the same top-level module and port mapping; however, the key difference is that the individual components are defined within the same file rather than in separate files.
<img src="https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/img/circuit.jpg" width=35% height=35%  align="center">
<img src="https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/img/opcion2.jpg" width=35% height=35%  align="center">

##  File Structure

> * Top Entity Definition
> * Top Arquitecture  Definition
>   - Components Defintiion
>       - And, Or, Nand, Not
>   - Signals Definitions
>   - Port Mapping
>   - Other Signal updates
> * Individual Entities
>    - Indvidual Arquitecture for each component

    
> [!NOTE]
> **VHDL Files:** The only difference that I have to made between the opcion 1 the full implementation
> with different files and all integrated is that now I had to define the individual entitities for each one, the previous code
> remain the same. Also I had to include wich libraires were used before each entity if not I would recieve an error.

**See the example below:**
```

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity single_not is
    Port ( 
        A  : in std_logic;
        Y  : out STD_LOGIC
    );
end single_not;

architecture Bev_not of single_not is

    
begin

    Y <= not A;

    
end Bev_not;
```

* [opcion2_Full.vhd](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion2/opcion2_full.vhd).
* [opcion2_Full_tb.vhd](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion2/opcion2_full_tb.vhd).

**Simulation:**
<img src="https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/img/simu_op2.png"  align="center">

**Options:**
* [Option #1:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/3.%20Single%20Gates) Using a top-level module that instantiates several individual gates, each defined in separate VHDL files.
* [Option #2:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion2) Creating components and instantiating them within the same VHDL file.
* [Option #3:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion3) Implementing the design in a single VHDL file using a behavioral architecture derived from the logic equation.
* [Option #4:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion4) Implementing the design in a single VHDL file using a behavioral architecture based on a truth table.
* [Led Blink:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/5.%20Led_blink) Toggle each 0.5 secs.









 
 



