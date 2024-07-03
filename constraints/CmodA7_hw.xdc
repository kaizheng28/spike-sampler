set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS true [current_design]

# GCLK 12MHZ Tied to USB
create_clock -period 83.330 -name GCLK [get_ports GCLK]
set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVCMOS33} [get_ports GCLK]


# Buttons
set_property -dict {PACKAGE_PIN A18 IOSTANDARD LVCMOS33} [get_ports BTN0]
set_property -dict {PACKAGE_PIN B18 IOSTANDARD LVCMOS33} [get_ports BTN1]

# LEDs
set_property -dict {PACKAGE_PIN A17 IOSTANDARD LVCMOS33} [get_ports {LED[0]}]
set_property -dict {PACKAGE_PIN C16 IOSTANDARD LVCMOS33} [get_ports {LED[1]}]

# RGB LED
set_property -dict {PACKAGE_PIN B17 IOSTANDARD LVCMOS33} [get_ports LED0_B]
set_property -dict {PACKAGE_PIN B16 IOSTANDARD LVCMOS33} [get_ports LED0_G]
set_property -dict {PACKAGE_PIN C17 IOSTANDARD LVCMOS33} [get_ports LED0_R]

# UART
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports UART_RXD_OUT]
set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports UART_TXD_IN]

