`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Casey Christensen 
// 
// Create Date:    09:31:20 03/30/2015 
// Design Name: 
// Module Name:    WidgetPro 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module WidgetPro(
	input clock,
	output [3:0] anode,
	output [7:0] sseg
					  );

reg [19:0] count = 0;
reg [7:0] count2 = 0;
reg [7:0] letterCount = 0;

reg [1:0] anodeSel = 0;				//Select the anode to display
reg [3:0] anodeSet = 4'b1110;		//Set the anode
reg [7:0] BCD = 0;					//Temporary storage for the segment displays
reg [3:0] seg0 = 0, 
			 seg1 = 0, 
			 seg2 = 0, 
			 seg3 = 0; //The individual sevsegs
reg [3:0] letter = 0;		//Hold the current string letter

assign sseg = BCD;
assign anode = anodeSet;


always @ (anodeSel)
begin
	case (anodeSel)
		2'b00: anodeSet = 4'b1110;
		2'b01: anodeSet = 4'b1101;
		2'b10: anodeSet = 4'b1011;
		2'b11: anodeSet = 4'b0111;
	endcase
end

always @ (posedge clock)
begin
	count = count + 1;
	
	if (count == 100000)
	begin
		count = 0;
		anodeSel = anodeSel + 1;
		count2 = count2 + 1;
	end
	
	if (count2 == 250)
	begin
		letterCount = letterCount + 1;
		count2 = 0;
		
		seg0 = seg1;
		seg1 = seg2;
		seg2 = seg3;
		seg3 = letter;
		
	end
	
	if (letterCount == 17)
		letterCount = 0;
end


always @ (letterCount)
begin
	case (letterCount)
		8'h00: letter = 4'h2; //H
		8'h01: letter = 4'hE; //E
		8'h02: letter = 4'h3; //L
		8'h03: letter = 4'h3; //L
		8'h04: letter = 4'h0; //0
		8'h05: letter = 4'h6; //space
		8'h06: letter = 4'hB; //B
		8'h07: letter = 4'h4; //r
		8'h08: letter = 4'h0; //0
		8'h09: letter = 4'h6; //space
		8'h0A: letter = 4'hF; //F
		8'h0B: letter = 4'h1; //I
		8'h0C: letter = 4'h5; //S
		8'h0D: letter = 4'h2; //H
		8'h0E: letter = 4'hE; //E
		8'h0F: letter = 4'h4; //R
		8'h10: letter = 4'h6; //space
	endcase
end

always @ (anodeSel)	//Set 
begin
	if (anodeSet == 4'b1110)
	begin
		case (seg3)
			4'h0: BCD = (8'b11000000); //0 //O
			4'h1: BCD = (8'b11111001); //1 //I
			4'h2: BCD = (8'b10001001); //H
			4'h3: BCD = (8'b11000111); //L
			4'h4: BCD = (8'b10101111); //r
			4'h5: BCD = (8'b10010010); //5 //S
			4'h6: BCD = (8'b11111111); //space
			4'hA: BCD = (8'b10001000); //A
			4'hB: BCD = (8'b10000011); //b
			4'hC: BCD = (8'b11000110); //C
			4'hD: BCD = (8'b10100001); //d
			4'hE: BCD = (8'b10000110); //E
			4'hF: BCD = (8'b10001110); //F				
			default: BCD = (8'b11111111);
		endcase
	end
	if (anodeSet == 4'b1101)
	begin
		case (seg2)
			4'h0: BCD = (8'b11000000); //0 //O
			4'h1: BCD = (8'b11111001); //1 //I
			4'h2: BCD = (8'b10001001); //H
			4'h3: BCD = (8'b11000111); //L
			4'h4: BCD = (8'b10101111); //r
			4'h5: BCD = (8'b10010010); //5 //S
			4'h6: BCD = (8'b11111111); //space
			4'hA: BCD = (8'b10001000); //A
			4'hB: BCD = (8'b10000011); //b
			4'hC: BCD = (8'b11000110); //C
			4'hD: BCD = (8'b10100001); //d
			4'hE: BCD = (8'b10000110); //E
			4'hF: BCD = (8'b10001110); //F				
			default: BCD = (8'b11111111);
		endcase
	end
	if (anodeSet == 4'b1011)
	begin
		case (seg1)
			4'h0: BCD = (8'b11000000); //0 //O
			4'h1: BCD = (8'b11111001); //1 //I
			4'h2: BCD = (8'b10001001); //H
			4'h3: BCD = (8'b11000111); //L
			4'h4: BCD = (8'b10101111); //r
			4'h5: BCD = (8'b10010010); //5 //S
			4'h6: BCD = (8'b11111111); //space
			4'hA: BCD = (8'b10001000); //A
			4'hB: BCD = (8'b10000011); //b
			4'hC: BCD = (8'b11000110); //C
			4'hD: BCD = (8'b10100001); //d
			4'hE: BCD = (8'b10000110); //E
			4'hF: BCD = (8'b10001110); //F				
			default: BCD = (8'b11111111);
		endcase
	end
	if (anodeSet == 4'b0111)
	begin
		case (seg0)
			4'h0: BCD = (8'b11000000); //0 //O
			4'h1: BCD = (8'b11111001); //1 //I
			4'h2: BCD = (8'b10001001); //H
			4'h3: BCD = (8'b11000111); //L
			4'h4: BCD = (8'b10101111); //r
			4'h5: BCD = (8'b10010010); //5 //S
			4'h6: BCD = (8'b11111111); //space
			4'hA: BCD = (8'b10001000); //A
			4'hB: BCD = (8'b10000011); //b
			4'hC: BCD = (8'b11000110); //C
			4'hD: BCD = (8'b10100001); //d
			4'hE: BCD = (8'b10000110); //E
			4'hF: BCD = (8'b10001110); //F				
			default: BCD = (8'b11111111);
		endcase
	end
end
					

endmodule

