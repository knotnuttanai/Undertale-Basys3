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
    input wire[3:0] state,
    input wire[9:0] x,y,
    input wire spacePressed,
    output wire[7:0] dataOut,
    output reg[9:0] hp=9'b111111111,
    output reg monsterSpriteOn
    );
    localparam playerWidth = 30;
    localparam playerHeight = 30;
    reg [9:0] x_reg = 300, y_reg = 110;
    reg[9:0] address;
    monster_rom monster(address,clk,dataOut);
    
    always @(posedge clk)
    begin
        if (spacePressed)
        begin
            if (hp <= damage) hp <= 0;
            else hp <= hp - damage;
        end
    end
    
    always @(posedge clk)
    begin 
//        if (state == 1 && x>=x_reg && x<x_reg+playerWidth && y>=y_reg && y<y_reg+playerHeight) 
//        begin 
//            playerSpriteOn = 1;
//        end else
//        begin
//            playerSpriteOn = 0;
//        end
        if (state==2)
        begin
            if (x==x_reg-1 && y==y_reg)
            begin
                address <= 0;
                monsterSpriteOn <= 1;
            end
            if (x>x_reg-1 && x<x_reg+playerWidth && y>y_reg-1 && y<y_reg+playerHeight)
            begin
                address <= address+1;//x-x_reg + (y-y_reg)*playerWidth;
                monsterSpriteOn <= 1;
            end
            else 
            begin
                monsterSpriteOn <= 0;
            end
        end
    end
endmodule
