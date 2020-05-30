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
    player_sprite player(clk,keycode,state,x,y,collision,leftBorder,rightBorder,topBorder,bottomBorder,playerSpriteOn,player_rgb,hp);
    
    wire bulletSpriteOn;
    wire bullet_x,bullet_y;
    bullet_sprite bullet(clk,state,x,y,leftBorder,rightBorder,topBorder,bottomBorder,bulletSpriteOn,bullet_x,bullet_y);
    
    reg [7:0] palette [0:191]; // 8 bit values from the 192 hex entries in the colour palette
    reg [7:0] COL = 0; // background colour palette value
    initial begin
        $readmemh("pal.mem", palette); // load 192 hex values into "palette"
    end
    
    always @(posedge clk)
    begin
        if (p_tick)
        begin
            if (playerSpriteOn)
            begin
                vgaRed <= (palette[(player_rgb*3)])>>4;
                vgaGreen <= (palette[(player_rgb*3)+1])>>4;
                vgaBlue <= (palette[(player_rgb*3)+2])>>4;
            end
            else if (borderSpriteOn)
            begin
                vgaRed <= 4'hF;
                vgaGreen <= 4'hF;
                vgaBlue <= 4'hF;
            end
            else if (bulletSpriteOn)
            begin
                vgaRed <= 4'hE;
                vgaGreen <= 4'hD;
                vgaBlue <= 4'h0;
            end
            else
            begin
                vgaRed <= (palette[(COL*3)])>>4;           
                vgaGreen <= (palette[(COL*3)+1])>>4;      
                vgaBlue <= (palette[(COL*3)+2])>>4;      
            end
        end
        else
        begin
            vgaRed <= 0;           
            vgaGreen <= 0;      
            vgaBlue <= 0;
        end
    end
    
endmodule
