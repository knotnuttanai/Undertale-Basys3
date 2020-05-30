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
    input wire clk,btnC,
    input PS2Data,
    input PS2Clk,
    output wire Hsync,Vsync,
    output reg [3:0] vgaRed,
    output reg [3:0] vgaGreen,
    output reg [3:0] vgaBlue
    );
    
    wire[15:0] keycode;
    keyboard keyboard(clk,PS2Data,PS2Clk,keycode);
    
//    wire pClk;
    wire[9:0] x,y;
    wire[1:0] state=2'b01;
    wire collision;
    wire borderSpriteOn;
    wire p_tick;
    wire[8:0] leftBorder,rightBorder,topBorder,bottomBorder;
    
    vgaController vga(clk,btnC,Hsync,Vsync,p_tick,x,y);
    
//    state_manager state(pClk,state);
    
    border_sprite border(clk,x,y,state,borderSpriteOn,leftBorder,rightBorder,topBorder,bottomBorder);
    
    wire playerSpriteOn;
    wire[7:0] player_rgb;
    wire[1:0] hp;
    player_sprite player(clk,keycode,state,x,y,collision,playerSpriteOn,player_rgb,hp);
    
    wire bulletSpriteOn;
    wire bullet_x,bullet_y;
    bullet_sprite bullet(clk,state,x,y,leftBorder,rightBorder,topBorder,bottomBorder,bulletSpriteOn,bullet_x,bullet_y);
    
    always @(posedge clk)
    begin
        if (p_tick)
        begin
            if (borderSpriteOn)
            begin
                vgaRed <= 4'hF;
                vgaGreen <= 4'hF;
                vgaBlue <= 4'hF;
            end
            else if (playerSpriteOn)
            begin
                vgaRed <= 4'hE;
                vgaGreen <= 4'h1;
                vgaBlue <= 4'h0;
            end
            else if (bulletSpriteOn)
            begin
                vgaRed <= 4'hE;
                vgaGreen <= 4'hD;
                vgaBlue <= 4'h0;
            end
        end
    end
    
endmodule
