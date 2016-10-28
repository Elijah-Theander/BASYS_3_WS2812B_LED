/*
Authored by Elijah Theander
October 28, 2016
tb_rotationcounter.v
Test bench verifying results of rotationCounter.
*/

module tb_rotationcounter;

	wire sendDone;
	reg genDone;
	reg clk,reset;
	
	//unit under test
	rotationCounter(sendDone,genDone,clk,reset);
	
	//100MHz clk
	always begin
		#5 clk = !clk
	end
	
	
	//begin testing stimulus
	initial begin
		$dumpfile("countrot.vcd");
		$dumpvars(0,tb_rotationcounter);
			{clk,reset,genDone} = 3'b011; #20
			reset = 0;                    #2000//should see all counts
		$finish;
	end	
	
endmodule