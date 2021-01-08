module IF_Stage (
    input clk, rst, freeze, BranchTaken, 
    input [31:0] BranchAddress,
    output [31:0] PC, Instruction
);

    wire[31:0] mux_in, mux_out;
    assign mux_out = BranchTaken ? BranchAddress : mux_in;

    wire[31:0] pc_in, pc_out;
    PC pc(clk, rst, ~freeze, pc_in, pc_out);

    assign pc_in = mux_out;

    wire[31:0] pc_added;
    assign pc_added = pc_out + 4;
    assign mux_in = pc_added;


    Instruction_Memory instruction_memory(clk, rst, pc_out, Instruction);
    assign PC = pc_added;
endmodule


