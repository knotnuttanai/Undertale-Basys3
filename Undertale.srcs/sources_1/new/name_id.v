`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2020 09:49:38 PM
// Design Name: 
// Module Name: name_id
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//      https://github.com/MadLittleMods/FP-V-GA-Text/blob/master/utilities/vhdl-hex-table-output.txt
//      https://github.com/howardlau1999/flapga-mario/blob/master/src/game_over_text.v
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module name_id(
input wire clk,
input wire enable,
output wire [15:0] addr,
output wire [15:0] dina
    );

	reg [7:0] glyph;
	reg [2:0] writing_text;
	reg [2:0] writing_text_next;

    //name_id text(clk, dina, addr, writing_text);
    always @ (posedge clk)
    begin
    if (enable == 0 ) begin
        case (writing_text_next)
            3'b000: glyph <= 8'b01001110; //N
            3'b001: glyph <= 8'b01110101; //u
            3'b010: glyph <= 8'b01110100; //t
            3'b011: glyph <= 8'b01110100; //t
            3'b100: glyph <= 8'b01100001; //a
            3'b101: glyph <= 8'b01101110; //n
            3'b110: glyph <= 8'b01100001; //a
            3'b111: glyph <= 8'b01101001; //i
        endcase
        
        writing_text <= writing_text_next;
                if (writing_text == 7)
                    writing_text_next <= 0;
                else
                    writing_text_next <= writing_text + 1;
                end
   end

    assign dina = {enable, 2'b00, glyph};
    assign addr = writing_text + 55;    

endmodule
