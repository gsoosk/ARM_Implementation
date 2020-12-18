`define FORWARD_FROM_ID_SEL 2'b00
`define FORWARD_FROM_WB_SEL 2'b01
`define FORWARD_FROM_MEM_SEL 2'b10

module Forwarding_Unit (
    input [3:0] src1, src2,
    input [3:0] wb_dest, mem_dest,
    input wb_wb_en, mem_wb_en,
    output reg [1:0] sel_src1, sel_src2,
    output reg forwarded
);

    always @(*) begin
        sel_src1 = `FORWARD_FROM_ID_SEL;
        sel_src1 = `FORWARD_FROM_ID_SEL;
        forwarded = 1'b0;

        if(mem_wb_en == 1'b1)
        begin

            if(mem_dest == src1)
            begin
                forwarded = 1'b1;
                sel_src1 = `FORWARD_FROM_MEM_SEL;
            end

            if(mem_dest == src2)
            begin
               forwarded = 1'b1;
               sel_src2 = `FORWARD_FROM_MEM_SEL; 
            end

        end

        if(wb_wb_en == 1'b1)
        begin
            if(wb_dest == src1)
            begin
                forwarded = 1'b1;
                sel_src1 = `FORWARD_FROM_WB_SEL;
            end

            if(wb_dest == src2)
            begin
               forwarded = 1'b1;
               sel_src2 = `FORWARD_FROM_WB_SEL; 
            end 
        end

    end
    
endmodule