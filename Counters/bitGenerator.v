/*
Authored by Elijah Theander
October 14, 2016
bitGenerator.v
The WSB Diodes require a signal of 1100-1300 nS
to pick up a single bit, it looks at the period of 
transmission and cuts it in half and takes the value at
the half mark as the input. Need 24 inputs per LED.
I am using a Value of 1200 nS, so right in the middle.
Using 100 MHz clk from BASYS 3, 120 counts from it is needed
for 1200 nS.
For a Gen 1 signal it will be High for 700 nS, low 500
For a Gen 0 signal it will be Low for 700 nS, high 500.
*/

module bitGenerator(theBit,genDone,genMode,doGen,clk,reset);
	
	output theBit;		 //Output bit going to the LED strip.
	output genDone;		 //Output signal saying the generation of one bit is finished.
	input [1:0] genMode; //Input from controller saying what to generate currently.
	input doGen;		 //Input from controller saying when to generate bit.
	input clk,reset;	 //Synchronous clock and reset.
	
	reg [6:0] S;		 //State memory variable.
	reg theBit;
	
	//Parameters for genMode.
	parameter   genZero = 2'b10, genOne = 2'b11, genRet = 2'b00, genNone = 2'b01;
	
	//State Memory.
	always @(posedge clk)begin
		if(reset)begin
			S <= 7'd0;
		end
		else if(doGen)begin
			S <= (S < 7'd121)? S+1:7'd0;
		end
		else begin
			S <= 7'd0;
		end
	end
	
	//theBit assignment
	always @(genMode,S)begin
		case(genMode)
			genZero: theBit = (S < 7'd51)? 1:0; // generate high for 50, then low 70, half mark is low
			genOne:  theBit = (S < 7'd71)? 1:0; // generate high for 70 then, low 50, half mark is high
			genRet:	 theBit = 1'b0;        // not concerned with ret timing here, will come from controller. 
			genNone: theBit = 1'b0;
			default: theBit = 1'b0;
		endcase
	end
	
	//genDone assignment
	assign genDone = (S == 7'd120);
	
endmodule