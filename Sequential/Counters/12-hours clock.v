module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss);
    
    always@(posedge clk)begin
        if(reset)begin
            hh<=8'h12;
            mm<=8'h00;
            ss<=8'h00;
            pm<=1'b0;
        end
        else if(ena)begin
            if(ss==8'h59)begin
                ss<=8'h00;
                if(mm==8'h59)begin
                    mm<=8'h00;
                    if(hh==8'h11)pm<=~pm;
                    if(hh==8'h12)hh<=8'h01;
                    else if(hh[3:0]==4'd9)hh<={hh[7:4]+4'd1,4'd0};
                    else hh<=hh+8'h01;
                end
                else begin
                    if(mm[3:0]==4'd9)mm<={mm[7:4]+4'd1,4'd0};
                    else mm<=mm+8'h01;
                end
            end
            else begin
                if(ss[3:0]==4'd9)ss<={ss[7:4]+4'd1,4'd0};
                else ss<=ss+8'h01;
            end
        end
    end
endmodule
