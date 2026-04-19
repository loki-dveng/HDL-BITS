module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
wire [31:0] bx; 
wire c;
add16 u0(a[15:0],bx[15:0],sub,sum[15:0],c);
  add16 u1(a[31:16],bx[31:16],c,sum[31:16]);
assign bx = sub ? ~b : b;
endmodule
