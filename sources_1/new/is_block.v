`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2020 07:18:50 PM
// Design Name: 
// Module Name: is_block
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


module is_block(
    input wire clk,
    input wire[9:0] player_x,player_y,
    input wire[9:0] player_r,
    input wire[9:0] border_x1,border_x2,
    input wire[9:0] border_y1,border_y2,
    output wire is_block,
    output wire block_x,
    output wire block_y
    
    );
     reg block;
     reg direction_x;
     reg direction_y;
     reg threshold;
     
    always @(posedge clk)
    begin
           threshold = 10;
           block = 0;
           direction_x = 0;
           direction_y = 0;
           //right border
           if ((player_x + player_r)-border_x2 >= threshold)
           begin
            block =1;
            direction_x = 1; //block right axis-x
 
           end
           //left border
           if (border_x1 - (player_x - player_r) >= threshold)
           begin
            block =1;
            direction_x = -1;// block left axis-x
 
           end
           if ((player_y + player_r)-border_y2 >= threshold)
           begin
            block =1;
            direction_y = 1;//block up axis-y
 
           end
           if (border_y1 - (player_y - player_r) >= threshold)
           begin
            block =1;
            direction_y = -1;// block down axis-y
 
           end
    
        
    end
     assign is_block = block;
     assign block_x = direction_x;
     assign block_y = direction_y;
    
endmodule
