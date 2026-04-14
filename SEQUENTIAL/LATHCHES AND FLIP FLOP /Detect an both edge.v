module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
      reg [7:0]inp;
    integer i;
    always@(posedge clk)
begin
    inp<=in;
    for(i=0;i<8;i=i+1)
begin
    if((!inp[i]&&in[i])||(inp[i]&&!in[i]))
            anyedge[i]<=1;
        else
            anyedge[i]<=0;
end
end

endmodule
