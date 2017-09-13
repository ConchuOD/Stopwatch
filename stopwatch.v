///////////////////////////////////////////////////////////////////////////////////////
// Student:       Conor Dooley
// Project:       Stopwatch
// Target Device: XC7A100T-csg324 on Digilent Nexys-4 board
// Description:   Top-level module to for stopwatch, responsible for io and module interconnection
//  Created:      27 October 2016
///////////////////////////////////////////////////////////////////////////////////////
module stopwatch(input clk100,        // 100 MHz clock from oscillator on board
                 input rstPBn,        // reset signal, active low, from CPU RESET pushbutton
                 input btnL,          // starts timer
                 input btnR,          // stops timer
                 output [7:0] digit,  // digit controls - active low (7 on left, 0 on right)
                 output [7:0] segment // segment controls - active low (a b c d e f g dp)
                 );
// ====================================================================================
//  Interconnecting Signals
    wire clk5;              // 5 MHz clock signal, buffered
    wire reset;             // internal reset signal, active high
    wire [15:0] dispVal;    // value to be displayed
    wire [3:0] radixVal;    // radix to display
    wire pulse;
    wire run;
// ====================================================================================
//  Instantiate clock and reset generator, connect to signals
    clockReset  clkGen  (.clk100 (clk100),       // input clock at 100 MHz
                         .rstPBn (rstPBn),       // input reset, active low
                         .clk5   (clk5),         // output clock, 5 MHz	
                         .reset  (reset)         // output reset, active high
                        );   
//=====================================================================================
//  Setting decimal point location.
    assign radixVal = 1101;
//=====================================================================================
//  Instantiation of button control.    
    buttonControl control1 (.clock(clk5),
                            .reset(reset),
                            .run(run),
                            .buttonSt(btnL),
                            .buttonFi(btnR)
                            );
//=====================================================================================
//  Instantiation of pulse generator.
    pulseGenerator pulse1 (.clock(clk5),     // 5 MHz clock signal
                           .run(run),        // controls operation of the stopwatch
                           .reset(reset),    // reset signal, active high
                           .pulse(pulse)    // output pulse
                           );
//=====================================================================================
//  Instantiation of counter (BCD).
    timeCounter count10 (.enable(pulse),
                         .clock(clk5),
                         .reset(reset),
                         .digits(dispVal)
                         );
// ====================================================================================
//  Instantiation of display interface.
    displayInterface disp1 (.clock(clk5),      // 5 MHz clock signal
                            .reset(reset),     // reset signal, active high
                            .value(dispVal),   // input value to be displayed
                            .point(radixVal),  // radix markers to be displayed
                            .digit(digit),     // digit outputs
                            .segment(segment)  // segment outputs
                            );
endmodule
