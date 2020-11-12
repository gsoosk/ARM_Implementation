module ID_Stage (
    input clk, rst,
    input[31:0] PC_in,
    input[31:0] instruction,
    output[31:0] PC,
    output mem_r_en, mem_w_en, wb_en, status_w_en, branch_taken, imm,
    output[3:0] exec_cmd,
    output[31:0] val_rm,
    output[23:0] signed_immed_24,
    output[3:0] dest;
);
    assign PC = PC_in; 

    //TODO: OR to hazard detection

    // Chunking the Instruction 
    wire[3:0] cond;
    assign cond = instruction[31:28];
    wire[2:0] mode;
    assign mode = instruction[27:26];
    wire immediate;
    assign immediate = instruction[25];
    wire[3:0] opcode;
    assign opcode = instruction[24:21];
    wire s;
    assign s = instruction[20];
    wire[3:0] rn, rd, rm, dest;
    assign rn = instruction[19:16];
    assign rd = instruction[15:12];
    assign dest = rd;
    assign rm = instruction[3:0];
    wire[11:0] shift_operand;
    assign shift_operand = instruction[11:0];
    wire[23:0] signed_immed_24;
    assign signed_immed_24 = instruction[23:0];


    // Control Unit
    wire mem_r_en_c, mem_w_en_c, wb_en_c, status_w_en_c, branch_taken_c, imm_c;
    wire[3:0] exec_cmd_c;
    Control_Unit control_unit(
        .opcode(opcode),
        .s(s),
        .imm_in(immediate),
        .exec_cmd(exec_cmd_c),
        .mem_w_en(mem_w_en_c),
        .mem_r_en(mem_r_en_c),
        .wb_en(wb_en_c),
        .status_w_en(status_w_en_c),
        .branch_taken(branch_taken_c),
        .imm(imm_c)
    );


    // Condition Check
    wire condition_check_result;
    Condition_Check condition_check(
        .cond(cond),
        .status(4'b0), // TODO: Input of status should be taken from the status register's output
        .result(condition_check_result)
    );

    // Condition Check MUX
    wire mux_selector;
    assign mux_selector = ~condition_check_result; // TODO: OR with hazard should be added
    
    wire[9:0] mux_input;
    assign mux_input = {mem_r_en_c, mem_w_en_c, wb_en_c, status_w_en_c, branch_taken_c, imm_c, exec_cmd_c};

    wire mem_r_en, mem_w_en, wb_en, status_w_en, branch_taken, imm;
    wire[3:0] exec_cmd;
    assign {mem_r_en, mem_w_en, wb_en, status_w_en, branch_taken, imm, exec_cmd} = mux_selector ?  10'b0 : mux_input;

    // Register File
    wire[31:0] val_rm, val_rn;
        // Register file address mux
        wire src2;
        assign src2 = mem_w_en ? rd : rm ;

    Register_File register_file(
        .clk(clk), 
        .rst(rst), 
        .src1(rn), 
        .src2(src2), 
        .Dest_wb(4'b0),
        .Result_WB(32'b0),
        .writeBackEn(1'b0), 
        .reg1(val_rn), 
        .reg2(val_rm)
    );
   

endmodule