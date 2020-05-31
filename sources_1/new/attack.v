`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2020 18:17:36
// Design Name: 
// Module Name: attack
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


module attack(
    input wire clk,
    input wire [9:0] x,y,
    input wire [3:0] state,
    input wire[15:0] key,
    output reg spacePressed=0,
    output reg attackSpriteOn=0,
    output reg [9:0] damage=0  
    );
    
//    reg [9:0] x_stay_target = 150, y_stay_terget = 300; //initial pos of bullet
    reg [1:0] x_dir = 1; //0 is stop, 1 is negative, 2 is positive
    reg [9:0] x_reg = 320;
    localparam x_center = 320;
    
    always @(posedge clk)
    begin
        if (state==2)
        begin
            if (x>=x_reg&&x<x_reg+5 && y>=150&&y<330)
                attackSpriteOn <= 1;
            else
                attackSpriteOn <= 0;
                
            if (x==639&&y==479)
            begin
                if (x_dir == 1)
                begin
                    x_reg = x_reg - 5;
                    if (x_reg<=120) x_dir = 2;
                end
                else if (x_dir==2)
                begin
                    x_reg = x_reg + 5;
                    if (x_reg+5>=520) x_dir = 1;
                end
            end
        end
        else attackSpriteOn <= 0;
    end
    
    always @(posedge clk)
    begin
        if (state==2)
        begin
            if (key[7:0]==8'h29&&key[15:8]!=8'hF0)
            begin
                spacePressed <= 1;
                if (x_reg <= x_center)
                    damage <= x_reg - 120;
                else
                    damage <= 520 - x_reg;
            end
            else
            begin
                damage <= 0;
                spacePressed <= 0;
            end
        end
    end
    
   
    always @(posedge clk)
    begin
        //if ((state == 1 || state == 2) && ((x>110&&x<=120&&y>90&&y<390)||(x>=520&&x<530&&y>90&&y<390)||(x>110&&x<520&&y>90&&y<=100)||(x>110&&x<520&&y>=380&&y<390)))
        if (key[7:0] == 8'h29) 
        begin
            if ((state == 2 && (key[15:8] != 8'hF0))) //&& x>=120 && x <=520))
            begin
            spacePressed <= 1;
            if (x_center - x_reg  <= x )
                damage = (-x_center + x + x_reg);
            else 
                damage = (x_center - x - x_reg) ;
            end
        end
        else spacePressed <= 0;
        
        if ((state == 2 ) && ((x - x_reg)>0&&( x - x_reg)<=5&&y>110&&y<360)) //&& x>=120 && x <=520))
            attackSpriteOn = 1;
        else
            attackSpriteOn = 0;
            
        if (x==639&&y==479)
        begin
           if (x_dir==2'b01) 
            begin
                x_reg <= x_reg - 5;
                if (x_reg-10<= 120) 
                    x_dir <= 2'b10;
                    //x_reg <= x_reg + 5;
            end
            else if (x_dir==2'b10)
            begin
                x_reg <= x_reg + 5;
                if (x_reg+10>= 520) 
                    x_dir <= 2'b01;
                    //x_reg <= x_reg - 5;
            end
        end
    end
endmodule
