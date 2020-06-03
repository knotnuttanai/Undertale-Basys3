`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2020 01:13:36 PM
// Design Name: 
// Module Name: startPage
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


module startPage(
    input wire clk,
    input wire[3:0] state,
    input wire[15:0] key,
    output reg spacePressed=0,
    output reg startOn
    );
    
    reg [19:0] counter = 0;
    
    
    always @(posedge clk)
    begin
        
        if (state== 0 && counter > 350000)
        begin
            counter <= 0;
            if (key[7:0]==8'h11&&key[15:8]!=8'hF0)
            begin
                spacePressed <= 1;
            end
            else
            begin   
                spacePressed <= 0;
            end
        end else
        begin
            counter <= counter + 1;
            spacePressed <= 0;
        end
    end
    
    
endmodule
