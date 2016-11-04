/*
Authored by Elijah Theander
October 28, 2016
modeMachine.v
This state machine takes multiple inputs and uses
them to decide what to pass to the shiftRegister as
a load value, and whether or not it will use a button to determine 
sending after RET.
*/

module modeMachine(go,regVal,changeMode,modeSet,send,Green,Red,Blue,rbSwap,colorCycle,clk,reset);

	output          go;                  //Determines sending.
	output [95:0]   regVal;              //Passthrough into ShiftRegister loadValue
	
	input           changeMode;          // Basys 3 button switch
	input [1:0]     modeSet;             //Basys 3 sw[1:0]
	input           send;                //Basys 3 button switch
	input [3:0]     Green,Red,Blue;      //basys 3 sw [15:4]
	input [95:0]    rbSwap,colorCycle;   //inputs from seperate modules
	input           clk,reset;           //synchronous clock and reset.
	
	//State and next state variables
	reg  [1:0]       S;
	wire [1:0]       nS;
	
	//State Parameters
	parameter basemode = 2'b00, weewoo = 2'b01, cyclecolor = 2'b10;
	
	//State Memory
	always @(posedge clk)begin
		if(reset)begin
			S <= basemode;
		end
		else if(changeMode)begin
			S <= nS;
		end
		else begin
			S <= S;
		end
	end
	
	//Next state
	nS = modeSet;
	
	//go moore output
	go = (S == basemode)? send:1'b1;
	
	//regVal output
	always @(S,Green,Red,Blue,rbSwap,colorCycle)begin
		case(S)
			basemode:begin regVal = {Green,4'h0,Red,4'h0,Blue,4'h0,
			                         Green,4'h0,Red,4'h0,Blue,4'h0,
									 Green,4'h0,Red,4'h0,Blue,4'h0,
									 Green,4'h0,Red,4'h0,Blue,4'h0}; end
			weewoo:        regVal = rbSwap;
			cyclecolor:    regVal = colorCycle;
			default:       regVal = 96'h0F0F0F_0F0F0F_0F0F0F_0F0F0F;
		endcase
	end
	
endmodule