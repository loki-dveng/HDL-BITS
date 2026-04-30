module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    reg[2:0]count;
    always @(posedge clk)begin
        if(reset)
            count<=2'b0;
        else begin
            if(count==4)
                count<=count;
            else
                count<=count+1;
        end
    end
    assign shift_ena=(count<=3);
endmodule
