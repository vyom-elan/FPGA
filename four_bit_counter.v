`timescale 1ns / 1ps

module four_bit_counter(
        input clk, reset, input increment, input decrement, output reg [3:0] count
    );
    reg enable;
    reg [3:0] mux_out;
    wire incr_out;
    wire decr_out;
   
    debounce incr_db(
        .clk(clk),
        .reset(reset),
        .in(increment),
        .out(incr_out)
      );
     debounce decr_db(
            .clk(clk),
            .reset(reset),
            .in(decrement),
            .out(decr_out)
     );
    always@(*)
        enable = incr_out | decr_out;
    always@(*)
    begin
        case(incr_out)
        1'b0: mux_out = count - 1;
        1'b1: mux_out = count + 1;
        endcase
     end
     
     always@(posedge clk)
        if(reset)
            count <= #1 0;
        else if(enable)
            count <= #1 mux_out;
 endmodule
 
 module debounce(
               input clk,
               input reset,
               input in,
               output out
);
parameter MAX_VALUE = 100000000;
reg count_en , clr;
reg [31:0] count;
always@(posedge clk)
    if(reset || clr)
        count_en <= 0;
    else if(in)
        count_en <= 1;
 always@(posedge clk)
     if(reset || clr)
        count <= 0;
    else if(in)
        count <= count + 1;
 always@* clr = count == MAX_VALUE;
 assign out = clr;
 endmodule
