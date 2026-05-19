module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); 
wire clk= KEY[0];
    wire E = KEY[1];
    wire L = KEY[2];
    wire w = KEY[3];
    MUXDFF stage3(.clk(clk),.w(w),.R(SW[3]),.E(E),.L(L),.Q(LEDR[3]));
    MUXDFF stage2(.clk(clk),.w(LEDR[3]),.R(SW[2]),.E(E),.L(L),.Q(LEDR[2]));
    MUXDFF stage1(.clk(clk),.w(LEDR[2]),.R(SW[1]),.E(E),.L(L),.Q(LEDR[1]));
    MUXDFF stage0(.clk(clk),.w(LEDR[1]),.R(SW[0]),.E(E),.L(L),.Q(LEDR[0]));
endmodule
module MUXDFF (
    input clk,
    input w, 
    input R, 
    input E, 
    input L,
    output reg Q
);
    wire mux1_out,mux2_out;
    assign mux1_out=E?w:Q;
    assign mux2_out=L?R:mux1_out;
    always @(posedge clk) begin
        Q <= mux2_out;
    end
endmodule
