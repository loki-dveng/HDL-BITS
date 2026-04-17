module top_module (input x, input y, output z);
 wire w1,w2;
    assign w1=x^y;
    assign w2=w1&x;
    assign z=~(w1^w2);

endmodule
