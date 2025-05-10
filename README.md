# FPGA Projects

This repository contains a collection of FPGA projects designed to explore and demonstrate foundational concepts in VHDL, particularly focusing on combinational logic. The goal was to create a project that systematically tests and reinforces the basics of VHDL by implementing a randomly designed digital circuit.

The circuit used in this project incorporates a variety of logic gates, including AND, OR, NOT, and NAND. Special care was taken to use multiple types of logic gates and to ensure that several inputs and outputs on the FPGA board are utilized, providing a broad test of combinational logic implementation.

<ins>**Circuit Design:**</ins>

The following diagram represents the custom combinational logic circuit I designed for this project. The circuit was intentionally created to incorporate a diverse set of logic gates, demonstrating how different Boolean operations interact within a single design.

<ins>**Key features of this circuit include:**</ins>

* A mix of basic logic gates (AND, OR, NOT) and derived gates (NAND, NOR, XOR, XNOR).
* Multiple input variables to test different logic combinations.
* Several output signals to observe various computed logic results.
* Optimized for FPGA implementation, ensuring that all logic functions are correctly synthesized and mapped to hardware.
* Using ModelSim and Vivado
* Artys S7 for testing.
 <img src="https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/img/circuit.jpg" width=35% height=35%  align="center">  

**Note:** All inputs for the circuit are mapped to the switches on the Arty S7 FPGA board (SW0 to SW3), and the outputs are connected to the onboard LEDs (LED0 to LED3). Additionally, four internal signals—named A1, A2, A3, and A4—were defined to handle intermediate logic operations within the circuit. he circuit's response and its corresponding truth table are shown below.
 
 <img src="https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/img/table.jpg" width=35% height=35%>

From there My approach was to implement and simulate the circtuit in different ways to better understand how vhdl files are sturcture.

**Options:**
* [Option #1:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/3.%20Single%20Gates) Using a top-level module that instantiates several individual gates, each defined in separate VHDL files.
* [Option #2:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion2) Creating components and instantiating them within the same VHDL file.
* [Option #3:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion3) Implementing the design in a single VHDL file using a behavioral architecture derived from the logic equation.
* [Option #4:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/3.%20Single%20Gates/opcion4) Implementing the design in a single VHDL file using a behavioral architecture based on a truth table.
* [Led Blink:](https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/tree/main/5.%20Led_blink) Toggle each 0.5 secs.

**Future Projects** (from https://www.fpga4student.com/p/vhdl-project.html)

1. What is an FPGA? How VHDL works on FPGA
2. VHDL code for FIFO memory
3. VHDL code for FIR Filter
4. VHDL code for 8-bit Microcontroller
5. VHDL code for Matrix Multiplication 
6. VHDL code for Switch Tail Ring Counter
7. VHDL code for digital alarm clock on FPGA
8. VHDL code for 8-bit Comparator
9. How to load a text file into FPGA using VHDL
10. VHDL code for D Flip Flop
11. VHDL code for Full Adder
12. PWM Generator in VHDL with Variable Duty Cycle
13. VHDL code for counters with testbench
14. VHDL code for ALU
15. 16-bit ALU Design in VHDL using Verilog N-bit Adder
16. Shifter Design in VHDL
17. Non-linear Lookup Table Implementation in VHDL
18. Cryptographic Coprocessor Design in VHDL
19. Verilog vs VHDL: Explain by Examples
20. VHDL code for clock divider
21. How to generate a clock enable signal instead of creating another clock domain
22. VHDL code for debouncing buttons on FPGA
23. VHDL code for Traffic light controller
24. VHDL code for a simple 2-bit comparator
25. VHDL code for a single-port RAM
26. Car Parking System in VHDL using Finite State Machine (FSM)
27. VHDL coding vs Software Programming
28. VHDL code for MIPS Processor
29. Full VHDL code for Sequence Detector using Moore FSM
30. VHDL code for Seven-Segment Display on Basys 3 FPGA
31. VHDL code for Ov7670 Camera on Basys 3 FPGA
32. How to Read Image into FPGA using VHDL

