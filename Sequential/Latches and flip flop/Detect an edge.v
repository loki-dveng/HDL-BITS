module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg [7:0]inp;
    integer i;
    always@(posedge clk)
begin
    inp<=in;
    for(i=0;i<8;i=i+1)
begin
    if(!inp[i]&&in[i])
            pedge[i]<=1;
        else
            pedge[i]<=0;
end
end
endmodule
