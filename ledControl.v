/*
Authored by Elijah Theander
November 08, 2016
ledControl.v
System Control module for driving many of the modules
needed for operation.
*/

module ledControl(doGen,doRet,loadRegister,genMode,go,retDone,sendDone,registerBit,clk,reset);
	output doGen;          //Control line saying start sending
	output doRet;          //Control line telling retCounter to count
	output loadRegister;   //Tells shiftRegister to grab a new value
	output [1:0] genMode;  //Tells bitGenerator what it's creating
	
	input go;              //Input from modeMachine
	input retDone;         //Input saying RET timing has been reached
	input sendDone;        //Input saying full 96 bits have been sent
	input registerBit;     //Bit to be sent.
	input clk,reset;       //Synchronous clock and reset
	
	//State parameters and variables
	parameter sendRet = 1'b0, sendBit = 1'b1;
	reg       S,nS;
	
	//State Memory
	always @(posedge clk)begin
		if(reset)begin
			S <= sendRet;
		end
		else begin
			S <= nS;
		end
	end
	
	//Next State
	always @(S,go,retDone,sendDone)begin
		case(S)
			sendRet:    nS = ((!retDone) ? sendRet : (go ? sendBit : sendRet));
			sendBit:    nS = sendDone ? sendRet : sendBit;
			default:    nS = sendRet;
		endcase
	end
	
	//Output assignments
	assign doGen = (S == sendBit);
	assign doRet = (S == sendRet);
	assign loadRegister = (S == sendRet);
	assign genMode = (S == sendRet) ? 2'b00 : {1'b1,registerBit};
	
endmodule
