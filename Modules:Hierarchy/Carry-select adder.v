module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire c;
    wire [15:0] s0,s1;
    add16 u0(a[15:0],b[15:0],1'b0,sum[15:0],c);
add16 u1(a[31:16],b[31:16],1'b0,s0);
add16 u2(a[31:16],b[31:16],1'b1,s1);
assign sum[31:16] = c ? s1 : s0;
endmodule
