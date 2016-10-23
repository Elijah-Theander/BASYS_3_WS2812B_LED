/*
Authored by Elijah Theander
October 20,2016
shiftRegister.v
This shift register will hold 96 bits,
4 instances of 24 bits for GRB diodes.
Upon recieving notice of one bit's generation completing 
it will rotate left, eventually going through all bits.
*/

module shiftRegister(registerBit,loadRegister,loadValue,genDone,clk,reset);

	output registerBit;			//output bit going to controller
	input loadRegister;			//control input guiding loading
	input [95:0] loadValue;		//value to be loaded in upon loadRegister going high
	input genDone;				//using this to dictate rotation
	input clk,reset;			//synchronous clock and reset.

	reg [95:0] S,nS;			//state memory variable, also the register.
	
	parameter DEFAULT = 96'h0F0F0F_0F0F0F_0F0F0F_0F0F0F;
	
	//State Memory.
	always @(posedge clk)begin
		if(reset)begin
			S <= DEFAULT;
		end
		else begin
			S <= nS;
		end
	end
	
	//Next state block
	always @(S,loadRegister,loadValue,genDone)begin
		case({loadRegister,genDone})
			2'b00:	nS = S;
			2'b01:	nS = {S[94:0],S[95]};//rotate left everytime a bit is generated.
			2'b10:	nS = loadValue;
			2'b11:	nS = loadValue;//giving loadRegister precedence.
		endcase
	end
	
	assign registerBit = S[95];
	
endmodule