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
    
    wire pClk;
    wire[9:0] x,y;
    wire[3:0] state;
    reg[3:0] nextState=4'b0001;
    wire collision1;
    wire collision2;
    wire collision3;
    wire borderSpriteOn;
    wire p_tick;
    wire[8:0] leftBorder,rightBorder,topBorder,bottomBorder;
    
    vgaController vga(clk,btnC,Hsync,Vsync,x,y,p_tick,pClk);
    
    border_sprite border(clk,x,y,state,borderSpriteOn);
    wire spacePressed;
    wire startPressed;
    wire playerSpriteOn;
    wire[7:0] player_rgb;
    wire[9:0] hp;
    player_sprite player(pClk,keycode,state,x,y,collision1,collision2,collision3,player_rgb,playerSpriteOn,hp);
    wire bulletSpriteOn1;
    wire bulletSpriteOn2;
    wire bulletSpriteOn3;
    wire bulletSpriteOn4;
    bullet_sprite bullet(pClk,state,x,y,collision1,bulletSpriteOn1);
    bullet_sprite2 bullet2(pClk,state,x,y,collision2,bulletSpriteOn2);
    bullet_sprite3 bullet3(pClk,state,x,y,collision3,bulletSpriteOn3);
    bullet_sprite4 bullet4(pClk,state,x,y,bulletSpriteOn4);

    wire hpSpriteOn;
    wire monsterHpSpriteOn;
    wire[9:0] damage;
    wire[9:0] monsterHp;
    hp_sprite playerHp(pClk,state,x,y,hp,hpSpriteOn);
    monster_hp_sprite(pClk,state,x,y,monsterHp,monsterHpSpriteOn);

    collision_manager collision_detector(pClk,playerSpriteOn,
    bulletSpriteOn1,bulletSpriteOn2,bulletSpriteOn3,
    collision1,collision2,collision3);
    
    monster monster(pClk,damage,spacePressed,monsterHp);
    
    wire attackSpriteOn;
    attack attack(pClk,x,y,state,keycode,spacePressed,attackSpriteOn,damage);
    
    reg [7:0] palette [0:224]; // 8 bit values from the 192 hex entries in the colour palette
    reg [7:0] COL = 0; // background colour palette value
    initial begin
        $readmemh("heart15_pal24bit.mem", palette); // load 192 hex values into "palette"
    end
    reg[28:0] counter = 0;
    
    always @(posedge pClk)
    begin
        if (state==0)
        begin
            if (startPressed) nextState <= 2;
        end
        if (state==1)
        begin
            if (monsterHp==0) nextState <= 3;
            if (hp == 0) nextState <= 3;
            else if (counter >= 350000000)
            begin
                counter <= 0;
                nextState <= 2;
            end
            else 
                counter <= counter + 1;
        end
        
        if (state==2)
        begin
            if (monsterHp == 0) nextState <= 3;
            else if (spacePressed) nextState <= 1;
        end
    end
    
    always @(posedge pClk)
    begin
        if (p_tick && state == 1)
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
            else if (bulletSpriteOn1)
            begin
                vgaRed <= 4'hF;//(palette[(bullet_rgb*3)])>>4;
                vgaGreen <= 4'hF;//(palette[(bullet_rgb*3)+1])>>4;
                vgaBlue <= 4'h0;//(palette[(bullet_rgb*3)+2])>>4;
            end
            else if (bulletSpriteOn2)
            begin
                vgaRed <= 4'hF;//(palette[(bullet_rgb*3)])>>4;
                vgaGreen <= 4'hF;//(palette[(bullet_rgb*3)+1])>>4;
                vgaBlue <= 4'h0;//(palette[(bullet_rgb*3)+2])>>4;
            end
            else if (bulletSpriteOn3)
            begin
                vgaRed <= 4'h0;//(palette[(bullet_rgb*3)])>>4;
                vgaGreen <= 4'hF;//(palette[(bullet_rgb*3)+1])>>4;
                vgaBlue <= 4'h0;//(palette[(bullet_rgb*3)+2])>>4;
            end
            else if (bulletSpriteOn4)
            begin
                vgaRed <= 4'h8;//(palette[(bullet_rgb*3)])>>4;
                vgaGreen <= 4'h8;//(palette[(bullet_rgb*3)+1])>>4;
                vgaBlue <= 4'h8;//(palette[(bullet_rgb*3)+2])>>4;
            end
            else if (hpSpriteOn)
            begin
                vgaRed <= 4'hF;
                vgaGreen <= 4'hF;
                vgaBlue <= 4'h0;
                
            end
             else if (monsterHpSpriteOn)
            begin
                vgaRed <= 4'h0;
                vgaGreen <= 4'hF;
                vgaBlue <= 4'h0;
                
            end
            else
            begin
                vgaRed <= (palette[(COL*3)])>>4;           
                vgaGreen <= (palette[(COL*3)+1])>>4;      
                vgaBlue <= (palette[(COL*3)+2])>>4;      
            end
        end
        else if(p_tick&&state==2)
        begin
            if (attackSpriteOn)
            begin
                vgaRed <= 4'hF;
                vgaGreen <= 4'hF;
                vgaBlue <= 4'hF;
            end
            else if (hpSpriteOn)
            begin
                vgaRed <= 4'h0;
                vgaGreen <= 4'hF;
                vgaBlue <= 4'h0;
                
            end
            else if (monsterHpSpriteOn)
            begin
                vgaRed <= 4'hF;
                vgaGreen <= 4'h0;
                vgaBlue <= 4'h0;
                
            end
            else
            begin
                vgaRed <= 0;
                vgaGreen <= 0;
                vgaBlue <= 0;
                
            end
        end
        else
        begin
            vgaRed <= 0;           
            vgaGreen <= 0;      
            vgaBlue <= 0;
        end
    end
    assign state = nextState;
endmodule
