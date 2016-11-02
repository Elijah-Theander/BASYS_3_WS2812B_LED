/*
Authored by Elijah Theander
October 28, 2016
weeWoo.v
This module takes a tenHzDiv input and uses it to swap 
the leading color of a register.
*/

module weeWoo(rbSwap,tenHzIn,clk,reset);
	output [95:0] rbSwap;//output of register
	
	input         tenHzIn;
	input         clk,reset;
	
	//State Variables;
	reg           S;
	wire          nS;
	
	//register parameters
	parameter redfirst  = 96'h00F000_0000F0_00F000_0000F0;
	parameter bluefirst = 96'h0000F0_00F000_0000F0_00F000;
	
	//State Memory
	always @(posedge clk)begin
		if(reset)begin
			S <= 1'b0;
		end
		else begin
			S <= nS;
		end
	end
	
	//Next state based on tenHzIn.
	assign nS = (tenHzIn)? !S:S;
	
	//rbSwap out.
	assign rbSwap = S? redfirst:bluefirst;
	
endmodule