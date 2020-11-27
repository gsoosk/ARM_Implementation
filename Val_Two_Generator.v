`define LSL 2'b00
`define LSR 2'b01
`define ASR 2'b10
`define ROR 2'b11

module Val_Two_Generator(
    input [31:0] Rm,
    input [11:0] shift_operand,
    input immediate, is_mem_instruction,
    output [31:0] result
    );
    
    reg [31:0] imm_32_bit, rm_rotate;
    integer i = 0;

    // Helping wires
    wire [5:0] shift_imm;
    assign shift_imm = shift_operand[11:7];

    wire [4:0] rotate_imm;
    assign rotate_imm = shift_operand[11:8];

    wire [1:0] shift;
    assign shift = shift_operand[6:5];
 
    assign result = is_mem_instruction == 1'b1  ? { {20{shift_operand[11]}}, shift_operand} : 
                    immediate == 1'b1           ? imm_32_bit : 
                    shift == `LSL               ? Rm << {shift_imm} :
                    shift == `LSR               ? Rm >> {shift_imm} :
                    shift == `ASR               ? Rm >> {shift_imm} :
                    shift == `ROR               ? rm_rotate : 32'b1;

    always@(*) begin
        imm_32_bit = {24'b0, shift_operand[7:0]};
        for(i = 0; i < rotate_imm; i = i+1) begin
            imm_32_bit = {imm_32_bit[1:0], imm_32_bit[31:2]};
        end    

        rm_rotate = Rm;
        for(i = 0; i <= shift_operand[11:7]; i = i+1) begin
            rm_rotate = {rm_rotate[0], rm_rotate[31:0]};
        end
    end
endmodule