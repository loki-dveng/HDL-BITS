module top_module (input x, input y, output z);
  wire w;
    assign w=x^y;
    assign z=w&x;
endmodule
