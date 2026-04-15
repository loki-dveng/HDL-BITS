module top_module ( );
    reg clk;
    dut uut(.clk(clk));
    initial begin
        clk=0;
    end
    always #5clk=~clk;
endmodule
