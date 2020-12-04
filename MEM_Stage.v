module MEM_Stage (
    input clk, rst,
    input[31:0] PC_in,
    input wb_en, mem_r_en, mem_w_en, 
    input [31:0] alu_res,
    input [31:0] val_rm,
    input [3:0] dest,
    output[31:0] PC,
    output wb_en_out, mem_r_en_out, mem_w_en_out, 
    output [31:0] mem_res_out,
    output [3:0] dest_out,
    output [31:0] data_mem_out
);
    // Passing wires:
    assign PC = PC_in;
    assign mem_res_out = alu_res;
    assign wb_en_out = wb_en;
    assign mem_r_en_out = mem_r_en;
    assign mem_w_en_out = mem_w_en;
    assign dest_out = dest;

    // TODO: Data Memory
    Data_Memory data_memory(
        .clk(clk),
        .rst(rst),
        .mem_w_en(mem_w_en),
        .mem_r_en(mem_r_en),
        .address(alu_res),
        .dataToWrite(val_rm),
        .result(mem_res_out))
    assign data_mem_out = 32'b0;
endmodule