# GPIO Pins
# Pins 15 and 16 should remain commented if using them as analog inputs
set_property -dict { PACKAGE_PIN M3    IOSTANDARD LVCMOS33 } [get_ports { gnd_pins_1 }]; #IO_L8N_T1_AD14N_35 Sch=pio[01]
set_property -dict { PACKAGE_PIN L3    IOSTANDARD LVCMOS33 } [get_ports { PIO1 }]; #IO_L8P_T1_AD14P_35 Sch=pio[02]
set_property -dict { PACKAGE_PIN A16   IOSTANDARD LVCMOS33 } [get_ports { gnd_pins_2 }]; #IO_L12P_T1_MRCC_16 Sch=pio[03]
set_property -dict { PACKAGE_PIN K3    IOSTANDARD LVCMOS33 } [get_ports { PIO2 }]; #IO_L7N_T1_AD6N_35 Sch=pio[04]
set_property -dict { PACKAGE_PIN C15   IOSTANDARD LVCMOS33 } [get_ports { gnd_pins_3 }]; #IO_L11P_T1_SRCC_16 Sch=pio[05]
set_property -dict { PACKAGE_PIN H1    IOSTANDARD LVCMOS33 } [get_ports { PIO3 }]; #IO_L3P_T0_DQS_AD5P_35 Sch=pio[06]
set_property -dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS33 } [get_ports { gnd_pins_4 }]; #IO_L6N_T0_VREF_16 Sch=pio[07]
set_property -dict { PACKAGE_PIN B15   IOSTANDARD LVCMOS33 } [get_ports { PIO4 }]; #IO_L11N_T1_SRCC_16 Sch=pio[08]
set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS33 } [get_ports { gnd_pins_5 }]; #IO_L6P_T0_16 Sch=pio[09]
set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { PIO5 }]; #IO_L7P_T1_AD6P_35 Sch=pio[10]
set_property -dict { PACKAGE_PIN J1    IOSTANDARD LVCMOS33 } [get_ports { gnd_pins_6 }]; #IO_L3N_T0_DQS_AD5N_35 Sch=pio[11]
set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { PIO6 }]; #IO_L5P_T0_AD13P_35 Sch=pio[12]
set_property -dict { PACKAGE_PIN L1    IOSTANDARD LVCMOS33 } [get_ports { gnd_pins_7 }]; #IO_L6N_T0_VREF_35 Sch=pio[13]
set_property -dict { PACKAGE_PIN L2    IOSTANDARD LVCMOS33 } [get_ports { PIO7 }]; #IO_L5N_T0_AD13N_35 Sch=pio[14]
set_property -dict { PACKAGE_PIN M1    IOSTANDARD LVCMOS33 } [get_ports { gnd_pins_8 }]; #IO_L9N_T1_DQS_AD7N_35 Sch=pio[17]
set_property -dict { PACKAGE_PIN N3    IOSTANDARD LVCMOS33 } [get_ports { PIO8 }]; #IO_L12P_T1_MRCC_35 Sch=pio[18]
#set_property -dict { PACKAGE_PIN P3    IOSTANDARD LVCMOS33 } [get_ports { pio[19] }]; #IO_L12N_T1_MRCC_35 Sch=pio[19]
#set_property -dict { PACKAGE_PIN M2    IOSTANDARD LVCMOS33 } [get_ports { pio[20] }]; #IO_L9P_T1_DQS_AD7P_35 Sch=pio[20]
#set_property -dict { PACKAGE_PIN N1    IOSTANDARD LVCMOS33 } [get_ports { pio[21] }]; #IO_L10N_T1_AD15N_35 Sch=pio[21]
#set_property -dict { PACKAGE_PIN N2    IOSTANDARD LVCMOS33 } [get_ports { pio[22] }]; #IO_L10P_T1_AD15P_35 Sch=pio[22]
#set_property -dict { PACKAGE_PIN P1    IOSTANDARD LVCMOS33 } [get_ports { pio[23] }]; #IO_L19N_T3_VREF_35 Sch=pio[23]
#set_property -dict { PACKAGE_PIN R3    IOSTANDARD LVCMOS33 } [get_ports { pio[26] }]; #IO_L2P_T0_34 Sch=pio[26]
#set_property -dict { PACKAGE_PIN T3    IOSTANDARD LVCMOS33 } [get_ports { pio[27] }]; #IO_L2N_T0_34 Sch=pio[27]
#set_property -dict { PACKAGE_PIN R2    IOSTANDARD LVCMOS33 } [get_ports { pio[28] }]; #IO_L1P_T0_34 Sch=pio[28]
#set_property -dict { PACKAGE_PIN T1    IOSTANDARD LVCMOS33 } [get_ports { pio[29] }]; #IO_L3P_T0_DQS_34 Sch=pio[29]
#set_property -dict { PACKAGE_PIN T2    IOSTANDARD LVCMOS33 } [get_ports { pio[30] }]; #IO_L1N_T0_34 Sch=pio[30]
#set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33 } [get_ports { pio[31] }]; #IO_L3N_T0_DQS_34 Sch=pio[31]
#set_property -dict { PACKAGE_PIN W2    IOSTANDARD LVCMOS33 } [get_ports { pio[32] }]; #IO_L5N_T0_34 Sch=pio[32]
set_property -dict { PACKAGE_PIN V2    IOSTANDARD LVCMOS33 } [get_ports { PIO16 }]; #IO_L5P_T0_34 Sch=pio[33]
set_property -dict { PACKAGE_PIN W3    IOSTANDARD LVCMOS33 } [get_ports { gnd_pins_16 }]; #IO_L6N_T0_VREF_34 Sch=pio[34]
set_property -dict { PACKAGE_PIN V3    IOSTANDARD LVCMOS33 } [get_ports { PIO15 }]; #IO_L6P_T0_34 Sch=pio[35]
set_property -dict { PACKAGE_PIN W5    IOSTANDARD LVCMOS33 } [get_ports { gnd_pins_15 }]; #IO_L12P_T1_MRCC_34 Sch=pio[36]
set_property -dict { PACKAGE_PIN V4    IOSTANDARD LVCMOS33 } [get_ports { PIO14 }]; #IO_L11N_T1_SRCC_34 Sch=pio[37]
set_property -dict { PACKAGE_PIN U4    IOSTANDARD LVCMOS33 } [get_ports { gnd_pins_14 }]; #IO_L11P_T1_SRCC_34 Sch=pio[38]
set_property -dict { PACKAGE_PIN V5    IOSTANDARD LVCMOS33 } [get_ports { PIO13 }]; #IO_L16N_T2_34 Sch=pio[39]
set_property -dict { PACKAGE_PIN W4    IOSTANDARD LVCMOS33 } [get_ports { gnd_pins_13 }]; #IO_L12N_T1_MRCC_34 Sch=pio[40]
set_property -dict { PACKAGE_PIN U5    IOSTANDARD LVCMOS33 } [get_ports { PIO12 }]; #IO_L16P_T2_34 Sch=pio[41]
set_property -dict { PACKAGE_PIN U2    IOSTANDARD LVCMOS33 } [get_ports { gnd_pins_12 }]; #IO_L9N_T1_DQS_34 Sch=pio[42]
set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33 } [get_ports { PIO11 }]; #IO_L13N_T2_MRCC_34 Sch=pio[43]
set_property -dict { PACKAGE_PIN U3    IOSTANDARD LVCMOS33 } [get_ports { gnd_pins_11 }]; #IO_L9P_T1_DQS_34 Sch=pio[44]
set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports { PIO10 }]; #IO_L19P_T3_34 Sch=pio[45]
set_property -dict { PACKAGE_PIN W7    IOSTANDARD LVCMOS33 } [get_ports { gnd_pins_10 }]; #IO_L13P_T2_MRCC_34 Sch=pio[46]
set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS33 } [get_ports { PIO9 }]; #IO_L14P_T2_SRCC_34 Sch=pio[47]
set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports { gnd_pins_9 }]; #IO_L14N_T2_SRCC_34 Sch=pio[48]

