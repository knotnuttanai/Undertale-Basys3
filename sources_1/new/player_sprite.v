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
//    output wire[7:0] dataOut,
    output reg playerSpriteOn,
    output wire[9:0] cx,cy,
    output reg[1:0] hp = 2'b11
    );
    
    reg [9:0] x_reg = 320, y_reg = 240;
    
    always @(posedge clk) 
    begin
        if (state==1) begin
            case (key)
                2'b00: x_reg = x_reg - 5;
                2'b01: x_reg = x_reg + 5;
                2'b10: y_reg = y_reg + 5;
                2'b11: y_reg = y_reg - 5;
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
    
    //player as a circle
    always @(posedge clk)
    begin 
        if (state == 1 && (x-x_reg)**2 + (y-y_reg)**2 <= 400) 
        begin 
            playerSpriteOn = 1;
        end else
        begin
            playerSpriteOn = 0;
        end
    end
    
    assign cx = x_reg;
    assign cy = y_reg;
             
endmodule
