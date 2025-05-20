# 7 Segment Display Integration

**First Options:**

I considered including using a single 7-segment display or a 4-digit setup. However, I quickly realized that using discrete components required too many GPIO pins and wires, even for just one digit. The 4-digit version was not only cumbersome in wiring but also physically large, taking up too much space on the breadboard.

Single 7 Segment Display    |   Discrete 4 Segment Display Module    |   
---   |   ------  |   
|  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/Seven_segment_02_Pengo.jpg/1200px-Seven_segment_02_Pengo.jpg" width=50% height=50%  align="center">    |       <img src="https://th.bing.com/th/id/R.ac22dd04ad6e7eb510ce287559875460?rik=%2bCA6lJZuqa%2fEBQ&riu=http%3a%2f%2fwww.circuitbasics.com%2fwp-content%2fuploads%2f2017%2f05%2fArduino-7-Segment-Tutorial-4-Digit-Display-2.jpg&ehk=4fvTFN3nOIIEPcJOoaJg7H8QD8KAbkDyT3oOpKBoguI%3d&risl=&pid=ImgRaw&r=0" width=75% height=75%  align="center">     |   
   
**Second Option:**

I then considered using an Arduino-style shield like this one, which is compact and integrates four 7-segment displays. However, it operates at 5V, which raised concerns since the FPGA I’m using requires 3.3V logic levels. 


| Arduino Shield | Resources |
|--------------------------|------------------------------------|
| <img src="https://store.arrowdot.io/wp-content/uploads/2021/09/Multi-functional-Expansion.jpg" width="300"> | • <a href="https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/4.%20Github%20Resources/2.%20multifunctionshield/multi_function_board_schematic.pdf" target="_blank">Board Schematic (PDF)</a><br>• <a href="https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/4.%20Github%20Resources/2.%20multifunctionshield" target="_blank">Shield Repository and Examples</a><br>• <a href="https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/4.%20Github%20Resources/3.%20MFShield/examples" target="_blank">Another Repository with Examples</a> |

**Third Option:**

The last option I velauated was using this 4-digit display module (below), which is controlled through only four pins and uses the TM1637 driver. It’s a compact, efficient solution compatible with 3.3V logic, making it ideal for FPGA-based designs. 

| Arduino Shield | Resources |
|--------------------------|------------------------------------|
| <img src="https://github.com/user-attachments/assets/128e4307-4254-4268-b928-04369fe2f766" width="100" /> | • <a href="https://github.com/avishorp/TM1637/tree/master" target="_blank">Github Library</a><br>• <a href="https://gannochenko.dev/blog/tm1637-led-driver-meets-arduino-detailed-explanation" target="_blank">Explanation and example</a><br>• <a href="https://github.com/revolunet/tm1637/blob/master/datasheet-en.pdf" target="_blank">TM1637 Datasheet</a> |

This circuit behaves like an I²C device and requires adherence to a specific communication protocol to function properly. Internally, it includes two pull-up resistors, so the pins connected to the DIO and CLK lines must actively drive the signals low (to ground) when needed and remain configured as inputs otherwise.

 <img src="https://github.com/user-attachments/assets/9b574a66-7917-4fe8-8401-6fce9253934f" width=75% />

For testing in VHDL, I created several modules, starting with a basic shifter. This module takes an 8-bit input and shifts out one bit at a time by controlling the DIO and CLK lines, allowing the output to behave according to the datasheet specifications. The module initially had an 8-bit data input port and a load pin. Its outputs included the CLK and DIO signals, and I also added a finish signal pin.

 <img src="https://github.com/user-attachments/assets/d2fc0824-b88f-4ccf-8209-050f8b05f054" width=35% />

I based this design on an example from the Arduino library resources written in C. Afterward, I integrated the shifter into a finite state machine (FSM) to initialize the data in a manner similar to the Arduino library.

 <img src="https://github.com/user-attachments/assets/2fb88a96-3583-4b43-b824-89467c214b6d" width=75% />

<details>

<summary>Code for the Shifter</summary>

This VHDL module implements a serial shift register designed to send out 8-bit data one bit at a time through a bidirectional data line (dio) synchronized with a clock output (clk_out). At its core, the design uses a clock divider process to generate a slower internal clock tick (clk_tick) from a faster system clock (clk). This clock tick acts as the timing reference for the shift operations, allowing the data bits to be shifted out at precise intervals. The clock divider counts system clock cycles up to a defined threshold (CLK_DIV_COUNT), then toggles the clk_tick signal, effectively slowing down the shifting speed to match the protocol requirements.

