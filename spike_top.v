`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/17/2022 09:33:21 PM
// Design Name: 
// Module Name: spike_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module spike_top(
    input   wire    sysclk,
    input   wire    btn0,
    input   wire    btn1,
//    input   wire    uart_txd_in,

    output  wire    uart_rxd_out,
    output  reg     led0,
    output  reg     led1
    );

//CLKS_PER_BIT =  uart_clkg/baud_rate

reg         uart_tx_en = 1'b1;
reg [7:0]   uart_tx_byte = 8'b10101010;

wire uart_clk;
wire uart_tx_active;
wire uart_tx_done;
wire uart_tx_tready;
wire reset;

assign uart_clk = sysclk;
assign reset = btn0_int;

debounce_switch #(.WIDTH(2),.N(4),.RATE(125000)) debounce_switch_inst 
   (
   .clk(sysclk),
   .rst(1'b0),
   .in({btn0, btn1}),
   .out({btn0_int, btn1_int})
   );
assign reset = btn0_int;
  
uart_tx #(.CLKS_PER_BIT(104)) u_uart_tx
    (/**/
    .i_Clock(uart_clk), //12MHz
    .i_TX_DV(uart_tx_en),     //enable 
    .i_TX_Byte(uart_tx_byte[7:0]),
    .i_TX_Byte_tready(uart_tx_tready),  // this is actually an output, uart ready to tx a byte
    .o_TX_Active(uart_tx_active),
    .o_TX_Serial(uart_rxd_out),
    .o_TX_Done(uart_tx_done)
    );
    
    
always @(posedge sysclk) begin
    if (reset) begin
        uart_tx_en <= 1'b0;
    end else begin
        if (uart_tx_done == 1'b1) begin
            uart_tx_en <= 1'b0;
        end
        if (btn1_int) begin // 
            uart_tx_en <= 1'b1;
        end
        
        led0 <= uart_tx_active;
        led1 <= uart_tx_tready;
    end
    
end
    
        
  
    
endmodule
