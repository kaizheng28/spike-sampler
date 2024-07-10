# spike-sampler
Multi-channel spike sampling program. The code is originally designed for CMOD-A7 FPGA. 

# How to load the FPGA program
Open hardware manager in Xilinx Vivado and load spike-sampler.bit to the FPGA. In this case, the FPGA needs to be reprogrammed each time it power cycles. 

Alternatively, create a memory configuration file and load spike-sampler.bin to the FPGA. The program is then loaded into the flash and no longer needs to be loaded every time.

# MATLAB Spike Capturing Program Usage
Once powered on, the FPGA starts sampling the spikes, and when a spike is detected, the FPGA sends the spike channel ID and the timestamp to the host PC through UART. 

The MATLAB program opens a UART port and records the spike information for a certain amount of time. 

The FPGA supports a total of 16 spike channels. However, on the NeuroRadar baseboard, only 12 channels are connected, as shown in the figure below.

![image](https://github.com/kaizheng28/spike-sampler/assets/144567523/1fe3e34d-6da5-463c-9f9e-eca11bb247b5)

In the gesture recognition case study, 3 NeuroRadar channels are employed which corresponds to 6 spike channels. 

In the localization case study, 6 NeuroRadar channels are employed which corresponds to 12 spike channels. 

# File Description
**gesture_samp.m**  

Spike sampling program for the gesture recognition use case.

**loc_samp.m**      

Spike sampling program for the localization use case. 

**spike_samp.m**   

General spike sampling program. 

# More resources
[SNN construction and optimization](https://github.com/kaizheng28/neuro-radar-snn/)
[Hardware design files](https://github.com/kaizheng28/neuro-radar-pcb)

# Reference
Kai Zheng, Kun Qian, Timothy Woodford, and Xinyu Zhang. 2024. NeuroRadar: A Neuromorphic Radar Sensor for Low-Power IoT Systems. In Proceedings of the 21st ACM Conference on Embedded Networked Sensor Systems (SenSys '23). Association for Computing Machinery, New York, NY, USA, 223–236. https://doi.org/10.1145/3625687.3625788
