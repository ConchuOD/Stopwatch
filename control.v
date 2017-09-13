///////////////////////////////////////////////////////////////////////////////////////
// Student:       Conor Dooley
// Project:       Stopwatch
// Target Device: XC7A100T-csg324 on Digilent Nexys-4 board
// Description:   This module is an FSM which controls the operation of the stopwatch
//                
// Created:       November 2016
//////////////////////////////////////////////////////////////////////////////////////
module buttonControl (
    input clock, reset,
    input buttonSt, buttonFi,
    output reg run
    );
reg [1:0] currentState, nextState; //register to hold state, and variable to hold next state

localparam STATE_TIMER_OFF = 2'b01,
           STATE_TIMER_ON = 2'b10;

always @ (posedge clock)
begin
    currentState <= nextState;
end

always @ ( * )
begin
    if(reset) nextState = STATE_TIMER_OFF;
    else
    begin
        case (currentState)
            STATE_TIMER_OFF: // if in off state, start button high and finish low will start timer, anything else will hold state 
            begin
                if(buttonSt == 1'b1 && buttonFi == 1'b0)
                begin
                    nextState = STATE_TIMER_ON;
                end
                else
                begin
                    nextState = STATE_TIMER_OFF;
                end
            end
            STATE_TIMER_ON: // if in on state, start button low and finish high will stop timer, anything else will hold state 
            begin
                if(buttonFi == 1'b1 && buttonSt == 1'b0)
                begin
                    nextState = STATE_TIMER_OFF;
                end
                else
                begin
                    nextState = STATE_TIMER_ON;
                end
            end
            default:
            begin
                nextState = STATE_TIMER_OFF; //default state after restart is 
            end
                
        endcase
    end
end

always @ (currentState)
begin
    if (currentState == STATE_TIMER_ON) run = 1'b1; //when on, run is high
    else run = 1'b0; //when its off, run is low
end
endmodule
