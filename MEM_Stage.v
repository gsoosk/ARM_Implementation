module MEM_Stage (
    input clk, rst,
    input[31:0] PC_in,
    input wb_en, mem_r_en, 
    input [31:0] alu_res,
    input [3:0] dest,
    output[31:0] PC,
    output wb_en_out, mem_r_en_out, 
    output [31:0] alu_res_out,
    output [3:0] dest_out,
    output [31:0] data_mem_out
);
    // Passing wires:
    assign PC = PC_in;
    assign alu_res_out = alu_res;
    assign wb_en_out = wb_en;
    assign mem_r_en_out = mem_r_en;
    assign dest_out = dest;

    // TODO: Data Memory
    assign data_mem_out = 32'b0;
endmodule