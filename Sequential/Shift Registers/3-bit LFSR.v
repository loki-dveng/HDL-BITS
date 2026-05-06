module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
    wire L, clk;
    assign L = KEY[1];
    assign clk = KEY[0];
    reg [2:0] q;
    wire d0, d1, d2;
    assign d0=L?SW[0]:q[2];
    assign d1=L?SW[1]:q[0];
    assign d2=L?SW[2]:(q[1]^q[2]);
    always @(posedge clk) begin
        q[0]<=d0;
        q[1]<=d1;
        q[2]<=d2;
    end
    assign LEDR = q;
endmodule
