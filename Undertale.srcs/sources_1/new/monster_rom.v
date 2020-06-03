`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2020 11:06:29 PM
// Design Name: 
// Module Name: monster_rom
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module monster_rom(
    input wire [9:0] addr, 
    input wire clk,
    output reg [7:0] data 
    );
    
    (*ROM_STYLE="block"*) reg [7:0] memory_array [0:900]; //30x24
    // name tag
    //(*ROM_STYLE="block"*) reg [7:0] memory_array [0:5000]; //280 * 15
    initial begin
            $readmemh("monster.mem", memory_array);
    end

    always @ (posedge clk)
            data <= memory_array[addr];    
endmodule
