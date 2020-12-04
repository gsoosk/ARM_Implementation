module MEM_Stage_Reg (
    input clk, rst, flush, freeze,
    input [31:0] pc_in, 
    input wb_en, mem_r_en, mem_w_en, 
    input [31:0] alu_res,
    input [3:0] dest,
    input [31:0] data_mem,
    output reg [31:0] pc,
    output reg wb_en_out, mem_r_en_out, mem_w_en_out, 
    output reg [31:0] alu_res_out,
    output reg [3:0] dest_out,
    output reg [31:0] data_mem_out
);
    always @(posedge clk, posedge rst) begin
        if (rst) 
        begin
            pc <= 32'b0;
            wb_en_out <= 1'b0;
            mem_r_en_out <= 1'b0;
            alu_res_out <= 32'b0;
            dest_out <= 4'b0;
            data_mem_out <= 32'b0;
        end
        else if (clk && flush)
        begin
            pc <= 32'b0;
            wb_en_out <= 1'b0;
            mem_r_en_out <= 1'b0;
            alu_res_out <= 32'b0;
            dest_out <= 4'b0;
            data_mem_out <= 32'b0;
        end
        else if (clk && ~freeze)
        begin
            pc <= pc_in;
            wb_en_out <= wb_en;
            mem_r_en_out <= mem_r_en;
            mem_w_en_out <= mem_w_en;
            alu_res_out <= alu_res;
            dest_out <= dest;
            data_mem_out <= data_mem;
        end 
        else
        begin
            pc <= pc;
            wb_en_out <= wb_en_out;
            mem_r_en_out <= mem_r_en_out;
            alu_res_out <= alu_res_out;
            dest_out <= dest_out;
            data_mem_out <= data_mem_out;
        end
    end
endmodule