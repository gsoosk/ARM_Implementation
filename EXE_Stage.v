module EXE_Stage (
    input clk, rst,
    input[31:0] PC_in,
    input mem_r_en, mem_w_en, wb_en, imm,
    input carry_in, //TODO: should be added to ID_Stage_Reg
    input [11:0] shift_operand,
    input [3:0] exec_cmd,
    input [31:0] val_rm, val_rn,
    input [23:0] signed_immed_24,
    input [3:0] dest,

    output[31:0] branch_address,
    output [3:0] alu_status,

    output[31:0] PC,
    output wb_en_out, mem_r_en_out, mem_w_en_out,
    output [31:0] alu_res,
    output [31:0] val_rm_out,
    output [3:0] dest_out
);
   assign PC = PC_in;

    // is memory instruction identifier
    wire is_mem_ins;
    assign is_mem_ins = mem_r_en | mem_w_en;

    // Val 2 Generator
    wire [31:0] val2, val1;
    module Val_Two_Generator val_2_gen(
        .Rm(val_rm),
        .shift_operand(shift_operand),
        .immediate(imm),
        .is_mem_instruction(is_mem_ins),
        .result(val2);
    );

    // ALU
    assign val1 = val_rn;
    wire [3:0] alu_status;
    module ALU alu(
        .val1(val1), 
        .val2(val2),
        .exec_cmd(exec_cmd),
        .carry_in(carry_in),
        .alu_res(alu_res),
        .status(alu_status)
    );

    // Branch Address
    wire [31:0] branch_address;
    assign branch_address = PC_in + { {8{signed_immed_24[23]}, signed_immed_24};


endmodule