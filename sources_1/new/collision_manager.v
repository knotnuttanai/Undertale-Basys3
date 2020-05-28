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
    input wire[9:0] player_x,player_y,
    input wire[9:0] bullet_x,bullet_y,
    output wire collision

    );
    
    reg collide;
    
    always @(posedge clk)
    begin
        collide = 0;
        if ((player_x-bullet_x)**2 + (player_y-bullet_y)**2 <=225)
        begin
            collide = 1;
        end
    end
    
    assign collision = collide;
    
endmodule
