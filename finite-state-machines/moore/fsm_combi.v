/*
In a Moore FSM, the output is a function of the previous state only.
All Moore FSMs can be (trivially) converted to Mealy FSMs
simply by setting the output of every transition arrow
to the output of the state it is pointing to.
The reverse direction is not always possible without
introducing new states.

Implements the following Moore FSM:
A -> B, 1
B -> C, 1
C -> A, 1

A: 0
B: 0
C: 1

(output assignment logic is found in main.v)
*/
module fsm_combi (input inp, input [1:0] st, output [1:0] out_st, output out);
    parameter [1:0] A = 2'b00, B = 2'b01, C = 2'b10;

    reg [1:0] out_st_reg, out_reg;
    assign out = out_reg;
    assign out_st = out_st_reg;
    
    always @ *
    begin
        out_st_reg = st;
        out_reg = 1'b0;
        case(st)
            A: if(inp) out_st_reg = B;
            B: if(inp) out_st_reg = C;
            C: if(inp)
            begin
                out_st_reg = A;
                out_reg = 1'b1;
            end
            default: out_st_reg = A;
        endcase
    end
endmodule