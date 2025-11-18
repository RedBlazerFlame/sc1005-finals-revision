`timescale 1ns/1ps
`include "main.v"

module main_tb;
    parameter HALF_CYC = 5;

    wire x_w, clk_w, rst_w, out;
    reg x, clk, rst;
    assign x_w = x;
    assign clk_w = clk;
    assign rst_w = rst;
    fsm uut(.inp(x_w), .clk(clk_w), .rst(rst_w), .out(out));

    initial begin
        $dumpfile("main_tb.vcd");
        $dumpvars(0, main_tb);
    end

    integer i = 0;
    initial begin
        clk = 1'b1;
        for(i = 0; i < 30; i = i + 1)
        begin
            #(HALF_CYC) clk = ~clk;
        end
    end

    initial begin
        x = 1'b1;
        rst = 1'b0;

        #(10);

        #(17) rst = 1'b1;
        #(10) rst = 1'b0;

        #(10) x=1'b0;
        #(10) x=1'b1;

        #(28) x=1'b0;
        #(10) x=1'b1;
    end
endmodule