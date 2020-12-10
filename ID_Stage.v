module ID_Stage (
    input clk, rst,
    input [31:0] PC_in,
    input [31:0] instruction,
    input [3:0] status,

    input wb_wb_en, 
    input [31:0] wb_value,
    input [3:0] wb_dest,
    input hazard,

    output [31:0] PC,
    output mem_r_en, mem_w_en, wb_en, status_w_en, branch_taken, imm,
    output [3:0] exec_cmd,
    output [31:0] val_rm, val_rn,
    output [23:0] signed_immed_24,
    output [3:0] dest,
    output [11:0] shift_operand,
    output two_src
);
    assign PC = PC_in; 

    // OR to hazard detection
    assign two_src = ~imm | mem_w_en;

    // Chunking the Instruction 
    wire[3:0] cond;
    assign cond = instruction[31:28];
    wire[1:0] mode;
    assign mode = instruction[27:26];
    wire immediate;
    assign immediate = instruction[25];
    wire[3:0] opcode;
    assign opcode = instruction[24:21];
    wire s;
    assign s = instruction[20];
    wire[3:0] rn, rd, rm;
    assign rn = instruction[19:16];
    assign rd = instruction[15:12];
    assign dest = rd;
    assign rm = instruction[3:0];
    assign shift_operand = instruction[11:0];
    assign signed_immed_24 = instruction[23:0];


    // Control Unit
    wire mem_r_en_c, mem_w_en_c, wb_en_c, status_w_en_c, branch_taken_c, imm_c;
    wire[3:0] exec_cmd_c;
    Control_Unit control_unit(
        .opcode(opcode),
        .s(s),
        .imm_in(immediate),
        .mode(mode),
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
        .status(status), // Input of status should be taken from the status register's output
        .result(condition_check_result)
    );

    // Condition Check MUX
    wire mux_selector;
    assign mux_selector = ~condition_check_result | hazard; 
    
    wire[9:0] mux_input;
    assign mux_input = {mem_r_en_c, mem_w_en_c, wb_en_c, status_w_en_c, branch_taken_c, imm_c, exec_cmd_c};

    assign {mem_r_en, mem_w_en, wb_en, status_w_en, branch_taken, imm, exec_cmd} = mux_selector ?  10'b0 : mux_input;

    // Register File
        // Register file address mux
        wire[3:0] src2;
        assign src2 = mem_w_en ? rd : rm ;

    Register_File register_file(
        .clk(clk), 
        .rst(rst), 
        .src1(rn), 
        .src2(src2), 
        .Dest_wb(wb_dest),
        .Result_WB(wb_value),
        .writeBackEn(wb_wb_en), 
        .reg1(val_rn), 
        .reg2(val_rm)
    );
   

endmodule