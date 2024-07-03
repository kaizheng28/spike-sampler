`timescale 1ns / 1ps

module spike_sampler_top
  (
   
   input 	GCLK,
   input 	BTN0,
   input 	BTN1,

   //LEDS
   output [1:0] LED,
   output 	LED0_B,
   output 	LED0_G,
   output 	LED0_R,

   //UART
   input 	UART_TXD_IN,
   output 	UART_RXD_OUT,

   //GPIO
   input 	PIO1,
   input 	PIO2,
   input 	PIO3,
   input 	PIO4,
   input 	PIO5,
   input 	PIO6,
   input 	PIO7,
   input 	PIO8,
   input 	PIO9,
   input 	PIO10,
   input 	PIO11,
   input 	PIO12,
   input 	PIO13,
   input 	PIO14,
   input 	PIO15,
   input 	PIO16,   
   // Connect to ground
   output gnd_pins_1,
   output gnd_pins_2,
   output gnd_pins_3,
   output gnd_pins_4,
   output gnd_pins_5,
   output gnd_pins_6,
   output gnd_pins_7,
   output gnd_pins_8,   
   output gnd_pins_9,
   output gnd_pins_10,
   output gnd_pins_11,
   output gnd_pins_12,
   output gnd_pins_13,
   output gnd_pins_14,
   output gnd_pins_15,
   output gnd_pins_16
   );
   
wire 	uart_clkg;
wire    ts_clk;
wire    sample_clk;

wire 	reset;
wire 	locked;

wire 	btn0;
wire 	btn1;
wire 	btn0_int;
wire 	btn1_int;

wire    uart_txd;
wire    uart_rxd;

wire        uart_tx_done;
wire [7:0]  uart_tx_byte;
wire        uart_tx_en;
wire        uart_tx_active;
wire        uart_tx_tready;
wire 		uart_rx_wr_en;
wire [7:0] 	uart_rx_data;

wire [31:0] pulse0_strm_tdata;
wire        pulse0_strm_tvalid;
wire        pulse0_strm_tready;

wire [31:0] pulse1_strm_tdata;
wire        pulse1_strm_tvalid;
wire        pulse1_strm_tready;

wire [31:0] pulse2_strm_tdata;
wire        pulse2_strm_tvalid;
wire        pulse2_strm_tready;

wire [31:0] pulse3_strm_tdata;
wire        pulse3_strm_tvalid;
wire        pulse3_strm_tready;

wire [31:0] pulse4_strm_tdata;
wire        pulse4_strm_tvalid;
wire        pulse4_strm_tready;

wire [31:0] pulse5_strm_tdata;
wire        pulse5_strm_tvalid;
wire        pulse5_strm_tready;

wire [31:0] pulse6_strm_tdata;
wire        pulse6_strm_tvalid;
wire        pulse6_strm_tready;

wire [31:0] pulse7_strm_tdata;
wire        pulse7_strm_tvalid;
wire        pulse7_strm_tready;

wire [31:0] pulse8_strm_tdata;
wire        pulse8_strm_tvalid;
wire        pulse8_strm_tready;

wire [31:0] pulse9_strm_tdata;
wire        pulse9_strm_tvalid;
wire        pulse9_strm_tready;

wire [31:0] pulse10_strm_tdata;
wire        pulse10_strm_tvalid;
wire        pulse10_strm_tready;

wire [31:0] pulse11_strm_tdata;
wire        pulse11_strm_tvalid;
wire        pulse11_strm_tready;

wire [31:0] pulse12_strm_tdata;
wire        pulse12_strm_tvalid;
wire        pulse12_strm_tready;

wire [31:0] pulse13_strm_tdata;
wire        pulse13_strm_tvalid;
wire        pulse13_strm_tready;

wire [31:0] pulse14_strm_tdata;
wire        pulse14_strm_tvalid;
wire        pulse14_strm_tready;

wire [31:0] pulse15_strm_tdata;
wire        pulse15_strm_tvalid;
wire        pulse15_strm_tready;

wire [31:0] merge_strm_tdata;
wire        merge_strm_tvalid;
wire        merge_strm_tready;

IBUF i_IBUF_BTN0(.I (BTN0),.O (btn0));
IBUF i_IBUF_BTN1(.I (BTN1),.O (btn1));
IBUF i_IBUF_UART_TXD_IN(.I (UART_TXD_IN),.O (uart_txd));

OBUFT i_OBUF_UART_RXD_OUT(.I (uart_rxd),.O (UART_RXD_OUT));

OBUF i_OBUF_LED0(.I(1'b0),.O(LED[0]));
OBUF i_OBUF_LED1(.I(1'b1),.O(LED[1]));
OBUF i_OBUF_LED0_B(.I(1'b1),.O(LED0_B));
OBUF i_OBUF_LED0_R(.I(1'b0),.O(LED0_R));
OBUF i_OBUF_LED0_G(.I(1'b0),.O(LED0_G));

OBUF i_OBUF_GND_1(.I(1'b0),.O(gnd_pins_1));
OBUF i_OBUF_GND_2(.I(1'b0),.O(gnd_pins_2));
OBUF i_OBUF_GND_3(.I(1'b0),.O(gnd_pins_3));
OBUF i_OBUF_GND_4(.I(1'b0),.O(gnd_pins_4));
OBUF i_OBUF_GND_5(.I(1'b0),.O(gnd_pins_5));
OBUF i_OBUF_GND_6(.I(1'b0),.O(gnd_pins_6));
OBUF i_OBUF_GND_7(.I(1'b0),.O(gnd_pins_7));
OBUF i_OBUF_GND_8(.I(1'b0),.O(gnd_pins_8));
OBUF i_OBUF_GND_9(.I(1'b0),.O(gnd_pins_9));
OBUF i_OBUF_GND_10(.I(1'b0),.O(gnd_pins_10));
OBUF i_OBUF_GND_11(.I(1'b0),.O(gnd_pins_11));
OBUF i_OBUF_GND_12(.I(1'b0),.O(gnd_pins_12));
OBUF i_OBUF_GND_13(.I(1'b0),.O(gnd_pins_13));
OBUF i_OBUF_GND_14(.I(1'b0),.O(gnd_pins_14));
OBUF i_OBUF_GND_15(.I(1'b0),.O(gnd_pins_15));
OBUF i_OBUF_GND_16(.I(1'b0),.O(gnd_pins_16));

reg 			debug_clkg = 1'b0;

assign clk_out = debug_clkg;

always@(posedge uart_clkg)
   debug_clkg <= ~debug_clkg;

debounce_switch #(.WIDTH(2),.N(4),.RATE(2)) debounce_switch_inst 
   (
   .clk(uart_clkg),
   .rst(1'b0),
   .in({btn0,btn1}),
   .out({btn0_int,btn1_int})
   );
assign reset = btn0_int;

clk_gen u_clk_gen
   (
   .uart_clkg(uart_clkg),
   .ts_clk(ts_clk),
   .sample_clk(sample_clk),
   // Status and control signals
   .reset(reset), 
   .locked(locked),    
   // Clock in ports
   .gclk(GCLK));

//CLKS_PER_BIT =  uart_clkg/baud_rate
uart_rx #(.CLKS_PER_BIT(104)) u_uart_rx
   (/**/
   // Outputs
   .o_RX_DV				(uart_rx_wr_en),
   .o_RX_Byte			(uart_rx_data[7:0]),
   // Inputs
   .i_Clock				(uart_clkg), //12MHz
   .i_RX_Serial			(uart_txd));

uart_tx #(.CLKS_PER_BIT(104)) u_uart_tx
    (/**/
    .i_Clock(uart_clkg), //12MHz
    //.i_TX_DV(1'b1),
    //.i_TX_Byte(8'h41),
    .i_TX_DV(uart_tx_en),
    .i_TX_Byte(uart_tx_byte[7:0]),
    .i_TX_Byte_tready(uart_tx_tready),
    .o_TX_Active(uart_tx_active),
    .o_TX_Serial(uart_rxd),
    .o_TX_Done(uart_tx_done)
    );
    
    
pulse_timestamper u_pulse_0
    (//
    .pulse_i(PIO1),
    .line_id(4'b0000),
    .sample_clk(sample_clk),
    .ts_clk(uart_clkg),
    .ts_strm_clk(uart_clkg),
    .ts_strm_tdata(pulse0_strm_tdata),
    .ts_strm_tvalid(pulse0_strm_tvalid),
    .ts_strm_tready(pulse0_strm_tready),
    .resetn(~reset)
    );
    
    
pulse_timestamper u_pulse_1
    (//
    .pulse_i(PIO2),
    .line_id(4'b0001),
    .sample_clk(sample_clk),
    .ts_clk(uart_clkg),
    .ts_strm_clk(uart_clkg),
    .ts_strm_tdata(pulse1_strm_tdata),
    .ts_strm_tvalid(pulse1_strm_tvalid),
    .ts_strm_tready(pulse1_strm_tready),
    .resetn(~reset)
    );
    
pulse_timestamper u_pulse_2
        (/**/
        .pulse_i(PIO3),
        .line_id(4'b0010),
        .sample_clk(sample_clk),
        .ts_clk(uart_clkg),
        .ts_strm_clk(uart_clkg),
        .ts_strm_tdata(pulse2_strm_tdata),
        .ts_strm_tvalid(pulse2_strm_tvalid),
        .ts_strm_tready(pulse2_strm_tready),
        .resetn(~reset)
        );

pulse_timestamper u_pulse_3
        (/**/
        .pulse_i(PIO4),
        .line_id(4'b0011),
        .sample_clk(sample_clk),
        .ts_clk(uart_clkg),
        .ts_strm_clk(uart_clkg),
        .ts_strm_tdata(pulse3_strm_tdata),
        .ts_strm_tvalid(pulse3_strm_tvalid),
        .ts_strm_tready(pulse3_strm_tready),
        .resetn(~reset)
        );

pulse_timestamper u_pulse_4
        (/**/
        .pulse_i(PIO5),
        .line_id(4'b0100),
        .sample_clk(sample_clk),
        .ts_clk(uart_clkg),
        .ts_strm_clk(uart_clkg),
        .ts_strm_tdata(pulse4_strm_tdata),
        .ts_strm_tvalid(pulse4_strm_tvalid),
        .ts_strm_tready(pulse4_strm_tready),
        .resetn(~reset)
        );

pulse_timestamper u_pulse_5
        (/**/
        .pulse_i(PIO6),
        .line_id(4'b0101),
        .sample_clk(sample_clk),
        .ts_clk(uart_clkg),
        .ts_strm_clk(uart_clkg),
        .ts_strm_tdata(pulse5_strm_tdata),
        .ts_strm_tvalid(pulse5_strm_tvalid),
        .ts_strm_tready(pulse5_strm_tready),
        .resetn(~reset)
        );
        
pulse_timestamper u_pulse_6
        (/**/
        .pulse_i(PIO7),
        .line_id(4'b0110),
        .sample_clk(sample_clk),
        .ts_clk(uart_clkg),
        .ts_strm_clk(uart_clkg),
        .ts_strm_tdata(pulse6_strm_tdata),
        .ts_strm_tvalid(pulse6_strm_tvalid),
        .ts_strm_tready(pulse6_strm_tready),
        .resetn(~reset)
        );

pulse_timestamper u_pulse_7
        (/**/
        .pulse_i(PIO8),
        .line_id(4'b0111),
        .sample_clk(sample_clk),
        .ts_clk(uart_clkg),
        .ts_strm_clk(uart_clkg),
        .ts_strm_tdata(pulse7_strm_tdata),
        .ts_strm_tvalid(pulse7_strm_tvalid),
        .ts_strm_tready(pulse7_strm_tready),
        .resetn(~reset)
        );
pulse_timestamper u_pulse_8
    (//
    .pulse_i(PIO9),
    .line_id(4'b1000),
    .sample_clk(sample_clk),
    .ts_clk(uart_clkg),
    .ts_strm_clk(uart_clkg),
    .ts_strm_tdata(pulse8_strm_tdata),
    .ts_strm_tvalid(pulse8_strm_tvalid),
    .ts_strm_tready(pulse8_strm_tready),
    .resetn(~reset)
    );
    
    
pulse_timestamper u_pulse_9
    (//
    .pulse_i(PIO10),
    .line_id(4'b1001),
    .sample_clk(sample_clk),
    .ts_clk(uart_clkg),
    .ts_strm_clk(uart_clkg),
    .ts_strm_tdata(pulse9_strm_tdata),
    .ts_strm_tvalid(pulse9_strm_tvalid),
    .ts_strm_tready(pulse9_strm_tready),
    .resetn(~reset)
    );
    
pulse_timestamper u_pulse_10
    (/**/
    .pulse_i(PIO11),
    .line_id(4'b1010),
    .sample_clk(sample_clk),
    .ts_clk(uart_clkg),
    .ts_strm_clk(uart_clkg),
    .ts_strm_tdata(pulse10_strm_tdata),
    .ts_strm_tvalid(pulse10_strm_tvalid),
    .ts_strm_tready(pulse10_strm_tready),
    .resetn(~reset)
    );

pulse_timestamper u_pulse_11
    (/**/
    .pulse_i(PIO12),
    .line_id(4'b1011),
    .sample_clk(sample_clk),
    .ts_clk(uart_clkg),
    .ts_strm_clk(uart_clkg),
    .ts_strm_tdata(pulse11_strm_tdata),
    .ts_strm_tvalid(pulse11_strm_tvalid),
    .ts_strm_tready(pulse11_strm_tready),
    .resetn(~reset)
    );

pulse_timestamper u_pulse_12
        (/**/
        .pulse_i(PIO13),
        .line_id(4'b1100),
        .sample_clk(sample_clk),
        .ts_clk(uart_clkg),
        .ts_strm_clk(uart_clkg),
        .ts_strm_tdata(pulse12_strm_tdata),
        .ts_strm_tvalid(pulse12_strm_tvalid),
        .ts_strm_tready(pulse12_strm_tready),
        .resetn(~reset)
        );

pulse_timestamper u_pulse_13
        (/**/
        .pulse_i(PIO14),
        .line_id(4'b1101),
        .sample_clk(sample_clk),
        .ts_clk(uart_clkg),
        .ts_strm_clk(uart_clkg),
        .ts_strm_tdata(pulse13_strm_tdata),
        .ts_strm_tvalid(pulse13_strm_tvalid),
        .ts_strm_tready(pulse13_strm_tready),
        .resetn(~reset)
        );
        
pulse_timestamper u_pulse_14
        (/**/
        .pulse_i(PIO15),
        .line_id(4'b1110),
        .sample_clk(sample_clk),
        .ts_clk(uart_clkg),
        .ts_strm_clk(uart_clkg),
        .ts_strm_tdata(pulse14_strm_tdata),
        .ts_strm_tvalid(pulse14_strm_tvalid),
        .ts_strm_tready(pulse14_strm_tready),
        .resetn(~reset)
        );

pulse_timestamper u_pulse_15
        (/**/
        .pulse_i(PIO16),
        .line_id(4'b1111),
        .sample_clk(sample_clk),
        .ts_clk(uart_clkg),
        .ts_strm_clk(uart_clkg),
        .ts_strm_tdata(pulse15_strm_tdata),
        .ts_strm_tvalid(pulse15_strm_tvalid),
        .ts_strm_tready(pulse15_strm_tready),
        .resetn(~reset)
        );

// Merge using AXI-S combiner

axis_arb_mux #(
    .S_COUNT(16), // number of AXI-S inputs
    .DATA_WIDTH(32),
    .KEEP_ENABLE(0),
    .USER_ENABLE(0),
    .LAST_ENABLE(0),
    .ARB_TYPE_ROUND_ROBIN(0)
    ) mergifier ( //
    .clk(uart_clkg),
    .rst(reset),
    .s_axis_tdata({pulse0_strm_tdata, pulse1_strm_tdata, pulse2_strm_tdata, pulse3_strm_tdata, 
        pulse4_strm_tdata, pulse5_strm_tdata, pulse6_strm_tdata, pulse7_strm_tdata,
        pulse8_strm_tdata, pulse9_strm_tdata, pulse10_strm_tdata, pulse11_strm_tdata,
        pulse12_strm_tdata, pulse13_strm_tdata, pulse14_strm_tdata, pulse15_strm_tdata}),
    .s_axis_tvalid({pulse0_strm_tvalid, pulse1_strm_tvalid, pulse2_strm_tvalid, pulse3_strm_tvalid, 
        pulse4_strm_tvalid, pulse5_strm_tvalid, pulse6_strm_tvalid, pulse7_strm_tvalid,
        pulse8_strm_tvalid, pulse9_strm_tvalid, pulse10_strm_tvalid, pulse11_strm_tvalid,
        pulse12_strm_tvalid, pulse13_strm_tvalid, pulse14_strm_tvalid, pulse15_strm_tvalid}),
    .s_axis_tready({pulse0_strm_tready, pulse1_strm_tready, pulse2_strm_tready, pulse3_strm_tready,
        pulse4_strm_tready, pulse5_strm_tready, pulse6_strm_tready, pulse7_strm_tready,
        pulse8_strm_tready, pulse9_strm_tready, pulse10_strm_tready, pulse11_strm_tready,
        pulse12_strm_tready, pulse13_strm_tready, pulse14_strm_tready, pulse15_strm_tready}),
    .m_axis_tdata(merge_strm_tdata),
    .m_axis_tvalid(merge_strm_tvalid),
    .m_axis_tready(merge_strm_tready)
    );
    

axis_dwidth_converter_0 bytifier
    (/**/
    .aclk(uart_clkg),
    .aresetn(~reset),
    .s_axis_tvalid(merge_strm_tvalid),
    .s_axis_tready(merge_strm_tready),
    .s_axis_tdata(merge_strm_tdata),
    .m_axis_tvalid(uart_tx_en),
    .m_axis_tready(uart_tx_tready),
    //.m_axis_tready(1'b1),
    .m_axis_tdata(uart_tx_byte)
    );

endmodule // CmodA7_ctrl_top