#set_false_path -from [get_clocks -of_objects [get_pins u_clk_gen/inst/mmcm_adv_inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins u_clk_gen/inst/mmcm_adv_inst/CLKOUT0]]
#
set_multicycle_path -from [get_clocks -of_objects [get_pins u_clk_gen/inst/mmcm_adv_inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins u_clk_gen/inst/mmcm_adv_inst/CLKOUT0]] 5
set_multicycle_path -hold -from [get_clocks -of_objects [get_pins u_clk_gen/inst/mmcm_adv_inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins u_clk_gen/inst/mmcm_adv_inst/CLKOUT0]] 4

# We hold pulse_rst high for a lot of (500MHz) cycles.  We don't read pulse_capture until after we're done doing the reset.  This should be fine.
set_false_path -from [get_pins u_pulse_2/pulse_rst_reg/C] -to [get_pins u_pulse_2/pulse_capture_reg/R]

set_max_delay -from [get_clocks -of_objects [get_pins u_clk_gen/inst/mmcm_adv_inst/CLKOUT2]] -to [get_clocks -of_objects [get_pins u_clk_gen/inst/mmcm_adv_inst/CLKOUT0]] 16.000
set_max_delay -from [get_clocks -of_objects [get_pins u_clk_gen/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins u_clk_gen/inst/mmcm_adv_inst/CLKOUT2]] 4.000

set_property MARK_DEBUG true [get_nets merge_strm_tready]
set_property MARK_DEBUG true [get_nets merge_strm_tvalid]
set_property MARK_DEBUG true [get_nets u_pulse_2/ts_pulse]
set_property MARK_DEBUG true [get_nets u_pulse_1/ts_pulse]


set_property MARK_DEBUG true [get_nets uart_rxd]
set_property MARK_DEBUG true [get_nets uart_tx_en]
set_property MARK_DEBUG true [get_nets uart_tx_tready]

set_property MARK_DEBUG true [get_nets pulse1_strm_tready]
set_property MARK_DEBUG true [get_nets pulse2_strm_tready]
set_property MARK_DEBUG true [get_nets pulse3_strm_tready]
set_property MARK_DEBUG true [get_nets pulse4_strm_tready]
set_property MARK_DEBUG true [get_nets pulse5_strm_tready]
set_property MARK_DEBUG true [get_nets pulse6_strm_tready]
set_property MARK_DEBUG true [get_nets mergifier_n_6]
set_property MARK_DEBUG true [get_nets pulse1_strm_tvalid]
set_property MARK_DEBUG true [get_nets pulse2_strm_tvalid]
set_property MARK_DEBUG true [get_nets pulse3_strm_tvalid]
set_property MARK_DEBUG true [get_nets pulse4_strm_tvalid]
set_property MARK_DEBUG true [get_nets pulse5_strm_tvalid]
set_property MARK_DEBUG true [get_nets pulse6_strm_tvalid]
set_property MARK_DEBUG true [get_nets pulse7_strm_tvalid]
set_property MARK_DEBUG true [get_nets u_pulse_6/ts_pulse]
set_property MARK_DEBUG true [get_nets u_pulse_5/ts_pulse]
set_property MARK_DEBUG true [get_nets u_pulse_4/ts_pulse]
set_property MARK_DEBUG true [get_nets u_pulse_3/ts_pulse]

connect_debug_port u_ila_0/probe2 [get_nets [list mergifier_n_6]]


