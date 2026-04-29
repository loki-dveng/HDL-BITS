module top_module (
    input clk,
    input reset, 
    output [3:1] ena,
    output [15:0] q);
assign ena[1]=(q[3:0]==4'd9);
    assign ena[2]=(q[7:4]==4'd9)&&ena[1];
    assign ena[3]=(q[11:8]==4'd9)&&ena[2];
    bcd_digit ones(.clk(clk),.reset(reset),.enable(1'b1),.q(q[3:0]));
    bcd_digit tens(.clk(clk),.reset(reset),.enable(ena[1]),.q(q[7:4]));
    bcd_digit huns(.clk(clk),.reset(reset),.enable(ena[2]),.q(q[11:8]));
    bcd_digit thou(.clk(clk),.reset(reset),.enable(ena[3]),.q(q[15:12]));
endmodule
    module bcd_digit(
    input clk,
    input reset,
    input enable,
    output reg[3:0]q);
    always@(posedge clk) begin
        if(reset) begin
            q<=4'd0;
        end 
        else if(enable) begin
            if(q==4'd9) begin
                q<=4'd0;
            end
            else begin
                q<=q+1'b1;
            end
        end
    end
    endmodule
