/*
Authored by Elijah Theander
November 4, 2016
tb_modeMachine.v
Test bench that verifies function of 
modeMachine.v
*/

`timescale 1ns/1ns

module tb_modeMachine;

	wire          go;
	wire [95:0]   regVal;
	
	reg           changeMode;
	reg [1:0]     modeSet;
	reg           send;
	reg [3:0]     Green,Red,Blue;
	reg [95:0]    rbSwap,colorCycle;
	reg           clk,reset;
	
	//Module under test
	modeMachine mut(go,regVal,changeMode,modeSet,send,Green,Red,Blue,rbSwap,colorCycle,clk,reset);
	
	//100 MHz clk
	always begin
	    #5 clk = !clk;
	end
	
	//Begin testing stimulus
	initial begin
		$dumpfile("modeMachine.vcd");
		$dumpvars(0,tb_modeMachine);
			Green = 4'hA; Red = 4'hB; Blue = 4'hC; modeSet = 2'b00; 
			{changeMode,send,clk,reset} = 4'b0001;  
			rbSwap = 96'hBEE_DAD_BEE_DAD_BEE_DAD_BEE_DAD;
			colorCycle = 96'hCAB_FAD_CAB_FAD_CAB_FAD_CAB_FAD;            #30
			reset = 0;  send = 1;                                        #30
			//I'm going to skip a line and switch indentation for readability here.
			//should be in basemode here. regVal will red green and blue loaded into it.
			
			modeSet = 2'b01; send = 0;          #30 //Mode won't change here
			changeMode = 1;                     #30 //Mode should be 01 after this.
			changeMode = 0;                     #30 //Go should be high, regVal should be BEEDAD
			modeSet = 2'b10; changeMode = 1;    #30 //Mode will be 10, go is High, regVal is CABFAD.
		$finish;
	end
	
endmodule