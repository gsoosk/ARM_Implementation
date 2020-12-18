`include "Forwarding_Unit.v"

module EXE_Stage (
    input clk, rst,
    input[31:0] PC_in,
    input mem_r_en, mem_w_en, wb_en, imm,
    input carry_in,
    input [11:0] shift_operand,
    input [3:0] exec_cmd,
    input [31:0] val_rm, val_rn,
    input [23:0] signed_immed_24,
    input [3:0] dest,

    input [1:0] sel_src1, sel_src2,
    input [3:0] mem_dest, wb_dest,

    output[31:0] branch_address,
    output [3:0] alu_status,

    output[31:0] PC,
    output wb_en_out, mem_r_en_out, mem_w_en_out,
    output [31:0] alu_res,
    output [31:0] val_rm_out,
    output [3:0] dest_out
);
    //passing wires
    assign PC = PC_in;
    assign mem_r_en_out = mem_r_en;
    assign mem_w_en_out = mem_w_en;
    assign wb_en_out = wb_en;
    assign dest_out = dest;

    // is memory instruction identifier
    wire is_mem_ins;
    assign is_mem_ins = mem_r_en | mem_w_en;

    // MUX for FWD_SEL_SRC2
    assign val_rm_out = sel_src2 == `FORWARD_FROM_ID_SEL ? val_rm :
                        sel_src2 == `FORWARD_FROM_MEM_SEL ? mem_dest :
                        sel_src2 == `FORWARD_FROM_WB_SEL ? wb_dest :
                        val_rm;

    // Val 2 Generator
    wire [31:0] val2, val1;
    Val_Two_Generator val_two_gen(
        .Rm(val_rm_out),
        .shift_operand(shift_operand),
        .immediate(imm),
        .is_mem_instruction(is_mem_ins),
        .result(val2)
    );


    assign val1 = sel_src1 == `FORWARD_FROM_ID_SEL ? val_rn :
                        sel_src1 == `FORWARD_FROM_MEM_SEL ? mem_dest :
                        sel_src1 == `FORWARD_FROM_WB_SEL ? wb_dest :
                        val_rn;

    // ALU
    ALU alu(
        .val1(val1), 
        .val2(val2),
        .exec_cmd(exec_cmd),
        .carry_in(carry_in),
        .alu_res(alu_res),
        .status(alu_status)
    );

    // Branch Address
    assign branch_address = PC_in + {{6{signed_immed_24[23]}}, signed_immed_24, 2'b0};


endmodule