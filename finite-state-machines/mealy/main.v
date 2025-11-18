/*
In a Mealy FSM, the output is a function of both the previous state
and the current state.
The previous and current states characterize the output.
It is not straightforward to convert a Mealy FSM
to a Moore FSM.

In general, if a Mealy FSM requires O(N) states,
the corresponding Moore FSM requires O(N^2) states.

Notice that, in the implementation,
both the next state and the next output are held in
registers. This is because the next output now also
depends on the previous state, so we cannot simply
assign to it in the combinational always block.

Implements the following Mealy FSM:

off -> off, 0/1 # Note: for demonstration purposes only. Semantically this transition is kinda odd (since it assigns output 1 for transitioning into off)
off -> on1, 1/0
on1 -> on2, 1/1
on2 -> on3, 1/1
on3 -> off, 1/0
*/
module fsm(input inp, clk, rst, output out);
    wire [1:0] st;
    reg [1:0] nst;
    reg [1:0] st_reg;
    reg out_reg;
    reg nout;

    // ! Make sure not to include [msb:lsb] bounds in assign, ONLY in declaration!
    assign st = st_reg;
    assign out = out_reg;

    parameter [1:0] off = 2'b00, on1 = 2'b01, on2 = 2'b10, on3 = 2'b11;

    // Sequential Part: Creating Register for Next State
    // ! Make sure to add begin and end
    always @ (posedge clk)
        if(rst)
        begin
            st_reg <= 2'b0; // We assume 0 is the default state
            out_reg <= 1'b0;
        end
        else
        begin
            st_reg <= nst;
            out_reg <= nout;
        end
    
    // Combinational Part
    always @*
    begin
        nout = out;
        nst = st;
        case(st)
        off:
        begin
            if(inp)
            begin
                nst = on1;
                nout = 1'b0;
            end
            else
            begin
                nout = 1'b1;
            end
        end
        on1:
        begin
            if(inp)
            begin
                nst = on2;
                nout = 1'b1;
            end
        end
        on2:
        begin
            if(inp)
            begin
                nst = on3;
                nout = 1'b1;
            end
        end
        on3:
        begin
            if(inp)
            begin
                nst = off;
                nout = 1'b0;
            end
        end
        default:
        begin
            nout = 1'b0;
            nst = off;
        end
        endcase
    end
endmodule