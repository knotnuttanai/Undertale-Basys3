`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2020 20:14:00
// Design Name: 
// Module Name: bulletTest
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


module bulletTest();
    reg clk;
    reg[1:0] state;
    reg[9:0] x,y;
    reg[8:0] leftBorder=120,rightBorder=520,topBorder=100,bottomBorder=380;
//    output wire[7:0] dataOut,
    wire bulletSpriteOn;
    
    bullet_sprite bullet(clk,state,x,y,leftBorder,rightBorder,topBorder,bottomBorder,bulletSpriteOn);
    
    always
        #5 
        clk=~clk;
    initial
    begin
        #0
        state = 2'b00;
        clk=0;
        x = 0;
        y = 0;
        #5
        state = 2'b01;
        x = 127;
        y = 342;
        #5
        x = 132;
//        #100
//        state = 4;
//        direction = 5'b01000;
//        #100
//        state = 3;
//        #100
//        direction = 5'b10000;
        #100
        //…...
        $finish;
    end
    
    
endmodule
