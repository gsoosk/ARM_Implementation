module WB_Stage (
    input clk, rst,
    input[31:0] PC_in,

    input wb_en, mem_r_en, 
    input [31:0] alu_res,
    input [3:0] dest,
    input [31:0] data_mem,

    output[31:0] PC,
    output wb_en_out, 
    output [31:0] wb_value,
    output [3:0] dest_out
);
    // Passing wires
    assign PC = PC_in;
    assign wb_en_out = wb_en;
    assign dest_out = dest;

    // MUX
    assign wb_value = mem_r_en ? data_mem : alu_res;

endmodule