The second major block handles the shifting logic itself, which is triggered on the rising edge of the slower clk_tick. When the load input signal transitions from low to high, the input 8-bit data is loaded into the internal shift register, and the module begins shifting the data bit-by-bit. Each clk_tick causes the shift register to move its bits left, outputting the most significant bit on the dio pin while incrementing a counter to track how many bits have been sent. Once all 8 bits have been shifted out, the module sets the done flag to indicate completion and stops shifting. The bidirectional output pins are carefully controlled: when shifting, the dio pin drives a low ('0') if the current bit is zero, otherwise it releases to high impedance ('Z'), mimicking open-drain behavior typical in I2C-like protocols. Similarly, the clk_out pin is driven low or released based on the clk_tick signal, coordinating timing with the data output.
```
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
	-- For Simulation
	constant CLK_FREQ      : INTEGER := 10;      -- 10 MHz   
    constant CLK_DIV_COUNT : INTEGER := CLK_FREQ / 5; -- 100 us
	
	--For deployment
	--constant CLK_FREQ      : INTEGER := 100000000;      -- 10 MHz--   
    --constant CLK_DIV_COUNT : INTEGER := CLK_FREQ / 100; -- 1 us
	
	
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
```

</details>

Files:
* [shiftingonly.vhd](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/7%20I2C%207%20Segment/shiftingonly.vhd)
* [shiftingonly_tb.vhd](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/7%20I2C%207%20Segment/shiftingonly_tb.vhd)

**Simulation**
![image](https://github.com/user-attachments/assets/462301b8-3357-48e9-ac0e-9ebc0bee0ab9)

This image shows the input data being shifted out through the DIO pin every two clock cycles. Notice that the DIO and CLK pins go to high-impedance ("Z") state when they are expected to hold a high value, following the I²C protocol behavior.

 
<p float="left">
  <img src="https://github.com/user-attachments/assets/128e4307-4254-4268-b928-04369fe2f766" width="100" />
  <img src="https://github.com/user-attachments/assets/128e4307-4254-4268-b928-04369fe2f766" width="100" /> 
  <img src="https://github.com/user-attachments/assets/128e4307-4254-4268-b928-04369fe2f766" width="100" />
</p>

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
>This VHDL code defines a simple Moore finite state machine (FSM) for an FPGA implementation, simulating a basic traffic light system with three states. The FSM operates on a clock signal and cycles through three states: STATE0, STATE1, and STATE2, each representing different light outputs (001, 010, 100) which might correspond to Green, Yellow, and Red respectively. A generic parameter MAX_COUNT_VAL1 defines the base timing interval, typically 0.5 seconds at a 100 MHz clock. The FSM uses a combination of two counters: one (counter) to generate timing ticks by comparing against MAX_COUNT, and another (timing_counter) to determine how many such ticks each state should last. Transitions between states occur only when both a timing enable (en) signal is active and the desired number of ticks (timing_target) has elapsed.

> [!NOTE]
> The architecture is organized into two main processes: one for managing state transitions and output logic, and the other for generating the en pulse at defined intervals. The FSM starts in STATE0, outputs "001", and waits 10 timing intervals before transitioning to STATE1, which outputs "010" and lasts 6 intervals, followed by STATE2 with "100" lasting 8 intervals before looping back. The outputs PC and Light are both driven by the same register, output_r, effectively representing the current state externally. This implementation demonstrates a clean separation of timing logic from state transitions and allows for easy reconfiguration of state durations through parameters.
```

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
                    
                    
                               
                  when STATE1 =>
                    output_r      <= "010"; -- Yellow
                   max_count_val <= 50000000;  -- Delay for this state
                    timing_target <= 6;

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
```

> [!NOTE]
> **VHDL Files**

* [Traffic_fsm.vhd](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/6.%20FSM-Traffic/Traffic_fsm.vhd).

Here below a variant of the original program where the yellow led is blinking during the transition from green to yellow.

* [Traffic_fsm_blink.vhd](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/6.%20FSM-Traffic/Traffic_fsm_blink.vhd)

The two VHDL programs implement similar traffic light controllers using a Moore finite state machine, but they differ in how the yellow light behavior is handled. The first program follows a standard traffic light sequence: Green (STATE0) → Yellow (STATE1) → Red (STATE2) → Green. Each light is displayed steadily for a fixed duration by assigning a unique 3-bit output pattern to output_r in each state. The transitions are time-based and occur after a predefined number of clock-based delay cycles. In STATE1, the yellow light remains on continuously for a specific duration (6 × 0.5s = 3 seconds), as defined by timing_target.

The second program modifies the behavior of the yellow light in STATE1 to blink instead of staying solid. This is achieved by alternating the output_r value between "010" (yellow ON) and "000" (all OFF) every other cycle using a modulus operation (timing_counter mod 2). This gives a blinking effect with a 1-second period (0.5s ON, 0.5s OFF), repeated for the total timing_target duration. The rest of the FSM structure—including state types, timing counter logic, and state transitions—remains unchanged. This small adjustment demonstrates how a minor modification in output logic within a single state can significantly affect the system's observable behavior while preserving the general FSM architecture.
```

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
```
**Demo**
 [![Youtube Video Demo](https://i9.ytimg.com/vi/EepTHyhbnfA/mqdefault.jpg)](https://youtu.be/EepTHyhbnfA)


