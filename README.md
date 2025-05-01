# ModelSim_FPGA
FPGA Projects

This repository contains a collection of FPGA projects designed to explore and demonstrate foundational concepts in VHDL, particularly focusing on combinational logic. The goal was to create a project that systematically tests and reinforces the basics of VHDL by implementing a randomly designed digital circuit.

The circuit used in this project incorporates a variety of logic gates, including AND, OR, NOT, and NAND. Special care was taken to use multiple types of logic gates and to ensure that several inputs and outputs on the FPGA board are utilized, providing a broad test of combinational logic implementation.

!!Circuit Design
The following diagram represents the custom combinational logic circuit I designed for this project. The circuit was intentionally created to incorporate a diverse set of logic gates, demonstrating how different Boolean operations interact within a single design.

Key features of this circuit include:

A mix of basic logic gates (AND, OR, NOT) and derived gates (NAND, NOR, XOR, XNOR).

Multiple input variables to test different logic combinations.

Several output signals to observe various computed logic results.

Optimized for FPGA implementation, ensuring that all logic functions are correctly synthesized and mapped to hardware.

 <img src="https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/img/circuit.jpg" width=35% height=35%  align="center">  

 And the correspondent truth table is below.
 
 <img src="https://github.com/EdwinMarteZorrilla/ModelSim_FPGA/blob/main/img/table.jpg" width=35% height=35%>

From there My approach was to implement and simulate the circtuit in different ways to better understand how vhdl files are sturcture.

* Option #1: Using a main module intetiating several indivdual gates / vhdl files.
* Option #2: Creating components and inettianting in the same file
* Option #3: Single file using behavarl structure (table response)
* Option #4: Single file using beahiviral responding to the equiation
