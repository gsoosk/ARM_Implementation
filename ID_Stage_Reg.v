module ID_Stage_Reg (
    input clk, rst, flush, freeze,
    input [31:0] pc_in, 
    input mem_r_en_in, mem_w_en_in, wb_en_in, status_w_en_in, branch_taken_in, imm_in,
    input [3:0] exec_cmd_in,
    input [31:0] val_rm_in, val_rn_in,
    input [23:0] signed_immed_24_in,
    input [3:0] dest_in,
    input [11:0] shift_operand_in,
    input carry_in,
    input [3:0] src_1_in, src_2_in,

    output reg [31:0] pc,
    output reg mem_r_en, mem_w_en, wb_en, status_w_en, branch_taken, imm,
    output reg [3:0] exec_cmd,
    output reg [31:0] val_rm, val_rn,
    output reg [23:0] signed_immed_24,
    output reg [3:0] dest,
    output reg [11:0] shift_operand,
    output reg carry,
    output reg [3:0] src_1, src_2
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
            val_rn <= 32'b0;
            signed_immed_24 <= 24'b0;
            dest <= 4'b0; 
            shift_operand <= 12'b0;
            carry <= 1'b0;
            src_1 <= 4'b0;
            src_2 <= 4'b0;
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
            val_rn <= 32'b0;
            signed_immed_24 <= 24'b0;
            dest <= 4'b0; 
            shift_operand <= 12'b0;
            carry <= 1'b0;
            src_1 <= 4'b0;
            src_2 <= 4'b0;
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
            val_rn <= val_rn_in;
            signed_immed_24 <= signed_immed_24_in;
            dest <= dest_in; 
            shift_operand <= shift_operand_in;
            carry <= carry_in;
            src_1 <= src_1_in;
            src_2 <= src_2_in;
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
            val_rn <= val_rn;
            signed_immed_24 <= signed_immed_24;
            dest <= dest;
            shift_operand <= shift_operand;
            carry <= carry;
            src_1 <= src_1;
            src_2 <= src_2;
        end
    end
endmodule