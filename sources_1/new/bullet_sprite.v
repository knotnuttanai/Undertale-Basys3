`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.05.2020 16:07:04
// Design Name: 
// Module Name: bullet_sprite
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


module bullet_sprite(
    input wire clk,
    input wire[1:0] state,
    input wire[9:0] x,y,
    input wire[8:0] leftBorder,rightBorder,topBorder,bottomBorder,
//    output wire[7:0] dataOut,
    output reg bulletSpriteOn,
    output wire[9:0] cx,cy
    );
    reg [9:0] x_reg = 125, y_reg = 340; //initial pos of bullet
    reg [1:0] x_dir = 1, y_dir = 0; //0 is stop, 1 is negative, 2 is positive
    
    always @(posedge clk)
    begin
        if (state==1 && (x-x_reg)**2+(y-y_reg)**2 <= 100)
        begin
            bulletSpriteOn = 1;
            case (x_dir)
                2'b01: x_reg = x_reg - 5;
                2'b10: x_reg = x_reg + 5;
            endcase
            case (y_dir)
                2'b01: y_reg = y_reg - 5;
                2'b10: y_reg = y_reg + 5;
            endcase
            if (x_reg-10 <= leftBorder || x_reg+10 >= rightBorder)
                x_dir = x_dir ^ 2'b00;
            else if (y_reg-10 <= topBorder || y_reg+10 >= bottomBorder)
                y_dir = y_dir ^ 2'b00;
        end else
        begin
            bulletSpriteOn = 0;
        end
    end
    
endmodule
