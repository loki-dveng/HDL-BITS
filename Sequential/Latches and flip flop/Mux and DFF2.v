module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
        wire x1,x2;
    assign x1=E?w:Q;
    assign x2=L?R:x1;
    always @(posedge clk) begin
      Q<=x2;
    end

endmodule
