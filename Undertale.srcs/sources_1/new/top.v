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
    // New add show text
    
    wire[15:0] keycode;
    keyboard keyboard(clk,PS2Data,PS2Clk,keycode);
    
    wire pClk;
    wire[9:0] x,y;
    wire[3:0] state;
    reg[3:0] nextState=4'b0000;
    wire collision1;
    wire collision2;
    wire collision3;
    wire borderSpriteOn;
    wire p_tick;
    wire[8:0] leftBorder,rightBorder,topBorder,bottomBorder;
    
    vgaController vga(clk,btnC,Hsync,Vsync,x,y,p_tick,pClk);
    
//    state_manager state(pClk,state);
    
    border_sprite border(clk,x,y,state,borderSpriteOn);
    wire spacePressed;
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
    monster_hp_sprite(pClk,state,x,y,monsterHp,monsterHpSpriteOn)   ;

    collision_manager collision_detector(pClk,playerSpriteOn,
    bulletSpriteOn1,bulletSpriteOn2,bulletSpriteOn3,
    collision1,collision2,collision3);
    
    wire[7:0] monster_rgb;
    monster monster(pClk,damage,state,x,y,spacePressed,monster_rgb,monsterHp,monsterSpriteOn);
    
    wire attackSpriteOn;
    attack attack(pClk,x,y,state,keycode,spacePressed,attackSpriteOn,damage);
    
    wire startPressed ;
    
    wire knotNameOn;
    wire nutNameOn;
    wire yinNameOn;
    wire timeNameOn;
    wire topNameOn;
    wire PressAltToStart;
//    wire[7:0] dataKnot;
//    wire[7:0] dataTop;
//    wire[7:0] dataYin;
//    wire[7:0] dataNut;
//    wire[7:0] dataTime;
    
    startPage start(pClk,
    state,
    keycode,
    startPressed,
    startOn);
    // In order show in screen 
//    knotName knot(pClk,state,x,y,dataKnot,knotNameOn); // x = 50 , y = 100
//    nutName nut(pClk,state,x,y,dataNut,nutNameOn);// x = 50 , y = 150
//    yinName yin(pClk,state,x,y,dataYin,yinNameOn);// x = 50 , y = 200
//    topName top(pClk,state,x,y,dataTop,topNameOn);// x = 50 , y = 250
//    timeName Time(pClk,state,x,y,dataTime,timeNameOn);// x = 50 , y = 300
    
    
    reg [7:0] palette [0:143]; // 8 bit values from the 192 hex entries in the colour palette
    reg [7:0] COL = 0; // background colour palete value
    initial begin
        $readmemh("heartpal.mem", palette); // load 192 hex values into "palette"
    end
    
    reg [7:0] beePalette [0:191]; // 8 bit values from the 192 hex entries in the colour palette
    reg [7:0] beeCOL = 0; // background colour palete value
    initial begin
        $readmemh("monsterpal.mem", beePalette); // load 192 hex values into "palette"
    end
    
// name example 
//    reg [7:0] knotPal [0:191]; // 8 bit values from the 192 hex entries in the colour palette
//    initial begin
//        $readmemh("name_pal.mem", knotPal); // load 192 hex values into "palette"
//    end
    Pixel_On_Text2 #(.displayText("Nuttanai Kijviwattanakarn 6030200821")) t1(
                pClk,
                100, // text position.x (top left)
                100, // text position.y (top left)
                x, // current position.x
                y, // current position.y
                knotNameOn  // result, 1 if current pixel is on text, 0 otherwise
            );
    Pixel_On_Text2 #(.displayText("Pimkunut Theerathitayangkul 6031043821")) t2(
                pClk,
                100, // text position.x (top left)
                150, // text position.y (top left)
                x, // current position.x
                y, // current position.y
                nutNameOn  // result, 1 if current pixel is on text, 0 otherwise
            );  
    Pixel_On_Text2 #(.displayText("Boonyawee Kiatsilp 6031034121")) t3(
                pClk,
                100, // text position.x (top left)
                200, // text position.y (top left)
                x, // current position.x
                y, // current position.y
                yinNameOn  // result, 1 if current pixel is on text, 0 otherwise
            );  
    Pixel_On_Text2 #(.displayText("Time Yongyai 6030285121)")) t4(
                pClk,
                100, // text position.x (top left)
                250, // text position.y (top left)
                x, // current position.x
                y, // current position.y
                timeNameOn  // result, 1 if current pixel is on text, 0 otherwise
            );
            
    Pixel_On_Text2 #(.displayText("Waritphon Sriphrom 6031052421")) t5(
                pClk,
                100, // text position.x (top left)
                300, // text position.y (top left)
                x, // current position.x
                y, // current position.y
                topNameOn  // result, 1 if current pixel is on text, 0 otherwise
            );  
            
    Pixel_On_Text2 #(.displayText("Press Alt to start")) t6(
                pClk,
                100, // text position.x (top left)
                400, // text position.y (top left)
                x, // current position.x
                y, // current position.y
                PressAltToStart  // result, 1 if current pixel is on text, 0 otherwise
            );    
