module top_module (
    input clk,
    input j,
    input k,
    output reg Q); 
    wire d;
    assign d=(j&~Q)|(~k&Q);
    always@(posedge clk)
        Q<=d;
endmodule
