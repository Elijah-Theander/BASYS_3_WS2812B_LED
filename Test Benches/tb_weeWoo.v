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
	wire tenHz;
	
	reg         enable;
	reg         clk,reset;
	
	//Test Modules.
	tenHzDiv give(tenHz,enable,   clk,reset);
	weeWoo   receive(rbSwap,tenHz,clk,reset);
	
	//100 MHz clk
	always begin
	    #5 clk = !clk;
	end
	
	//Begin testing
	initial begin
	    $dumpfile("weeWoo.vcd");
		$dumpvars(0,tb_weeWoo);
		    {enable,clk,reset} = 3'b101; #30
			reset = 0;                   #400_000_000
			//This should give us several changes.
		$finish;
	end
	
endmodule