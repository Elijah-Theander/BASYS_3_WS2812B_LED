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
For a Gen 2 signal it will be Low for 700 nS, high 500.
*/

module bitGenerator(theBit,genDone,genMode,doGen,retDone,clk,reset);
	
	output theBit;		 //output bit going to the LED strip.
	output genDone;		 //output signal saying the generation of one bit is finished.
	input [1:0] genMode; //input from controller saying what to generate currently.
	input doGen;		 //input from controller saying when to generate bit.
	input retDone;	 	 //input from retCounter saying RET has been reached
	input clk,reset;	 //synchronous clock and reset.
	
	reg [6:0] S;		 //State memory variable.
	
	//State Memory.
	always @(posedge clk)begin
		if(reset)begin
			S <= 7'd0;
		end
		else if(doGen)begin
			S <= (S < 121)? S+1:7'd0;
		end
		else begin
			S <= 7'd0;
		end
	end
	