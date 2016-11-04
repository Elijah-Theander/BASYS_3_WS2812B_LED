/*
Authored by Elijah Theander
October 18, 2016
tb_retcounter.v
Test bench to verify retcounter
running at a 100MHz clock
akin to basys board.
*/

`timescale 1ns/1ns

module tb_retcounter;

	wire retDone;
	reg en;
	reg clk,reset;
	
	//Module under test
	retCounter mut(.retDone(retDone),.en(en),.clk(clk),.reset(reset));
	
	//#100 MHz clk
	always begin
		#5 clk = !clk; //100Mhz clock.
	end
	
	//Begin Testing Stimulus
	initial begin 
		$dumpfile("ret.vcd");
		$dumpvars(0,tb_retcounter);
			{en,clk,reset} = 3'b101;  #10
			reset = 1'b0;             #70_000 // This should let it run through the 
											  // ret condition once.
		$finish;
	end
	
endmodule