`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2020 18:55:44
// Design Name: 
// Module Name: monster
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


module monster(
    input wire clk,
    input wire[9:0] damage,
    input wire spacePressed,
    output reg[9:0] hp=9'b111111111
    );
    
    always @(posedge clk)
    begin
        if (spacePressed)
        begin
            if (hp <= damage) hp <= 0;
            else hp <= hp - damage;
        end
    end
endmodule
