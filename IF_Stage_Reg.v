module IF_Stage_Reg (
    input clk, rst, flush, freeze,
    input [31:0] pc_in, 
    input [31:0] instruction_in,
    output reg [31:0] pc, instruction
);
    always @(posedge clk, posedge rst) begin
        if (rst) 
        begin
            pc <= 32'b0;
            instruction <= 32'b0;
        end
        else if (clk && flush)
        begin
            pc <= 32'b0;
            instruction <= 32'b0;
        end
        else if (clk && ~freeze)
        begin
            pc <= pc_in;
            instruction <= instruction_in;
        end 
        else
        begin
            pc <= pc;
            instruction <= instruction;
        end
    end
endmodule
