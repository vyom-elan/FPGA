`timescale 1ns / 1ps
module AquariumController(input [2:0] temperature_sensor,
    					  input [2:0] humidity_sensor,
    					  input [1:0]waterlvl_sensor,
                          input clk,
    					  output reg pump_control_hot,
                          output reg pump_control_cold);
  	reg [30:0]clkcounter;
  	reg [2:0] temperature;
  	reg [2:0] humidity;
  	reg [2:0] set_temperature;
  	reg [2:0] set_humidity;
    reg [1:0]water_level_ok;
    reg pump_on;
    always @(posedge clk && clkcounter==50000000) 
    begin
        temperature <= temperature_sensor;
        humidity <= humidity_sensor;
        if (temperature < set_temperature && humidity > set_humidity && water_level_ok!=waterlvl_sensor) 
        begin
             pump_control_hot <= 1'b1;
             pump_control_cold <= 1'b0;
        end 
        else if (temperature > set_temperature && humidity < set_humidity && water_level_ok==waterlvl_sensor) 
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
endmodule
