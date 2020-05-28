`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.05.2020 17:23:10
// Design Name: 
// Module Name: top
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


module top(
    input wire clk,
    input PS2Data,
    input PS2Clk,
    output wire hsync,vsync,
    output wire [11:0] rgb
    );

    wire[15:0] keycode;
    keyboard keyboard(clk,PS2Data,PS2Clk,keycode);

    wire pClk;
    wire[9:0] x,y;
    wire[1:0] state;
    wire collision;
    wire borderSpriteOn;
    wire[8:0] leftBorder,rightBorder,topBorder,bottomBorder;

    border_sprite border(pClk,x,y,state,borderSpriteOn,leftBorder,rightBorder,topBorder,bottomBorder);

    wire playerSpriteOn;
    wire player_x,player_y;
    wire[1:0] hp;
    player_sprite player(pClk,keycode,state,x,y,collision,playerSpriteOn,player_x,player_y,hp);

    wire bulletSpriteOn;
    wire bullet_x,bullet_y;
    bullet_sprite bullet(pClk,state,x,y,leftBorder,rightBorder,topBorder,bottomBorder,bulletSpriteOn,bullet_x,bullet_y);

    wire p_tick;
    reg[11:0] rgb_reg,rgb_next;
    always @(posedge pClk)
    begin
        if (borderSpriteOn)
            rgb_next = 12'hFFF;
        else if (playerSpriteOn)
            rgb_next = 12'hE10;
        else if (bulletSpriteOn)
            rgb_next = 12'hED0;

        if (p_tick)
            rgb_reg = rgb_next;
    end

    assign rgb = rgb_reg;


endmodule
