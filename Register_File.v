module Register_File(
    input clk, rst, 
    input [3:0] src1, src2, Dest_wb,
    input [31:0] Result_WB,
    input writeBackEn, 
    output [31:0] reg1, reg2
    );
    reg[31:0] registers [0:14];
    assign reg1 = registers[src1];
    assign reg2 = registers[src2];

    always @(negedge clk, posedge rst)
    begin
         if(rst)
         begin
            for(i=0; i < 15; i+=1) begin
                data[i] <= i;
            end
         end
         else if(writeBackEn)
         begin
            registers[Dest_wb] <= Result_WB;
         end   
    end
endmodule 

