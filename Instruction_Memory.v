module Instruction_Memory(
    input clk, rst,
    input[31:0] address, 
    output reg[31:0] instruction
);
    reg[7:0] data[23:0];
    always @(posedge rst) begin
        if (rst)
        begin
            {data[0], data[1], data[2], data[3]} = 32'b000000_00001_00010_00000_00000000000;
            {data[4], data[5], data[6], data[7]} = 32'b000000_00011_00100_00000_00000000000;
            {data[8], data[9], data[10], data[11]} = 32'b000000_00101_00110_00000_00000000000;
            {data[12], data[13], data[14], data[15]} = 32'b000000_00111_01000_00010_00000000000;
            {data[16], data[17], data[18], data[19]} = 32'b000000_01001_01010_00011_00000000000;
            {data[20], data[21], data[22], data[23]} = 32'b000000_01101_01110_00000_00000000000;
        end
    end
    

    always @(posedge rst, posedge clk) begin
        if (rst)
        begin
            instruction <= 32'b0;
        end
        if (clk)
        begin
            instruction <= {data[address],data[address+1],data[address+2],data[address+3]};
        end
    end
endmodule