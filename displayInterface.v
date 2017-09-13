///////////////////////////////////////////////////////////////////////////////////////
// Student:       Conor Dooley & Daniel Groos
// Project:       Display Interface
// Target Device: XC7A100T-csg324 on Digilent Nexys-4 board
// Description:   Display interface, takes 16 bit input and outputs 8 bit digit and segment
// Created:       October 2016
///////////////////////////////////////////////////////////////////////////////////////
module displayInterface (
    input [15:0] value,
    input clock, reset,
    input [3:0] point,
    output reg [7:0] segment, 
    output reg [7:0] digit
    );

reg [1:0] countOutput, nextCount;
reg [3:0] rawSeg;
wire [6:0] segSeven;
reg [10:0] enableCountNext, enableCount;
wire enableReg;
reg radixOut;

//slows down clock 2048 times to get readable digit cycling (hopefully)
always @ (posedge clock)
begin
    enableCount <= enableCountNext;
end
always @ (*)
begin
    if(reset) enableCountNext = 11'd0;
    else enableCountNext = enableCount + 1'b1;
end
//enable digit count register every 2048 cycles - maybe choose 11'd1 instead of 0?
assign enableReg = (enableCount == 11'd0)? 1'b1 : 1'b0;
//2 bit counter to select which 7seg
always @ (posedge clock)
begin
    countOutput <= nextCount;
end
always @ (*)
begin
    if(reset) nextCount = 2'd0;
    else if (enableReg) nextCount = countOutput +1'b1;
    else nextCount = countOutput;
end
//selecting digit changes 2 bit count into 1 hot for 7seg selection
always @ (countOutput)
begin
    case(countOutput)
        2'b00: digit = 8'b11111110;
        2'b01: digit = 8'b11111101;
        2'b10: digit = 8'b11111011;
        2'b11: digit = 8'b11110111;
    endcase
end
//chooses which 4 bits to select based on digit counter
always @ (countOutput, value)
begin
    case(countOutput)
        2'b00: rawSeg = value[3:0];
        2'b01: rawSeg = value[7:4];
        2'b10: rawSeg = value[11:8];
        2'b11: rawSeg = value[15:12];
    endcase
end
//converts 4 bit input hex into 7 bit segment information
hex2seg hexSeg(
    .number(rawSeg), 
    .pattern(segSeven)
    );
//selecting radix - pipes tbit onwards to be joined with 7bit segment info depending on digit counter
always @ (countOutput, point)
begin
    case(countOutput)
        2'b00: radixOut = point[0:0];
        2'b01: radixOut = point[1:1]; 
        2'b10: radixOut = point[2:2];
        2'b11: radixOut = point[3:3];
    endcase
end
//7 bit pattern + 1 bit radix point to 8 bit segment output
always @ (*)
begin
segment = {  segSeven[6:0], radixOut };
end
endmodule
