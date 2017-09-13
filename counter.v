module counter16 (
    input clock, reset,
    input pulse,
    output [15:0] countOut
    );
reg [15:0] counter;
reg [15:0] nextcount;

always @ (posedge clock or posedge reset)
begin
if (reset) counter <= 16'd0;
else counter <= nextcount;
end

always @ (*)
begin
if(pulse) nextcount = nextcount + 16'd1;
else nextcount = nextcount;
end
assign countOut = counter;
endmodule

