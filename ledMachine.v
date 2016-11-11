/*
Authored by Elijah Theander
November 10, 2016
ledMachine.v
This machine links all modules together into
a full working machine ready for and XDC file 
and implementation into vivado.
*/

module ledMachine(bitOut,btnU,btnD,sw,clk,btnC);
	output bitOut; //going through one of the pmod headers to the LED strip.
	input clk;
	input btnC; //Basys 3 center button, linked to reset.
	input btnU; //Basys 3 top button, linked to changeMode.
	input btnD; //Basys 3 bottom button, linked to send.
	input [15:0] sw; //Basys 3 switches, linked to various things
	//shiftRegister wires
	wire        tenHzWire;
	wire [95:0] rbWire;
	wire [95:0] rainbowWire;
	wire [95:0] loadValWire;
	wire        registerBitWire;
	
	//Control module wire
	wire        goWire;
	wire [1:0]  genModeWire;
	wire        genDoneWire;
	wire        doGenWire;
	wire        sendDoneWire;
	wire        doRetWire;
	wire        retDoneWire;
	
	//PlaceHolder wire.
	wire [1:0]  placeholder;
	assign placeholder = sw[3:2];
	
	tenHzDiv tenHz_Supply(          .tenHz(tenHzWire),
	                                .enable(1'b1),
						            .clk(clk), .reset(btnC));
						  
	weeWoo rb_Supply(               .rbSwap(rbWire),
                                    .tenHzIn(tenHzWire),
                                    .clk(clk), .reset(btnC));
	
	rainbowReg rainbow_Supply(      .colorCycle(rainbowWire),
	                                .tenHzin(tenHzWire),
							        .clk(clk), .reset(btnC));
							
	modeMachine mode_Supply(        .go(goWire),
                                    .regVal(loadValWire),
                                    .changeMode(btnU),
                                    .modeSet(sw[1:0]),
                                    .send(btnD),
                                    .Green(sw[11:8]),
                                    .Red(sw[15:12]),
                                    .Blue(sw[7:4]),
                                    .rbSwap(rbWire),
                                    .colorCycle(rainbowWire),
                                    .clk(clk), .reset(btnC));								  
						  
	shiftRegister register_Supply(  .registerBit(.registerBitWire),
	                                .loadRegister(loadRegWire),
								    .loadValue(loadValWire),
								    .genDone(genDoneWire),
								    .clk(clk), .reset(btnC));
								  
	ledControl foreman(             .doGen(doGenWire),
	                                .doRet(doRetWire),
								    .loadRegister(loadRegWire),
								    .genMode(genModeWire),
								    .go(goWire),
								    .retDone(retDoneWire),
								    .sendDone(sendDoneWire)),
						  		    .registerBit(registerBitWire),
								    .clk(clk), .reset(btnC));
								  
	bitGenerator bit_Supply(        .theBit(bitOut),
                                    .genDone(genDoneWire),
								    .genMode(genModeWire),
								    .doGen(doGenWire),
								    .clk(clk), .reset(btnC));
	
	rotationCounter rotation_Supply(.sendDone(sendDoneWire),
	                                .genDone(genDoneWire),
									.clk(clk), .reset(btnC));
						
	retCounter ret_Supply(          .retDone(retDoneWire),
	                                .en(doRetWire),
									.clk(clk), .reset(btnC));
endmodule