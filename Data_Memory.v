module Data_Memory(
    input clk, rst, mem_w_en, mem_r_en, 
    input [31:0] address, 
    input [31:0] dataToWrite
    output [31:0] result);

    reg[7:0] memory [0:255];

    wire start_address_0 = (address - 32'd1024) >> 2;
    wire start_address_1 = {start_address_0[31:1], 1'b1}
    wire start_address_2 = {start_address_0[31:2], 2'b10}
    wire start_address_3 = {start_address_0[31:2], 2'b11}

    assign result = (mem_r_en == 1'b1 ? {memory[start_address_0], memory[start_address_1], memory[start_address_2], memory[start_address_3]} : 32'b0);

    always@(posedge clk) begin
        if(mem_w_en) begin
            memory[start_address_0] = dataToWrite[7:0]
            memory[start_address_1] = dataToWrite[15:8]
            memory[start_address_2] = dataToWrite[23:16]
            memory[start_address_3] = dataToWrite[31:24]
        end
    end
endmodule

