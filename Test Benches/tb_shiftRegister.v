/*
Authored by Elijah Theander
October 27, 2016
tb_shiftRegister.v
Test bench verifying the function
of shiftRegister.v 
*/

`timescale 1ns/1ns

module tb_shiftRegister;

	wire 		 registerBit;
	reg  		 loadRegister;
	reg [95:0]   loadValue;
	reg 		 genDone;
	reg 		 clk,reset;
	
	//Module under test
	shiftRegister mut(registerBit,loadRegister,loadValue,genDone,clk,reset);
	
	//100 MHz clk
	always begin
		#5 clk = !clk;
	end
	
	//Begin testing stimulus
	initial begin
		$dumpfile("shiftreg.vcd");
		$dumpvars(0,tb_shiftRegister);
			loadValue = 96'hAAAAAA_BBBBBB_AAAAAA_BBBBBB;
			{loadRegister,genDone,clk,reset} =4'b1101;    #20
			reset = 0;                                    #20
			loadRegister = 0;                             #1000 
			//This should give us all rotates.
		$finish;
	end
	
endmodule
