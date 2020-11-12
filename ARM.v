module ARM (input clk,
            rst);
    wire flush, freeze, BranchTaken;
    assign flush       = 1'b0;
    assign freeze      = 1'b0;
    assign BranchTaken = 1'b0;
    wire[31:0] BranchAddress;
    assign BranchAddress = 32'b0;
    
    // Instruction Fetch Stage:
    wire[31:0] if_pc_in, if_instruction_in, if_pc_out, if_instruction_out;
    IF_Stage if_stage(
        clk, 
        rst, 
        freeze, 
        BranchTaken,
        BranchAddress,
        if_pc_in,
        if_instruction_in
    );
    IF_Stage_Reg if_stage_reg(
        clk,
        rst, 
        flush, 
        freeze, 
        if_pc_in, 
        if_instruction_in, 
        if_pc_out, 
        if_instruction_out
    );
    
    // Instruction Decode Stage:
    wire[31:0] id_pc_in, id_pc_out;
    ID_Stage id_stage(
        clk, 
        rst, 
        if_pc_out, 
        if_instruction_out,
        id_pc_in
    );
    ID_Stage_Reg id_stage_reg(
        clk, 
        rst, 
        flush, 
        freeze,
        id_pc_in, 
        id_pc_out
    );

    // Executaion Stage:
    wire[31:0] exe_pc_in, exe_pc_out;
    EXE_Stage exe_stage(
        clk, 
        rst, 
        id_pc_out, 
        exe_pc_in
    );
    EXE_Stage_Reg exe_stage_reg(
        clk, 
        rst, 
        flush, 
        freeze,
        exe_pc_in, 
        exe_pc_out
    );

    // Memory Stage:
    wire[31:0] mem_pc_in, mem_pc_out;
    MEM_Stage mem_stage(
        clk, 
        rst, 
        exe_pc_out, 
        mem_pc_in
    );
    MEM_Stage_Reg mem_stage_reg(
        clk, 
        rst, 
        flush, 
        freeze,
        mem_pc_in, 
        mem_pc_out
    );

    // Write Block Stage:
    wire[31:0] wb_pc_in, wb_pc_out;
    WB_Stage wb_stage(
        clk, 
        rst, 
        mem_pc_out, 
        wb_pc_in
    );
    WB_Stage_Reg wb_stage_reg(
        clk, 
        rst, 
        flush, 
        freeze,
        wb_pc_in, 
        wb_pc_out
    ); 
    
endmodule
