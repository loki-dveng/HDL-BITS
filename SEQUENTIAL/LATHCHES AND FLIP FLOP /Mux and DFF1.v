module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    wire x1;
    assign x1=L?r_in:q_in;
    always @(posedge clk) begin
      Q<=x1;
    end
endmodule
