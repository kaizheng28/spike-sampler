# spike-sampler
Multi-channel spike sampling program. The code is orignally designed for CMOD-A7 FPGA. 

# How to load the FPGA program
Open hardware manager in Xilinx Vivado and load spike-sampler.bit to the FPGA. In this case, the FPGA needs to be reprogrammed each time it power cycles. 

Alternatively, create a memory configuration file and load spike-sampler.bin to the FPGA. The program is then loaded into the flash and no longer needs to be loaded every time.

# MATLAB Spike Capturing Program Usage
MATLAB programs read packets from the FPGA through UART. The FPGA sends spike channel ID and the timestamp. 

**gesture_samp.m**  

Spike sampling program for gesture recognition use case.

**loc_samp.m**      

Spike sampling program for localization use case. 

**spike_samp.m**   

General spike sampling program. 

# More resources
[SNN construction and optimization](https://github.com/kaizheng28/neuro-radar-snn/)
[Hardware design files](https://github.com/kaizheng28/neuro-radar-pcb)

# Reference
Kai Zheng, Kun Qian, Timothy Woodford, and Xinyu Zhang. 2024. NeuroRadar: A Neuromorphic Radar Sensor for Low-Power IoT Systems. In Proceedings of the 21st ACM Conference on Embedded Networked Sensor Systems (SenSys '23). Association for Computing Machinery, New York, NY, USA, 223–236. https://doi.org/10.1145/3625687.3625788
