/*
Authored by Elijah Theander
November 2, 2016
tb_weeWoo.v
Test bench linking tenhzdiv and weewoo.v
to verify weewoo.v
*/

`timescale 1ns/1ns

module tb_weeWoo;

	wire [95:0] rbSwap;
	
	reg         tenHzIn;
	reg         clk,reset;
	
	//Module under test
	weeWoo   mut(rbSwap,tenHzIn,clk,reset);
	
	//100 MHz clk
	always begin
	    #5 clk = !clk;
	end
	
	//Begin testing
	initial begin
	    $dumpfile("weeWoo.vcd");
		$dumpvars(0,tb_weeWoo);
		    {tenHzIn,clk,reset} = 3'b101; #30
			reset = 0;                    #30
			tenHzIn = 0;                  #30
			tenHzIn = 1;                  #30
			tenHzIn = 0;                  #30
			//This should give us several changes.
		$finish;
	end
	
endmodule