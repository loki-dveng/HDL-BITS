module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );
wire [1023:0] temp;
assign temp = in>>(sel*4);
assign out  = temp[3:0];
endmodule
