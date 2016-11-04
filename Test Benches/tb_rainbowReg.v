/*
Authored by Elijah Theander
November 4, 2016
tb_rainbowReg.v
Module for verifying function of rainbowReg.v
*/

`timescale 1ns/1ns

module tb_rainbowReg;

	wire [95:0] colorCycle;
	
	reg tenHzIn;
	reg clk,reset;
	
	//Module under test
	rainbowReg mut(colorCycle,tenHzIn,clk,reset);
	
	//100 MHz clk
	always begin
		#5 clk = !clk;
	end
	
	//Generate pulse for tenHzIn, not actually ten Hz in this bench.
	always begin
		#40 tenHzIn = !tenHzIn;
	end
	
	//Begin testing stimulus
	initial begin
		$dumpfile("rainbowReg.vcd");
		$dumpvars(0,tb_rainbowReg);
		{clk,reset,tenHzIn} = 3'b010; #30
		reset = 0;                    #10_000
		//This should show us a substantial amount of counts
		$finish;
	end
	
endmodule