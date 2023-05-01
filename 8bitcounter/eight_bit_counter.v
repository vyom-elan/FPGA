`timescale 1ns / 1ps

module eight_bit_counter(
        input clk, reset, output [7:0] count
    );
    reg [7:0] counter_up;
    reg [30:0] clk_counter;
    always@(posedge clk)
    begin
            if(clk_counter == 50000000)
            clk_counter <=0;
         else
            clk_counter <= clk_counter +1'b1;
     end
    always@(posedge clk)
        begin
            if(reset)
            counter_up <= 8'b0;
                else if(clk_counter == 50000000)
            counter_up <= counter_up +1;
        end
        assign count = counter_up;
endmodule
