`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2020 10:18:13 PM
// Design Name: 
// Module Name: heart_rom
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


module heart_rom(
    input wire [9:0] addr, 
    input wire clk,
    output reg [7:0] data 
    );
    
    (*ROM_STYLE="block"*) reg [7:0] memory_array [0:836]; 
    
    initial begin
            $readmemh("heart15.mem", memory_array);
    end

    always @ (posedge clk)
            data <= memory_array[addr];     
    
endmodule
