module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
  wire [100:0] c;
    assign c[0] = cin;
    bcd_fadd u[99:0] (a,b,c[99:0],c[100:1],sum);
    assign cout = c[100];
endmodule
