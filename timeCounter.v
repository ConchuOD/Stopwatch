module timeCounter(
    input enable,
    input clock,
    input reset,
    output wire [15:0] digits
    );

wire ovw0_CL, ovw1_CL, ovw2_CL, deadEnd;
reg ovw0_1, ovw1_2, ovw2_3;
wire [3:0] digit_0, digit_1, digit_2, digit_3;
digitCounter digitC_0 (
    .ovw(ovw0_CL),
    .enable(enable),
    .clock(clock),
    .reset(reset),
    .count(digit_0)
    );
digitCounter digitC_1 (
    .ovw(ovw1_CL),
    .enable(ovw0_1),
    .clock(clock),
    .reset(reset),
    .count(digit_1)
    );
digitCounter #( .OVWON (4'h5) ) digitC_2 (
    .ovw(ovw2_CL),
    .enable(ovw1_2),
    .clock(clock),
    .reset(reset),
    .count(digit_2)
    );
digitCounter digitC_3 (
    .ovw(deadEnd),
    .enable(ovw2_3),
    .clock(clock),
    .reset(reset),
    .count(digit_3)
    );

always @ (enable)
begin
    ovw0_1 = (ovw0_CL & enable);
    ovw1_2 = (ovw1_CL & ovw0_1);
    ovw2_3 = (ovw2_CL & ovw1_2);
end
assign digits = {digit_3, digit_2, digit_1, digit_0};

endmodule
