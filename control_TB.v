`timescale 1ns / 1ps
module TB_buttonControl;
	// Inputs to module being verified
	reg clock, reset, buttonSt, buttonFi;
	// Outputs from module being verified
	wire run;
	// Instantiate module
	buttonControl uut (
		.clock(clock),
		.reset(reset),
		.buttonSt(buttonSt),
		.buttonFi(buttonFi),
		.run(run)
		);
	// Generate clock signal
	initial
		begin
			clock  = 1'b1;
			forever
				#100 clock  = ~clock ;
		end
	// Generate other input signals
	initial
		begin
			reset = 1'b0;
			buttonSt = 1'b0;
			buttonFi = 1'b0;
			#150
			reset = 1'b1;
			#100
			reset = 1'b0;
			#100
			buttonSt = 1'b1;
			#300
			buttonSt = 1'b0;
			#200
			buttonSt = 1'b1;
			#300
			buttonSt = 1'b0;
			#200
			buttonFi = 1'b1;
			#200
			buttonFi = 1'b0;
			#200
			buttonFi = 1'b1;
			#100
			buttonFi = 1'b0;
			#200
			buttonSt = 1'b1;
			#200
			buttonSt = 1'b0;
			#100
			buttonFi = 1'b1;
			#200
			buttonFi = 1'b0;
			#200
			buttonFi = 1'b1;
			#100
			buttonFi = 1'b0;
			#100
			buttonSt = 1'b1;
			#100
			buttonSt = 1'b0;
			#950
			$stop;
		end
endmodule
