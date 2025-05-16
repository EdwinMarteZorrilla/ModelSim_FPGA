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


