`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2020 15:02:46
// Design Name: 
// Module Name: bullet_sprite3
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


module bullet_sprite4(
    input wire clk,
    input wire[3:0] state,
    input wire[9:0] x,y,
    output reg bulletSpriteOn
    );
    reg [9:0] x_reg = 400, y_reg = 250; //initial pos of bullet
    reg [1:0] x_dir = 1, y_dir = 0; //0 is stop, 1 is negative, 2 is positive
    reg [9:0] address;
    reg bulletState = 0;
    localparam bulletWidth = 4;
    localparam bulletHeight = 4;

    monster_rom monster(address,clk,dataOut);

always @(posedge clk)
    begin
        if (state==1 && bulletState==0)
        begin
            if((x-x_reg)**2+(y-y_reg)**2<=16)
            begin
                address <= address+1;
                bulletSpriteOn <= 1;
            end
            else 
            begin
                bulletSpriteOn <= 0;
            end
            if (x==639&&y==479)
            begin
                if (x_dir==2'b01) 
                begin
                    x_reg = x_reg - 5;
                    if (x_reg<=120) x_dir = 2'b10;
                end
                if (x_dir==2'b10)
                begin
                    x_reg = x_reg + 5;
                    if (x_reg+bulletWidth>=520) x_dir = 2'b01;
                end
                case (y_dir)
                    2'b01: 
                    begin
                        y_reg = y_reg - 5;
                        if (y_reg<=100) y_dir = 2'b10;
                    end
                    2'b10:
                    begin
                        y_reg = y_reg + 5;
                        if (y_reg+bulletHeight>=380) y_dir = 2'b01;
                    end
                endcase
            end
        end
        else bulletSpriteOn <= 0;
    end
endmodule