`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.05.2020 20:18:46
// Design Name: 
// Module Name: collision_manager
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


module collision_manager(
    input wire clk,
    input wire playerSpriteOn,
    input wire bulletSpriteOn1,
    input wire bulletSpriteOn2,
    input wire bulletSpriteOn3,
    output wire collision1,
    output wire collision2,
    output wire collision3

    );
    
    reg collide1=0,collide2=0,collide3=0;
    
    always @(posedge clk)
    begin
        if (playerSpriteOn && bulletSpriteOn1)
            collide1 = 1;
        else
            collide1 = 0;
        if (playerSpriteOn && bulletSpriteOn2)
            collide2 = 1;
        else
            collide2 = 0;
        if (playerSpriteOn && bulletSpriteOn3)
            collide3 = 1;
        else
            collide3 = 0;
        
    end
    
    assign collision1 = collide1;
    assign collision2 = collide2;
    assign collision3 = collide3;
    
    
endmodule
