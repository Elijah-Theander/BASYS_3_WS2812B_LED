/*
Authored by Elijah Theander
October 14, 2016
retCounter.v
This counter calculates the timing needed to 
reach the RET condition for beginning a send to the 
WSB GRB Diodes I'm using. The RET condition is x > 50 uS.
I am calculating at 60 uS to really ensure RET is reached.
This is based off of the 100 MHz clock on the BASYS 3 board.
(1/60uS)=16.666.7 Hz, 100 MHz/ 16,666.7 = 6000 counts of 100MHz clk.
13 bits needed.
*/

module retCounter(retDone,en,clk,reset);

	output retDone;  //Goes high at 60 uS.
	input  en;       //enable signal from top controller.
	input  clk,reset;//synchronous clock and reset.
	
	reg [12:0] S;    //State memory variable.
	
	//State Memory
	always @(posedge clk)begin
		if(reset)begin
			S <= 13'd0;
		end
		else if(en)begin
			S <= (S<13'd6001)? S+1:13'd0;
		end
		else begin
			S <= 13'd0;
		end
	end
	
	//Moore output assignment of retDone.
	assign retDone = (S==13'd6000);
endmodule