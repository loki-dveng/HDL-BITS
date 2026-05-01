module top_module (
    input clk,
    input a,
    output [3:0] q );
    always@(posedge clk) begin
        if(a)
            q<=4;
        else if(q==6)begin
            q<=0;
        end
        else
            q<=q+1;
            end   
endmodule
