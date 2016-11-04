/*
Authored by Elijah Theander
October 20, 2016
tb_bitGenerator.v
Testbench for verifying bitGenerator
functionality.
*/

`timescale 1ns/1ns

module tb_bitGenerator;

	wire theBit, genDone;
	reg [1:0] genMode;
	reg doGen;
	reg clk,reset;
	
	//Module under test
	bitGenerator mut(theBit,genDone,genMode,doGen,clk,reset);
	
	//100 MHz clk
	always begin 
		#5 clk = !clk;
	end
	
	//Begin testing stimulus.
	initial begin
		$dumpfile("bitGen.vcd");
		$dumpvars(0,tb_bitGenerator);
			{doGen,clk,reset} = 3'b001; genMode = 2'b00; #10
			reset = 0; doGen = 1;                        #260   // RET, should be zero, but not for full RET time.
			genMode = 2'b10;							 #26000 // should see a low NZR pulse
			genMode = 2'b11;							 #26000 // should see a High NZR pulse
			genMode = 2'b01;                             #260   // should be low, this input shouldn't happen naturally.
		$finish;
	end
	
endmodule