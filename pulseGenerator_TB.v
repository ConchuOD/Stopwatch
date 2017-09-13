`timescale 1ns / 1ps
module TB_pulseGenerator;
	// Inputs to module being verified
	reg clock, reset, run;
	// Outputs from module being verified
	wire pulse;
	// Instantiate module
	pulseGenerator uut (
		.clock(clock),
		.reset(reset),
		.run(run),
		.pulse(pulse)
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
			run = 1'b0;
			#50
			reset = 1'b1;
			#200
			reset = 1'b0;
			#900
			run = 1'b1;
			#1700
			run = 1'b0;
			#1100
			run = 1'b1;
			#1400
			run = 1'b0;
			#600
			run = 1'b1;
			#4050
			$stop;
		end
endmodule
