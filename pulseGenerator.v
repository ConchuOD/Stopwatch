module pulseGenerator
# ( parameter [19:0] MAXVAL = 19'd500000)
	(
	input clock,
	input reset,
	input run,
	output reg pulse
	);

reg [19:0] count;	
reg [19:0] countNext;

always @ (posedge clock)
begin
count <= countNext;
end


always @ (*)
begin
    if(reset)
    begin 
        countNext = 1'b0;
        pulse = 1'b0;
    end
    else if(run)
    begin
        if (count == MAXVAL)
        begin
            countNext = 19'b0;
            pulse = 1'b1;
        end
        else
        begin
            countNext = count + 1'b1;
            pulse = 1'b0;
        end
    end
    else
    begin
        countNext = count;
        pulse = 1'b0;
    end
end
endmodule
