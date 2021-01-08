module EXE_Stage_Reg (
    input clk, rst, flush, freeze,
    input [31:0] pc_in, 
    input wb_en_in, mem_r_en_in, mem_w_en_in,
    input [31:0] alu_res_in,
    input [31:0] val_rm_in,
    input [3:0] dest_in,

    output reg [31:0] pc,
    output reg wb_en, mem_r_en, mem_w_en,
    output reg [31:0] alu_res,
    output reg [31:0] val_rm,
    output reg [3:0] dest
    
);
    always @(posedge clk, posedge rst) begin
        if (rst) 
        begin
            pc <= 32'b0;
            wb_en <= 1'b0;
            mem_r_en <= 1'b0;
            mem_w_en <= 1'b0;
            alu_res <= 32'b0;
            val_rm <= 32'b0;
            dest <= 4'b0;
        end
        else if (clk && flush)
        begin
            pc <= 32'b0;
            wb_en <= 1'b0;
            mem_r_en <= 1'b0;
            mem_w_en <= 1'b0;
            alu_res <= 32'b0;
            val_rm <= 32'b0;
            dest <= 4'b0;
        end
        else if (clk && ~freeze)
        begin
            pc <= pc_in;
            wb_en <= wb_en_in;
            mem_r_en <= mem_r_en_in;
            mem_w_en <= mem_w_en_in;
            alu_res <= alu_res_in;
            val_rm <= val_rm_in;
            dest <= dest_in;
        end 
        else
        begin
            pc <= pc;
            wb_en <= wb_en;
            mem_r_en <= mem_r_en;
            mem_w_en <= mem_w_en;
            alu_res <= alu_res;
            val_rm <= val_rm;
            dest <= dest;
        end
    end
endmodule