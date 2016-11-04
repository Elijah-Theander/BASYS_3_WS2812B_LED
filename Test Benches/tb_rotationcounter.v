/*
Authored by Elijah Theander
October 28, 2016
tb_rotationcounter.v
Test bench verifying results of rotationCounter.
*/

`timescale 1ns/1ns

module tb_rotationcounter;

	wire sendDone;
	reg genDone;
	reg clk,reset;
	
	//Module under test
	rotationCounter mut(sendDone,genDone,clk,reset);
	
	//100 MHz clk
	always begin
		#5 clk = !clk;
	end
	
	
	//Begin testing stimulus
	initial begin
		$dumpfile("countrot.vcd");
		$dumpvars(0,tb_rotationcounter);
			{clk,reset,genDone} = 3'b011; #20
			reset = 0;                    #2000
			//Should see all counts
		$finish;
	end	
	
endmodule