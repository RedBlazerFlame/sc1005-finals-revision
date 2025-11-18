`include "fsm_combi.v"

module fsm(input inp, clk, rst, output out);
    wire [1:0] nst, st;
    reg [1:0] st_reg;
    assign st = st_reg;

    // Sequential Part: Creating Register for Next State
    // ! Cannot assign to wires within always blocks!
    always @ (posedge clk)
        if(rst)
            st_reg <= 2'b0; // We assume 0 is the default state
        else
            st_reg <= nst;
    
    // Combinational Part
    // ! No period before typename!
    fsm_combi combinational_part(.inp(inp), .st(st), .out_st(nst), .out(out));
endmodule