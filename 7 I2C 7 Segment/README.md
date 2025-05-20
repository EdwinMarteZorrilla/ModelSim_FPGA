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

<ins>**Code:**</ins>
> [!NOTE]
>This VHDL code defines a simple Moore finite state machine (FSM) for an FPGA implementation, simulating a basic traffic light system with three states. The FSM operates on a clock signal and cycles through three states: STATE0, STATE1, and STATE2, each representing different light outputs (001, 010, 100) which might correspond to Green, Yellow, and Red respectively. A generic parameter MAX_COUNT_VAL1 defines the base timing interval, typically 0.5 seconds at a 100 MHz clock. The FSM uses a combination of two counters: one (counter) to generate timing ticks by comparing against MAX_COUNT, and another (timing_counter) to determine how many such ticks each state should last. Transitions between states occur only when both a timing enable (en) signal is active and the desired number of ticks (timing_target) has elapsed.

> [!NOTE]
> The architecture is organized into two main processes: one for managing state transitions and output logic, and the other for generating the en pulse at defined intervals. The FSM starts in STATE0, outputs "001", and waits 10 timing intervals before transitioning to STATE1, which outputs "010" and lasts 6 intervals, followed by STATE2 with "100" lasting 8 intervals before looping back. The outputs PC and Light are both driven by the same register, output_r, effectively representing the current state externally. This implementation demonstrates a clean separation of timing logic from state transitions and allows for easy reconfiguration of state durations through parameters.

 
<p float="left">
  <img src="https://github.com/user-attachments/assets/128e4307-4254-4268-b928-04369fe2f766" width="100" />
  <img src="https://github.com/user-attachments/assets/128e4307-4254-4268-b928-04369fe2f766" width="100" /> 
  <img src="https://github.com/user-attachments/assets/128e4307-4254-4268-b928-04369fe2f766" width="100" />
</p>

