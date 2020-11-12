module ID_Stage_Reg (
    input clk, rst, flush, freeze,
    input [31:0] pc_in, 
    input mem_r_en_in, mem_w_en_in, wb_en_in, status_w_en_in, branch_taken_in, imm_in,
    input [3:0] exec_cmd_in,
    input [31:0] val_rm_in,
    input [23:0] signed_immed_24_in,
    input [3:0] dest_in,

    output reg [31:0] pc,
    output reg mem_r_en, mem_w_en, wb_en, status_w_en, branch_taken, imm,
    output reg [3:0] exec_cmd,
    output reg [31:0] val_rm,
    output reg [23:0] signed_immed_24,
    output reg [3:0] dest
);
    always @(posedge clk, posedge rst) begin
        if (rst) 
        begin
            pc <= 32'b0;
            mem_r_en <= 1'b0;
            mem_w_en <= 1'b0;
            wb_en <= 1'b0;
            status_w_en <= 1'b0;
            branch_taken <= 1'b0;
            imm <= 1'b0;
            exec_cmd <= 4'b0;
            val_rm <= 32'b0;
            signed_immed_24 <= 24'b0;
            dest <= 4'b0; 
        end
        else if (clk && flush)
        begin
            pc <= 32'b0;
            mem_r_en <= 1'b0;
            mem_w_en <= 1'b0;
            wb_en <= 1'b0;
            status_w_en <= 1'b0;
            branch_taken <= 1'b0;
            imm <= 1'b0;
            exec_cmd <= 4'b0;
            val_rm <= 32'b0;
            signed_immed_24 <= 24'b0;
            dest <= 4'b0; 
        end
        else if (clk && ~freeze)
        begin
            pc <= pc_in;
            mem_r_en <= mem_r_en_in;
            mem_w_en <= mem_w_en_in;
            wb_en <= wb_en_in;
            status_w_en <= status_w_en_in;
            branch_taken <= branch_taken_in;
            imm <= imm_in;
            exec_cmd <= exec_cmd_in;
            val_rm <= val_rm_in;
            signed_immed_24 <= signed_immed_24_in;
            dest <= dest_in; 
        end 
        else
        begin
            pc <= pc;
            mem_r_en <= mem_r_en;
            mem_w_en <= mem_w_en;
            wb_en <= wb_en;
            status_w_en <= status_w_en;
            branch_taken <= branch_taken;
            imm <= imm;
            exec_cmd <= exec_cmd;
            val_rm <= val_rm;
            signed_immed_24 <= signed_immed_24;
            dest <= dest;
        end
    end
endmodule