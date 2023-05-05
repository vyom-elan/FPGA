`timescale 1ns / 1ps
module eight_bit_counter(
        input clk, reset_btn,
        input [7:0]load_value,
        input preset_btn,
        output [7:0] count
);
    reg [7:0] counter_up;
    reg [30:0] clk_counter;
    always@(posedge clk)
    begin
        if(clk_counter == 100000000)
            clk_counter <=0;
         else
            clk_counter <= clk_counter +1'b1;
     end
    always@(posedge clk)
        begin
            if(reset_btn)
                counter_up <= 8'b0;
            else if(preset_btn)
                counter_up <= load_value;
            else if(clk_counter == 100000000)
                counter_up <= counter_up +1;
        end
        assign count = counter_up;
endmodule
