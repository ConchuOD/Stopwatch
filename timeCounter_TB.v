`timescale 1ns / 1ps
module TB_timeCounter;
	// Inputs to module being verified
	reg clock, enable, reset;
	// Outputs from module being verified
	wire [15:0] digits;
	// Instantiate module
	timeCounter uut (
		.clock(clock),
		.enable(enable),
		.reset(reset),
		.digits(digits)
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
			enable = 1'b0;
			reset = 1'b0;
			#150
			reset = 1'b1;
			#300
			reset = 1'b0;
			#1600
			enable = 1'b1;
			#300
			enable = 1'b0;
			#200
			enable = 1'b1;
			#200
			enable = 1'b0;
			#200
			enable = 1'b1;
			#200
			enable = 1'b0;
			#200
			enable = 1'b1;
			#200
			enable = 1'b0;
			#200
			enable = 1'b1;
			#200
			enable = 1'b0;
			#200
			enable = 1'b1;
			#200
//file was 10,000s of lines in length in order to test overflow but this was removed for submission
//due to it being 1.5 MB +
			$stop;
		end
endmodule
