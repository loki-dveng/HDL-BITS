module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 
    wire feedback;
    assign feedback=q[0];
    always@(posedge clk) begin
        if(reset)
            q<=32'h1;
        else begin
            q[31]<=feedback;
            q[30:22]<=q[31:23];
            q[21]<=q[22]^feedback;
            q[20:3]<=q[21:4];
            q[2]<=q[3];
            q[1]<=q[2]^feedback;
            q[0]<=q[1]^feedback;
        end
    end
endmodule