//// name example 
//    reg [7:0] knotPal [0:191]; // 8 bit values from the 192 hex entries in the colour palette
//    initial begin
//        $readmemh("name_pal.mem", knotPal); // load 192 hex values into "palette"
//    end   
//// name example 
//    reg [7:0] knotPal [0:191]; // 8 bit values from the 192 hex entries in the colour palette
//    initial begin
//        $readmemh("name_pal.mem", knotPal); // load 192 hex values into "palette"
//    end   
// // name example 
//    reg [7:0] knotPal [0:191]; // 8 bit values from the 192 hex entries in the colour palette
//    initial begin
//        $readmemh("name_pal.mem", knotPal); // load 192 hex values into "palette"
//    end   
    

    
    
    reg[28:0] counter = 0;
    
    always @(posedge pClk)
    begin
        if (state==0)
        begin
            if (startPressed) nextState <= 2;
        end
        if (state==1)
        begin
            if (monsterHp==0) nextState <= 0;
            if (hp == 0) nextState <= 0;
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
            if (monsterHp == 0) nextState <= 0;
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
            if (monsterSpriteOn)
            begin
                vgaRed <= (beePalette[(monster_rgb*3)])>>4;           
                vgaGreen <= (beePalette[(monster_rgb*3)+1])>>4;      
                vgaBlue <= (beePalette[(monster_rgb*3)+2])>>4;     
            end
            else if (attackSpriteOn)
            begin
                vgaRed <= 4'h0;
                vgaGreen <= 4'h9;
                vgaBlue <= 4'hF;
            end
            else if (borderSpriteOn)
            begin
                vgaRed <= 4'hF;
                vgaGreen <= 4'hF;
                vgaBlue <= 4'hF;
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
                vgaRed <= 0;
                vgaGreen <= 0;
                vgaBlue <= 0;
                
            end
        end
        else if(p_tick&&state==0)
        begin
        
            if (knotNameOn) 
            begin
                vgaRed <= 4'hF;
                vgaGreen <= 4'hF;
                vgaBlue <= 4'hF;        
            end 
            else if (nutNameOn) 
            begin
                vgaRed <= 4'hF;     
                vgaGreen <= 4'hF;  
                vgaBlue <= 4'hF;
            end
            else if (yinNameOn)
            begin
                vgaRed <= 4'hF;           
                vgaGreen <= 4'hF;  
                vgaBlue <= 4'hF;
            end 
            else if (timeNameOn)
            begin
                vgaRed <= 4'hF;
                vgaGreen <= 4'hF;     
                vgaBlue <= 4'hF;
            end
            else if (topNameOn)
            begin
                vgaRed <= 4'hF;   
                vgaGreen <= 4'hF;   
                vgaBlue <= 4'hF;
            end
            else if (PressAltToStart)
            begin 
                vgaRed <= 4'hF;   
                vgaGreen <= 4'hF;   
                vgaBlue <= 4'hF;
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
            vgaRed <= (beePalette[(COL*3)])>>4;           
            vgaGreen <= (beePalette[(COL*3)+1])>>4;      
            vgaBlue <= (beePalette[(COL*3)+2])>>4;      
        end
    end
    assign state = nextState;
endmodule