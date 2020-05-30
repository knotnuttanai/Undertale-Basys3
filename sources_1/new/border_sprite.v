`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.05.2020 17:47:04
// Design Name: 
// Module Name: border_sprite
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


module border_sprite(
        input wire clk,
        input wire [9:0] x,y,
        input wire [1:0] state,
        output reg borderSpriteOn=0,
        output reg[8:0] leftBorder=120,rightBorder=520,topBorder=100,bottomBorder=380
    );
    
    always @(posedge clk)
    begin
        if ((state == 1 || state == 2) && ((x>110&&x<=120&&y>90&&y<390)||(x>=520&&x<530&&y>90&&y<390)||(x>110&&x<520&&y>90&&y<=100)||(x>110&&x<520&&y>=380&&y<390)))
            borderSpriteOn = 1;
        else
            borderSpriteOn = 0; 
    end
endmodule
