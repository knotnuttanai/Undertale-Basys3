`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2020 11:31:13
// Design Name: 
// Module Name: monster_hp_sprite
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


module monster_hp_sprite(
    input wire clk,
    input wire[3:0] state,
    input wire[9:0] x,y,
    input wire[9:0] hp,
    output reg hpSpriteOn
    );
    
    always @(posedge clk)
    begin
        if (state==1 || state==2)
        begin
            if (y>415 && y<=425 && x <= hp)
                hpSpriteOn <= 1;
            else
                hpSpriteOn <= 0;
        end
    end
endmodule
