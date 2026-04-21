module top_module( 
    input a, b, sel,
    output out ); 
    always@(*)begin
        out=sel?b:a;
    end
endmodule
