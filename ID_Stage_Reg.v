module ID_Stage_Reg (
    input clk, rst, flush, freeze,
    input [31:0] pc_in, 
    output reg [31:0] pc
);
    always @(posedge clk, posedge rst) begin
        if (rst) 
        begin
            pc <= 32'b0;
        end
        else if (clk && flush)
        begin
            pc <= 32'b0;
        end
        else if (clk && ~freeze)
        begin
            pc <= pc_in;
        end 
        else
        begin
            pc <= pc;
        end
    end
endmodule