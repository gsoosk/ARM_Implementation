module ARM (
    input clk, rst
);
    wire flush, freeze, BranchTaken;
    assign flush = 1'b0;
    assign freeze = 1'b0;
    assign BranchTaken = 1'b0;
    wire[31:0] BranchAddress;
    assign BranchAddress = 32'b0;

    // Instruction Fetch Stage:
    wire[31:0] if_pc_in, if_instruction_in, if_pc_out, if_instruction_out;
    IF_Stage if_stage(clk, rst, freeze, BranchTaken, BranchAddress, if_pc_in, if_instruction_in);
    IF_Stage_Reg if_stage_reg(clk, rst, flush, freeze, if_pc_in, if_instruction_in, if_pc_out, if_instruction_out);   

endmodulexww