/*
Authored by Elijah Theander
November 10, 2016
tb_ledControl.v
Test bench for verifying control module.
*/

`timescale 1ns/1ns

module tb_ledControl;
	wire doGen;
	wire doRet;
	wire loadRegister;
	wire [1:0] genMode;
	
	reg go;
	reg retDone;
	reg sendDone;
	reg registerBit;
	reg clk,reset;
	
	//Module under test
	ledControl mut(doGen,doRet,loadRegister,genMode,go,retDone,sendDone,registerBit,clk,reset);
	
	//Set up 100 MHz clk
	always begin
		#5 clk = !clk;
	end
	
	//Begin testing stimulus
	initial begin
		$dumpfile("ledControl.vcd");
		$dumpvars(0,tb_ledControl);
			{go,retDone,sendDone,registerBit,clk,reset} = 6'b000001; #10 //initialize
			retDone = 1; reset  = 0;                                 #20 //state should stay at sendRet,doRet=1,loadRegister=1,genMode=00;
			go = 1;                                                  #20 //doGen=1,genMode=10
			registerBit=1;                                           #20 //genMode=11;
			sendDone=1;                                              #20 //state goes to sendRet.
			//doRet is high, loadregister is high, genMode is 00;
		$finish;
	end
	
endmodule