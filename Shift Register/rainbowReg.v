/*
Authored by Elijah Theander
November 4, 2016
rainbowReg.v
This module takes the clock, reset, and tenHzIn signal and simply
adds one to the value of the register every time tenHzIn goes High.
this reg is split into green red and blue and distributed into a large register.
I am choosing this because If I just let it count through the whole 96 bits it would 
get very, very bright, and I don't exactly feel like searing my retinas off just yet.
*/

module rainbowReg(colorCycle,tenHzIn,clk,reset);
	
	output [95:0] colorCycle;
	
	input         tenHzIn;
	input         clk,reset;
	
	reg    [47:0] S;
	
	always @(posedge clk)begin
		if(reset)begin
			S <= 48'd0;
		end
		else if(tenHzIn)begin
			S <= S+1;
		end
		else begin
			S <= S;
		end
	end
	
	assign colorCycle = {S[47:44],4'h0, S[43:40],4'h0, S[39:36],4'h0,
	                     S[35:32],4'h0, S[31:28],4'h0, S[27:24],4'h0,
						 S[23:20],4'h0, S[19:16],4'h0, S[15:12],4'h0,
						 S[11:8], 4'h0, S[7:4],  4'h0, S[3:0],  4'h0};
						 
endmodule