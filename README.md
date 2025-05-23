# FPGA Projects

This repository contains a collection of FPGA projects designed to explore and demonstrate foundational concepts in VHDL, particularly focusing on combinational logic (initially). 

The goal was to create a project that systematically tests and reinforces the basics of VHDL by implementing a randomly designed digital circuit.

First, I tried several things, but since I didn't remember everything, I had to reinstall some software and review others. For example, I installed 
[Vivado 2023](https://www.xilinx.com/support/download.html), [ModelSim](https://www.intel.com/content/www/us/en/software-kit/750666/modelsim-intel-fpgas-standard-edition-software-version-20-1-1.html), and a text editor I find comfortable to use: [Notepad++](https://notepad-plus-plus.org/downloads/)

**Experiment 1:** The first experiment I conducted was to recreate an example from a previous course to refresh my memory on how to use ModelSim. I used the 2-to-1 multiplexer example ([mux_2x1.vhd](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/1.%20Simple_Test/mux_2x1.vhd)) along with its corresponding testbench ([mux_2x1_tb.vhd](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/1.%20Simple_Test/mux_2x1_tb.vhd)).

**Experiment 2:** This is still a work in progress. I’ve started developing a communication protocol between the Arduino and the FPGA, allowing the Arduino to relay information from the PC to the FPGA. The main idea is to enable a PC program to send commands that the FPGA can execute. For example, sending the command 01 followed by two data bytes would instruct the FPGA to add the values and return the result. [The relevant files are included](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/2.%20FPGA_BasicMath_Shield), but again, this is an ongoing project and not yet complete.

**Experiment 3:** This experiment has multiple parts. I explore how to design a circuit in several ways:
* [3.0:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/simplecircuit.md) Problem Definition/description
* [3.1:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/3.%20Single%20Gates) Using a top-level module that instantiates several individual gates, each defined in separate VHDL files.
* [3.2:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion2) Creating components and instantiating them within the same VHDL file.
* [3.3:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion3) Implementing the design in a single VHDL file using a behavioral architecture derived from the logic equation.
* [3.4:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion4) Implementing the design in a single VHDL file using a behavioral architecture based on a truth table.

**Experiment 4:** This isn't an experiment per se, but rather a collection of grithub repositories and resocurces including  Professor Stitt's GitHub tutorial, which can be found [here](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/4.%20Github%20Resources)  as a reference.

**Experiment 5:** At this point, I needed precise timing for testing purposes. To validate the timing and functionality of the system, I implemented a test program that generated a 0.5-second time base derived from the Arty S7 board’s 100 MHz system clock. This was achieved by using a clock divider that counts the required number of cycles to match the desired interval. Once the time base was established, I created a simple LED sequence using the board's output LEDs. The LEDs were toggled in a defined pattern—such as a binary counter or shift sequence—at the 0.5-second interval. This setup allowed me to visually verify that the timing logic was functioning as expected and provided a reliable means to observe clock-driven changes on the hardware in real time. [Led Blink Sequence Here](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/5.%20Led_blink) 

**Experiment 6:** Building on the progress made in previous experiments, I set out to implement a simple traffic light system. To interface external hardware, I connected an ARAD traffic light board to the Arty S7 FPGA. Initially, I used the shield connectors, but later transitioned to the PMOD ports for better compatibility and layout. Ultimately, my final tests used a prebuilt Arduino-compatible traffic light module, which was connected via the shield ports. For this implementation, I designed a finite state machine (FSM) to manage the traffic light states, and I reused the timing mechanism developed in Experiment 5 to control state transitions with precise delays [FSM Traffic Light Files and Implementation.](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/6.%20FSM-Traffic) 



  Board Implementation    |   Basic FSM Diagram    |   
---   |   ------  |   
|  <img src="https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/img/artyled01.jpeg" width=50% height=50%  align="center">    |       <img src="https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/img/fsm.jpeg" width=50% height=50%  align="center">     |   
 

**Experiment 7:** After successfully completing Experiment 6, I wanted to enhance the project by integrating a 7-segment display to show the time count. I explored several approaches, including using a single 7-segment display or a 4-digit setup. However, I quickly realized that using discrete components required too many GPIO pins and wires, even for just one digit. The 4-digit version was not only cumbersome in wiring but also physically large, taking up too much space on the breadboard.

I then considered using an Arduino-style shield like [this one](https://www.amazon.com/gp/product/B0DFVM7WWT/ref=ox_sc_act_title_2?smid=A2I09K0JTUK8D0&psc=1), which is compact and integrates four 7-segment displays. However, it operates at 5V, which raised concerns since the FPGA I’m using requires 3.3V logic levels. After further research, I found a better alternative: [this 4-digit display module](https://www.amazon.com/dp/B0BFQWJ9Q8?ref=ppx_yo2ov_dt_b_fed_asin_title), which is controlled through only four pins and uses the TM1637 driver. It’s a compact, efficient solution compatible with 3.3V logic, making it ideal for FPGA-based designs. More details on the integration are [provided ahead <---](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/7%20I2C%207%20Segment).

**Other posssible Projects I want to explore:**
  [Project List](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/projects.md)

