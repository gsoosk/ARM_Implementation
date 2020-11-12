`include "ALU_Commands.v"

`define ARITHMATIC_INS_TYPE  2'b00
`define MEM_INS_TYPE  2'b01
`define BRANCH_INS_TYPE  2'b10
`define CO_PROC_INS_TYPE  2'b11

`define NOP 4'b0000
`define MOV 4'b1101
`define MVN 4'b1111
`define ADD 4'b0100
`define ADC 4'b0101
`define SUB 4'b0010
`define SBC 4'b0110
`define AND 4'b0000
`define ORR 4'b1100
`define EOR 4'b0001
`define CMP 4'b1010
`define TST 4'b1000
`define LDR 4'b0100
`define STR 4'b0100


module Control_Unit(
    input [3:0] opcode,
    input s,
    input imm_in,
    output reg[3:0] exec_cmd,
    output reg mem_w_en,
    output reg mem_r_en,
    output reg wb_en,
    output reg status_w_en,
    output reg branch_taken
    output reg imm
);

    always @(opcode, mode, s) begin
        // Initial
        status_w_en = s;
        imm = imm_in;

        mem_r_en = 1'b0;
        mem_w_en = 1'b0;
        wb_en = 1'b0;
        branch_taken = 1'b0;
        exec_cmd = 4'b000;


        // Check Instruction
        case (mode)
            `ARITHMATIC_INS_TYPE: begin
                case (opcode)
                    `NOP: begin
                        // Do nothing!
                    end
                    `MOV: begin
                        wb_en = 1'b1;
                        exec_cmd = `MOV_ALU;
                    end 
                    `MVN: begin
                        wb_en = 1'b1;
                        exec_cmd = `MVN_ALU;
                    end
                    `ADD: begin
                        wb_en = 1'b1;
                        exec_cmd = `ADD_ALU;
                    end
                    `ADC: begin
                        wb_en = 1'b1;
                        exec_cmd = `ADC_ALU
                    end
                    `SUB: begin
                        wb_en = 1'b1;
                        exec_cmd = `SUB_ALU
                    end
                    `SBC: begin
                        wb_en = 1'b1;
                        exec_cmd = `SBC_ALU
                    end
                    `AND: begin
                        wb_en = 1'b1;
                        exec_cmd = `AND_ALU
                    end
                    `ORR: begin
                        wb_en = 1'b1;
                        exec_cmd = `ORR_ALU
                    end
                    `EOR: begin
                        wb_en = 1'b1;
                        exec_cmd = `EOR_ALU
                    end
                    `CMP: begin
                        exec_cmd = `CMP_ALU
                    end
                    `TST: begin
                        exec_cmd = `TST_ALU
                    end 
                endcase
            end
            `MEM_INS_TYPE: begin
                case (s)
                    1'b1: begin
                        // LDR
                        mem_r_en = 1'b1;
                        exec_cmd = LDR_ALU;
                        wb_en = 1'b1;
                    end
                    1'b0: begin
                        // STR
                        mem_w_en = 1'b1;
                        exec_cmd = STR_ALU;
                    end
                endcase
            end
            `BRANCH_INS_TYPE: begin
                branch_taken = 1'b0;
            end
            end
        endcase

    end
    
endmodule