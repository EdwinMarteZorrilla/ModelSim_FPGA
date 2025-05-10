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


**Other Projects:** (https://instrumentationtools.com/vhdl-projects/)

Binary Calculator: This project involves creating a VHDL model for a binary calculator that performs basic arithmetic operations. It’s a great introduction to arithmetic logic unit (ALU) design.
Traffic Light Controller: Design a traffic light control system, simulating the logic used in real-world traffic systems. It’s a practical application of finite-state machines in VHDL.
Digital Clock: Implement a digital clock using VHDL. This project teaches about counters and time division multiplexing.
7-Segment Display Decoder: A fundamental project where students create a decoder to drive a 7-segment display, essential for digital display applications.
VGA Controller: Design a controller to display images or text on a VGA monitor. It introduces concepts of video signal processing.
UART Communication: Implement a Universal Asynchronous Receiver/Transmitter (UART) for serial communication, which is critical in computer and microcontroller communication.
Temperature Sensor Interface: Interface a temperature sensor with an FPGA, converting analog signals to digital, useful in process control systems.
Alarm Clock with Snooze Feature: Enhance a basic digital clock with an alarm and snooze functionality. It’s a step-up project from the digital clock.
Memory Game: Create a simple memory game using an LED matrix and buttons, teaching about memory and user input handling.
Electronic Voting Machine: Develop a simple electronic voting system, which is a real-world application of secure and reliable digital systems.
Frequency Counter: Design a system to measure the frequency of an input signal, important in instrumentation and control systems.
Digital Thermometer: Implement a digital thermometer using an FPGA and a temperature sensor, teaching about ADC and digital conversion.
Home Automation System: Create a basic home automation system controlling lights or other devices, showcasing the application in smart home technologies.
Piano Sound Generator: Simulate a simple piano using VHDL, a fun project for understanding sound generation and digital signal processing.
Car Parking System: Model a car parking system that counts vehicles and shows available spaces, a practical application in automation and control systems.
LED Cube: Design a 3D LED cube controlled by FPGA, a creative project teaching about 3D display technology and control.
Morse Code Translator: Create a system that translates text to Morse code and vice versa, a great exercise in coding and decoding algorithms.
Reaction Timer Game: Develop a game to test reaction times using buttons and displays, a simple yet engaging project for understanding user input and display output.
FPGA-Based Guitar Tuner: Create a guitar tuner that uses an FPGA for frequency analysis and display, merging music with digital signal processing.
Digital Stopwatch: Implement a digital stopwatch with start, stop, and reset functions, teaching about timing and control.
RFID-Based Security System: Design a security system using RFID technology, applicable to access control systems.
FPGA-Based Oscilloscope: Develop a simple oscilloscope using FPGA, teaching about analog to digital conversion and signal processing.
Voice-Controlled Home Automation: Implement a system that uses voice commands to control home appliances, introducing students to voice recognition and IoT.
Bluetooth-Controlled Robot: Design a robot controlled via Bluetooth using FPGA, integrating wireless communication and control systems.
Digital Image Processing: Implement basic image processing algorithms like edge detection or filtering on FPGA, teaching about image analysis and manipulation.
Heart Rate Monitor: Develop a heart rate monitoring system using a sensor and FPGA, a practical application in biomedical engineering.
Ethernet Packet Processor: Create a system to process Ethernet packets using VHDL, important for understanding network protocols and data handling.
GPS Receiver Interface: Interface a GPS receiver with an FPGA to display location data, teaching about satellite communication and geolocation.
Digital Audio Processor: Develop a system to process and manipulate digital audio signals, teaching about audio signal processing.
Automatic Plant Watering System: Create a system that automatically waters plants based on soil moisture levels, integrating sensors and control logic.
FPGA-Based Game Console: Design a simple game console that can play basic games like Tetris or Snake, a fun project in digital design.
Wireless Sensor Network: Develop a simple wireless sensor network for data collection, relevant to IoT and remote monitoring.
Solar Tracker: Implement a solar panel tracking system using FPGA, a practical application in renewable energy systems.
Digital Compass: Design a digital compass using magnetometers and FPGA, teaching about magnetic field sensing and digital display.
Automated Traffic Signal Controller: Develop a traffic signal controller that adjusts timing based on traffic flow, an advanced application in control systems.
FPGA-Based Drone Controller: Create a controller for a drone, integrating concepts of flight control and wireless communication.
Gesture-Controlled Device: Implement a gesture-controlled interface, a modern application in human-computer interaction.
Smart Energy Meter: Design a smart energy metering system using FPGA, applicable in modern energy management systems.
FPGA-Based Calculator with Graphic Display: Develop a calculator that not only performs arithmetic operations but also displays them graphically.
Automated Guided Vehicle (AGV): Design an AGV system, teaching about automation in material handling and logistics.
Digital Voltmeter: Implement a voltmeter using FPGA, important for understanding electrical measurements and instrumentation.
FPGA-Based Pattern Generator: Create a pattern generator for testing displays or signal processing applications.
Robotic Arm Controller: Design a controller for a robotic arm, teaching about robotics and precise motion control.
FPGA-Based Video Game: Develop a simple video game like Pong or Space Invaders, a fun project in game design and graphics.
Color Sorter Machine: Implement a system to sort objects based on color, integrating sensors and control logic.
Automatic Door Opener: Design an automatic door opener system using sensors and FPGA, a practical application in automation.
Weather Monitoring Station: Develop a weather station that collects and displays atmospheric data, applicable in environmental monitoring.
Digital Spectrum Analyzer: Create a spectrum analyzer for analyzing signal frequencies, important in signal processing and telecommunications.
FPGA-Based Web Server: Implement a basic web server on FPGA, teaching about internet protocols and data handling.
Biometric Authentication System: Develop a system for biometric authentication like fingerprint or iris recognition, relevant to security systems.
FPGA-Based Encryption/Decryption System: Implement a system for encrypting and decrypting digital data, an essential application in cybersecurity.
Capacitance Meter: Design a capacitance meter using FPGA, useful for electrical and electronic measurements.
Automated Greenhouse Controller: Develop a controller for managing the environment in a greenhouse, an application in agricultural technology.
Waveform Generator: Implement a waveform generator that can produce various signal shapes, crucial for testing and measurement in electronics.
FPGA-Based PID Controller: Design a Proportional-Integral-Derivative (PID) controller for process control applications.
Digital Signal Router: Develop a system to route digital signals among multiple inputs and outputs, important for communication systems.
Real-Time Clock with Calendar: Implement a real-time clock that also displays the calendar, teaching about timekeeping in digital systems.
FPGA-Based Neural Network: Design a simple neural network on FPGA, an introduction to machine learning hardware implementation.
Optical Fiber Communication System: Develop a basic optical fiber communication system, relevant to high-speed communication networks.
Laser Distance Measurer: Implement a system that measures distance using a laser, an application in precision instrumentation.
FPGA-Based Radio Receiver: Design a simple radio receiver, teaching about wireless communication and signal processing.
Ambient Light Controller: Develop a system that controls lighting based on ambient light levels, relevant to smart building technology.
Ultrasonic Rangefinder: Implement a rangefinder using ultrasonic sensors, useful in various measurement applications.
Digital Logic Analyzer: Design a logic analyzer for troubleshooting digital circuits, an essential tool in digital electronics.
FPGA-Based Audio Mixer: Create an audio mixer that combines multiple audio inputs, teaching about audio signal handling.
Barcode Reader Interface: Develop a system to read and process barcode data, applicable in retail and inventory management.
MIDI Controller: Implement a Musical Instrument Digital Interface (MIDI) controller, merging music with digital technology.
Digital Fuel Gauge: Design a fuel gauge for vehicles using FPGA, a practical application in automotive instrumentation.
Automated Conveyor Belt System: Develop a conveyor belt system controlled by FPGA, relevant in manufacturing and logistics.
FPGA-Based Spectrum Analyzer for Wi-Fi Signals: Implement a spectrum analyzer for analyzing Wi-Fi signals, important in wireless network troubleshooting.
LED Scrolling Display: Create a scrolling LED display for messages, teaching about digital displays and user interfaces.
Motion Detection System: Develop a motion detection system, applicable in security and surveillance systems.
Digital Ammeter: Implement an ammeter using FPGA, essential for current measurements in electrical systems.
Remote Controlled Home Appliances: Design a system to control home appliances remotely, an application in home automation.
FPGA-Based Logic Trainer: Create a digital logic trainer for educational purposes, helping students understand basic digital concepts.
Radar System Simulation: Develop a basic radar system simulator, teaching about signal processing and detection technologies.
Wireless Power Transfer System: Implement a system for wireless power transfer, a modern application in energy transmission.
Automated Test Equipment (ATE): Design automated test equipment for electronics testing, crucial in quality assurance and manufacturing.
Digital Equalizer: Create a digital audio equalizer, an interesting project in audio signal processing.
FPGA-Based CNC Machine Controller: Develop a controller for a CNC (Computer Numerical Control) machine, merging digital design with mechanical automation.
Infrared (IR) Communication System: Implement a basic IR communication system, teaching about non-visible light communication.
FPGA-Based Spectrum Analyzer for Audio Signals: Design a spectrum analyzer specifically for audio signals, applicable in sound engineering.
Color Mixing Lamp: Create a lamp that mixes RGB colors, an application in lighting and color theory.
Digital Potentiometer: Develop a digital version of a potentiometer, a fundamental concept in electronic control.
NFC (Near Field Communication) Interface: Implement an NFC interface for contactless communication, relevant in mobile payments and IoT.
FPGA-Based Weather Forecasting System: Design a system for weather data collection and prediction, integrating sensors and data processing.
Intelligent Traffic Management System: Develop a system for managing traffic intelligently, using sensors and control algorithms.
FPGA-Based Motor Speed Controller: Implement a motor speed controller, a practical application in automation and robotics.
Digital Stethoscope: Design a digital stethoscope for medical applications, an intersection of healthcare and digital technology.
Voice-Activated Devices: Create devices that are activated by voice commands, an engaging project in human-machine interaction.
FPGA-Based Electric Vehicle Charger Controller: Develop a controller for electric vehicle chargers, important in the emerging field of electric mobility.
Digital Level (Inclinometer): Implement a digital level for measuring angles, useful in construction and surveying.
Wireless Controlled Robotic Arm: Design a robotic arm controlled wirelessly, teaching about remote control and automation.
FPGA-Based Metal Detector: Create a metal detector using FPGA, a practical application in security and treasure hunting.
Biomedical Signal Acquisition System: Develop a system for acquiring biomedical signals like ECG or EEG in medical instrumentation.
Digital Piano with Recording Feature: Implement a digital piano that can record and playback, merging music creation with digital storage.
RFID-Based Attendance System: Design an attendance system using RFID technology, applicable in educational and corporate settings.
Automated Aquarium Controller: Create a system to control conditions in an aquarium, an application in environmental control.
FPGA-Based Digital Multimeter: Develop a digital multimeter, an essential tool in electronics testing and measurement.
Smart Traffic Light System with Emergency Vehicle Priority: Implement a traffic light system that prioritizes emergency vehicles, a real-world application in smart city technology.

