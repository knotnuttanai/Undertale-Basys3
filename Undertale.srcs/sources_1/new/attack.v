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
    
    reg [1:0] x_dir = 1; 
    reg [9:0] x_reg = 320;
    localparam x_center = 320;
    
    always @(posedge clk)
    begin
        if (state==2)
        begin
            if (x>=x_reg&&x<x_reg+5 && y>=150&&y<330)
                attackSpriteOn <= 1;
            else if (x>=315&&x<325 && y>=350&&y<360)
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
    reg [19:0] counter = 0;
    always @(posedge clk)
    begin
        
        if (state==2 && counter > 350000)
        begin
            counter <= 0;
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
        end else
        begin
            counter <= counter + 1;
            damage <= 0;
            spacePressed <= 0;
        end
    end
endmodule