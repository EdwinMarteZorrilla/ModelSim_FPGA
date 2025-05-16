# Traffic Light FSM
This projects is a simple traffic light goig from green to yellow, then to red and nback to green. The leds are display in both the ARAD board and the 

To interface external hardware, I connected an ARAD traffic light board to the Arty S7 FPGA. Initially, I used the shield connectors, but later transitioned to the PMOD ports for better compatibility and layout. Ultimately, my final tests used a prebuilt Arduino-compatible traffic light module, which was connected via the shield ports. See the port configuration below:

<img src="https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/img/artyled01.jpeg" width=50% height=35%  align="center">

**Ports configuration:**

```
## Pmod Header JA
set_property -dict { PACKAGE_PIN L17   IOSTANDARD LVCMOS33 } [get_ports { PC[7] }]; #IO_L4P_T0_D04_14 Sch=ja_p[1]
set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { PC[6] }]; #IO_L4N_T0_D05_14 Sch=ja_n[1]
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { PC[5] }]; #IO_L5P_T0_D06_14 Sch=ja_p[2]
set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports { PC[4] }]; #IO_L5N_T0_D07_14 Sch=ja_n[2]
set_property -dict { PACKAGE_PIN M16   IOSTANDARD LVCMOS33 } [get_ports { PC[3] }]; #IO_L7P_T1_D09_14 Sch=ja_p[3]
set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports { PC[2] }]; #IO_L7N_T1_D10_14 Sch=ja_n[3]
set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports { PC[1] }]; #IO_L8P_T1_D11_14 Sch=ja_p[4]
set_property -dict { PACKAGE_PIN N18   IOSTANDARD LVCMOS33 } [get_ports { PC[0] }]; #IO_L8N_T1_D12_14 Sch=ja_n[4]

#set_property -dict { PACKAGE_PIN U11   IOSTANDARD LVCMOS33 } [get_ports { PC[0] }]; #IO_L24P_T3_A01_D17_14        Sch=jd10/ck_io[26]
#set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { PC[1] }]; #IO_L23N_T3_A02_D18_14        Sch=jd9/ck_io[27]
#set_property -dict { PACKAGE_PIN R11   IOSTANDARD LVCMOS33 } [get_ports { PC[2] }]; #IO_L23P_T3_A03_D19_14        Sch=jd8/ck_io[28]
#set_property -dict { PACKAGE_PIN T13   IOSTANDARD LVCMOS33 } [get_ports { PC[3] }]; #IO_L22N_T3_A04_D20_14        Sch=jd7/ck_io[29]
#set_property -dict { PACKAGE_PIN T12   IOSTANDARD LVCMOS33 } [get_ports { PC[4] }]; #IO_L22P_T3_A05_D21_14        Sch=jd4/ck_io[30]
#set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports { PC[5] }]; #IO_L21N_T3_DQS_A06_D22_14    Sch=jd3/ck_io[31]
#set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { PC[6] }]; #IO_L21P_T3_DQS_14            Sch=jd2/ck_io[32]
#set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { PC[7] }]; #IO_L20N_T3_A07_D23_14        Sch=jd1/ck_io[33]

#set_property -dict { PACKAGE_PIN L13   IOSTANDARD LVCMOS33 } [get_ports { start }]; #IO_0_14 Sch=ck_io[0]

## Pmod Header JB
set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports { PB[7] }]; #IO_L9P_T1_DQS_14 Sch=jb_p[1]
set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { PB[6] }]; #IO_L9N_T1_DQS_D13_14 Sch=jb_n[1]
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { PB[5] }]; #IO_L10P_T1_D14_14 Sch=jb_p[2]
set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { PB[4] }]; #IO_L10N_T1_D15_14 Sch=jb_n[2]
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { PB[3] }]; #IO_L11P_T1_SRCC_14 Sch=jb_p[3]
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { PB[2] }]; #IO_L11N_T1_SRCC_14 Sch=jb_n[3]
set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports { PB[1] }]; #IO_L12P_T1_MRCC_14 Sch=jb_p[4]
set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports { PB[0] }]; #IO_L12N_T1_MRCC_14 Sch=jb_n[4]

#set_property -dict { PACKAGE_PIN L13   IOSTANDARD LVCMOS33 } [get_ports { PB[0] }]; #IO_0_14 Sch=ck_io[0]
#set_property -dict { PACKAGE_PIN N13   IOSTANDARD LVCMOS33 } [get_ports { PB[1] }]; #IO_L6N_T0_D08_VREF_14   Sch=ck_io[1]
#set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { PB[2] }]; #IO_L3N_T0_DQS_EMCCLK_14 Sch=ck_io[2]
#set_property -dict { PACKAGE_PIN R14   IOSTANDARD LVCMOS33 } [get_ports { PB[3] }]; #IO_L13P_T2_MRCC_14      Sch=ck_io[3]
#set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { PB[4] }]; #IO_L13N_T2_MRCC_14      Sch=ck_io[4]
#set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports { PB[5] }]; #IO_L14P_T2_SRCC_14      Sch=ck_io[5]
#set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { PB[6] }]; #IO_L14N_T2_SRCC_14      Sch=ck_io[6]
#set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { PB[7] }]; #CIO_L16N_T2_A15_D31_14   Sch=ck_io[7]

## ChipKit SPI Header
## NOTE: The ChipKit SPI header ports can also be used as digital I/O and share FPGA pins with ck_io10-13. Do not use both at the same time.
#set_property -dict { PACKAGE_PIN H16   IOSTANDARD LVCMOS33 } [get_ports { ck_io10_ss   }]; #IO_L22P_T3_A17_15   Sch=ck_io10_ss
set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { Light[0] }]; #IO_L22N_T3_A16_15   Sch=ck_io11_mosi
set_property -dict { PACKAGE_PIN K14   IOSTANDARD LVCMOS33 } [get_ports { Light[1] }]; #IO_L23P_T3_FOE_B_15 Sch=ck_io12_miso
set_property -dict { PACKAGE_PIN G16   IOSTANDARD LVCMOS33 } [get_ports { Light[2]  }]; #IO_L14P_T2_SRCC_15  Sch=ck_io13_sck
```
* [XDC File](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/6.%20FSM-Traffic/Arty-S7-50-Master.xdc)

See that PC and PB were defined. PB and PC are ports for the ARAD board. PC I am using for LEDS and PB for Push buttons. Also Light in the shield ports were defined were the traffic light is to be conected.

For this implementation, I designed a finite state machine (FSM) to manage the traffic light states, and I reused the timing mechanism developed in Experiment 5 to control state transitions with precise delays FSM Traffic Light Files and Implementation.

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
* [3.0:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/simplecircuit.md) Problem Definition/description
* [3.1:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/3.%20Single%20Gates) Using a top-level module that instantiates several individual gates, each defined in separate VHDL files.
* [3.2:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion2) Creating components and instantiating them within the same VHDL file.
* [3.3:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion3) Implementing the design in a single VHDL file using a behavioral architecture derived from the logic equation.
* [3.4:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion4) Implementing the design in a single VHDL file using a behavioral architecture based on a truth table.


