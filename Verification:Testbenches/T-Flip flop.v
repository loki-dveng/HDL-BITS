module top_module ();
    reg clk;
    reg reset;
    reg t;
    wire q;
    tff dut(clk,reset,t,q);
    always #5 clk=~clk;
    initial begin
        clk=0;reset=1'b1;t=0; 
        @(negedge clk)reset=1'b0;t=1;    
    end
endmodule
