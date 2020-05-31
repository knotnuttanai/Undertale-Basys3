`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.05.2020 15:00:42
// Design Name: 
// Module Name: player_sprite
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


module player_sprite(
    input wire clk,
    input wire[15:0] key,
    input wire[3:0] state,
    input wire[9:0] x,y,
    input wire collision1,collision2,collision3,
    output wire[7:0] dataOut,
    output reg playerSpriteOn,
    output reg[9:0] hp = 9'b111111111
    );
    
    localparam playerWidth = 15;
    localparam playerHeight = 15;
    reg [9:0] x_reg = 305, y_reg = 227;
    reg [19:0] counter = 0;
    reg[9:0] address;
    
    heart_rom heart(address,clk,dataOut);
    
    always @(posedge clk) 
    begin
        if (counter>=350000)
        begin
            counter <= 0;
            if (state==1) begin
                case (key[7:0])
                    8'h1C: 
                    begin
                        if (x_reg > 120 && key[15:8]!=8'hF0) x_reg = x_reg - 1;
                    end
                    8'h23: 
                    begin
                        if (x_reg+playerWidth+1 < 520 && key[15:8]!=8'hF0) x_reg = x_reg + 1;
                    end
                    8'h1B:
                    begin
                        if (y_reg+playerHeight < 380 && key[15:8]!=8'hF0) y_reg = y_reg + 1;
                    end
                    8'h1D: 
                    begin
                        if (y_reg-1 > 100 && key[15:8]!=8'hF0) y_reg = y_reg - 1;
                    end
                endcase    
            end
        end
        else
            counter <= counter+1;
    end
    
    always @(posedge clk)
    begin
        if (collision1)
        begin
            if (hp >= 256)
                hp <= hp - 256;
            else
                hp <= 0;
        end
        if (collision2)
        begin
            if (hp >= 256)
                hp <= hp - 256;
            else
                hp <= 0;
        end
        if (collision3)
        begin
            if (hp >= 256)
                hp <= hp - 256;
            else
                hp <= 0;
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
        if (state==1)
        begin
            if (x==x_reg-1 && y==y_reg)
            begin
                address <= 0;
                playerSpriteOn <= 1;
            end
            if (x>x_reg-1 && x<x_reg+playerWidth && y>y_reg-1 && y<y_reg+playerHeight)
            begin
                address <= address+1;//x-x_reg + (y-y_reg)*playerWidth;
                playerSpriteOn <= 1;
            end
            else 
            begin
                playerSpriteOn <= 0;
            end
        end
    end
    
endmodule
