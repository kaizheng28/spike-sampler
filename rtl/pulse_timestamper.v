`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/06/2022 02:28:46 PM
// Design Name: 
// Module Name: pulse_timestamper
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


module pulse_timestamper(
    input           pulse_i,
    input  [3:0]    line_id,
    input           ts_clk,
    input           sample_clk,
    input           ts_strm_clk,
    output [31:0]   ts_strm_tdata,
    output          ts_strm_tvalid,
    input           ts_strm_tready,
    
    input           resetn
    );

reg [31:0]  ts_ctr = 32'b0;
reg         ts_pulse = 0;
reg         ts_pulse_last = 1;
reg         ts_pulse_ready = 1'b0;


wire [32:0] ts_ctr_next;
wire [31:0] ts_input;

assign ts_ctr_next = ts_ctr + 1;


reg         pulse_capture = 0;
reg         pulse_rst;

always @(posedge sample_clk)
begin
    if (pulse_rst == 1'b1)
        pulse_capture <= 0;
    else if (pulse_i == 1'b1)
        pulse_capture <= 1;
end

always @ (posedge ts_clk)
begin
    if (resetn == 1'b1) begin
        ts_pulse_last <= ts_pulse;    
        
        if (pulse_capture == 1'b1 && ts_pulse_ready == 1'b1) begin
            ts_pulse <= 1;
            ts_pulse_ready <= 0;
        end
        else begin
            ts_pulse <= 0;
            //pulse_rst <= 0;
        end
        
        if (pulse_capture == 1'b0 && pulse_rst == 1'b0 && ts_pulse == 1'b0) begin
            ts_pulse_ready <= 1;
        end
        
        pulse_rst <= pulse_capture; 
        
        ts_ctr <= ts_ctr_next[31:0];
    end
    else begin
        ts_pulse <= 0;
        ts_pulse_last <= 1;
        //ts_pulse_r1 <= 0;
        //ts_pulse_r2 <= 0;
        //ts_pulse_r4 <= 0;
        pulse_rst <= 1;
        ts_ctr <= 32'b0;
        ts_pulse_ready <= 1'b0;
     end
end

assign ts_input = {line_id, ts_ctr[27:0]};

axis_pulse_ts_fifo pulse_ts_fifo_u (
    .s_axis_tvalid(ts_pulse),
    .s_axis_tdata(ts_input),
    .s_axis_aresetn(resetn),
    .s_axis_aclk(ts_clk),
    .m_axis_aclk(ts_strm_clk),
    .m_axis_tvalid(ts_strm_tvalid),
    .m_axis_tdata(ts_strm_tdata),
    .m_axis_tready(ts_strm_tready)
    );

endmodule
