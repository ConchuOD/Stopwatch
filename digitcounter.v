module digitCounter(
	input enable,
	input clock,
	input reset,
	output reg [3:0] count,
	output reg ovw
	);
	
reg [3:0] nextCount;

always @ (posedge clock)
begin
    count <= nextCount;
end

always @ (*)
begin
	if(reset)
		nextCount = 4'h0;
	else if(enable)
    begin
        if(count == 4'h9)
            nextCount = 4'h0;
        else 
	       nextCount = count + 4'h1;
    end
	else
	   nextCount = count;
end

always @ (*)
begin
if(count == 4'h9)
    ovw = 1'h1;
else 
    ovw = 1'h0;
end

endmodule
