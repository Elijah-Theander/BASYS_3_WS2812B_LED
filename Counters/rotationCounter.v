/*
Authored by Elijah Theander
October 23, 2016
rotationCounter.v
96 bit counter that increments everytime a count is done
and a rotation of the register happens.
*/

module rotationCounter(sendDone,genDone,clk,reset);

	output sendDone;	//output saying the full send is complete
	input genDone;		//input saying  increment count.
	input clk,reset;	//synchronous clock and reset.
	
	reg [6:0] S,nS;		//State memory variable.
	
	//State Memory.
	always @(posedge clk)begin
		if(reset)begin
			S <= 7'd0;
		end
		else begin
			S <= nS;
		end
	end
	
	//Next State
	always @(S,genDone)begin
		if(S < 7'd97)begin
			nS = genDone? S+1:S;
		end
		else begin
			nS = 0;
		end
	end
	
	assign sendDone = (S==96);
		
endmodule