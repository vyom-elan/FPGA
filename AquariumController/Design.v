`timescale 1ns/1ps
module AquariumController(input [2:0] temperature_sensor,
    					  input [2:0] humidity_sensor,
    					  input waterlvl_sensor,
                          input clk,
                          input [2:0] set_temperature,
  	                      input [2:0] set_humidity,
  	                      input clr,
  	                      input water_level_ok,
    					  output reg pump_control_hot,
                          output reg pump_control_cold);
  reg [30:0]clk_count;
    reg [30:0]clkctr;
  	reg [2:0] temperature;
  	reg [2:0] humidity;

    always @(posedge clk) 
    begin
        clk_count<=49999999;
        temperature <= temperature_sensor;
        humidity <= humidity_sensor;
        if (clr==1'b1) begin
          if (clkctr==clk_count) begin
            clkctr <= 31'd0;
            if (temperature < set_temperature && humidity > set_humidity && water_level_ok!=waterlvl_sensor) 
            begin
                 pump_control_hot <= 1'b1;
                 pump_control_cold <= 1'b0;
            end 
          else if (temperature > set_temperature && humidity < set_humidity && water_level_ok!=waterlvl_sensor) 
            begin
                 pump_control_hot <= 1'b0;
                 pump_control_cold <= 1'b1;
            end 
            else 
            begin
                 pump_control_hot <= 1'b0;
                 pump_control_cold <= 1'b0;
             end
          end
          else
          clkctr <= clkctr + 31'b1;
      end
      else
      begin
        clkctr <= 31'd0;
        pump_control_hot <= 1'b0;
        pump_control_cold <= 1'b0;
      end
    end    
endmodule
