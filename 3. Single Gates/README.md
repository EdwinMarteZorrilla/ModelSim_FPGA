# Option #1: 
> [!IMPORTANT]
> Using a top-level module to instantiate several individual gate-level components, each defined in separate VHDL files
<img src="https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/img/circuit.jpg" width=35% height=35%  align="center">
<img src="https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/img/opcion1.jpg" width=35% height=35%  align="center">

##  File Structure

> * Top Entity Definition
> * Top Arquitecture  Definition
>   - Components Defintiion
>       - And, Or, Nand, Not
>   - Signals Definitions
>   - Port Mapping
>   - Other Signal updates

    
> [!NOTE]
> **VHDL Files and Testbench**

* [Single_Full.vhd](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/single_full.vhd).
* [Test Bench](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/single_full_tb.vhd.)

```
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity single_full_tb is
-- Test bench does not have any ports
end single_full_tb;

architecture Behavioral of single_full_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component single_full
        Port (
            sw : in STD_LOGIC_VECTOR (3 downto 0);
            led : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    -- Signals to connect to UUT
    signal sw : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal led : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: single_full
        Port map (
            sw => sw,
            led => led
        );

    -- Stimulus process to iterate through all possible combinations of inputs
    stim_proc: process
    begin
        for i in 0 to 15 loop
            sw <= std_logic_vector(to_unsigned(i, 4)); -- Assign all 16 combinations of sw
            wait for 10 ns; -- Wait for the output to stabilize
        end loop;

        -- End simulation
        wait;
    end process;

end Behavioral;
```

## **Simulation on ModelSim using the test bech file:** <img src="https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/img/sim_full.png"   align="center">    


> [!IMPORTANT]
> **CODE**
* [Single_and.vhd](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/single_and.vhd)
* [Single nand.vhd](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/single_nand.vhd)
* [Single_or.vhd](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/single_or.vhd)
* [Single_not.vhd](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/single_not.vhd)


**Options:**
* [Option #1:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/3.%20Single%20Gates) Using a top-level module that instantiates several individual gates, each defined in separate VHDL files.
* [Option #2:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion2) Creating components and instantiating them within the same VHDL file.
* [Option #3:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion3) Implementing the design in a single VHDL file using a behavioral architecture derived from the logic equation.
* [Option #4:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion4) Implementing the design in a single VHDL file using a behavioral architecture based on a truth table.





 
 



