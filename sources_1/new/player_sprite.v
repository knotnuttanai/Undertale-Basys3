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
    input wire[1:0] state,
    input wire[9:0] x,y,
    input wire collision,
    input wire[8:0] leftBorder,rightBorder,topBorder,bottomBorder,
    output wire[7:0] dataOut,
    output reg playerSpriteOn,
    output reg[1:0] hp = 2'b11
    );
    
    localparam playerWidth = 31;
    localparam playerHeight = 27;
    reg [9:0] x_reg = 305, y_reg = 227;
    
    reg[9:0] address;
    
    heart_rom heart(address,clk,dataOut);
    
    always @(posedge clk) 
    begin
        if (state==1) begin
            case (key)
                2'b00: 
                begin
                    if (x_reg-5 > leftBorder) x_reg = x_reg - 5;
                end
                2'b01: 
                begin
                    if (x_reg+5 < rightBorder) x_reg = x_reg + 5;
                end
                2'b10:
                begin
                    if (y_reg-5 > topBorder) y_reg = y_reg + 5;
                end
                2'b11: 
                begin
                    if (y_reg+5 > bottomBorder) y_reg = y_reg - 5;
                end
            endcase    
        end
    end
    
    always @(posedge clk)
    begin
        if (collision)
        begin
            hp = hp - 1;
        end
    end
    
    always @(posedge clk)
    begin 
        if (state == 1 && x>=x_reg && x<x_reg+playerWidth && y>=y_reg && y<y_reg+playerHeight) 
        begin 
            playerSpriteOn = 1;
        end else
        begin
            playerSpriteOn = 0;
        end
    end
    
endmodule
