
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

