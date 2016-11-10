/*
Authored by Elijah Theander
November 10, 2016
ledMachine.v
This machine links all modules together into
a full working machine ready for and XDC file 
and implementation into vivado.
*/

module ledMachine(clk,reset);
	output
	input clk,reset;
	
	//shiftRegister wires
	wire        tenHzWire;
	wire [95:0] rbWire;
	wire [95:0] rainbowWire;
	wire [95:0] loadValWire;
	wire        registerBitWire;
	
	//Control module wire
	wire        goWire;
	
	tenHzDiv tenHz_Supply(        .tenHz(tenHzWire),
	                              .enable(1'b1),
						          .clk(clk), .reset(reset));
						  
	weeWoo rb_Supply(             .rbSwap(rbWire),
                                  .tenHzIn(tenHzWire),
                                  .clk(clk), .reset(reset));
	
	rainbowReg rainbow_Supply(    .colorCycle(rainbowWire),
	                              .tenHzin(tenHzWire),
							      .clk(clk), .reset(reset));
							
	modeMachine mode_Supply(      .go(goWire),
                                  .regVal(loadValWire),
                                  .changeMode(),
                                  .modeSet(),
                                  .send(),
                                  .Green(),
                                  .Red(),
                                  .Blue(),
                                  .rbSwap(rbWire),
                                  .colorCycle(rainbowWire),
                                  .clk(clk), .reset(reset));								  
						  
	shiftRegister register_Supply(.registerBit(.registerBitWire),
	                              .loadRegister(loadRegWire),
								  .loadValue(loadValWire),
								  .genDone(),
								  .clk(clk),
								  .reset(reset));
endmodule;