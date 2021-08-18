`default_nettype none
`timescale 1ns/1ns
module clk_divider (
    input clk, rst,
    output reg clk_div_out
    );

	
parameter terminalcount = (3);
parameter counter_width = 16;
reg [counter_width-1:0] count;
wire tc;

assign tc = (count == terminalcount);	// Place a comparator on the counter output

always @ (posedge(clk), posedge(rst))
begin
    if (rst) count <= 0;
    else if (tc) count <= 0;		// Reset counter when terminal count reached
    else count <= count + 1;
end

always @ (posedge(clk), posedge(rst))
begin
    if (rst) clk_div_out <= 0;
    else if (tc) clk_div_out = !clk_div_out;	// T-FF with tc as input signal
end
endmodule
