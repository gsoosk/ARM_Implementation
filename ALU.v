`include "ALU_Commands.v"

module ALU (
   input [31:0] val1, 
   input [31:0] val2,
   input [3:0] exec_cmd,
   input carry_in,
   output reg[31:0] alu_res,
   output [3:0] status
);
    reg c, v;
    wire z, n;
    always @(*) begin
        c = 1'b0;
        v = 1'b0;
        case (exec_cmd)
            `MOV_ALU:
                alu_res = val2;
            `MVN_ALU:
                alu_res = ~val2;
            `ADD_ALU:
                {c, alu_res} = val1 + val2;
            `ADC_ALU:
                {c, alu_res} = val1 + val2 + carry_in;
            `SUB_ALU:
                {c, alu_res} = val1 - val2;
            `SBC_ALU:
                {c, alu_res} = val1 - val2 - 1;
            `AND_ALU:
                alu_res = val1 & val2;
            `ORR_ALU:
                alu_res = val1 | val2;
            `EOR_ALU:
                alu_res = val1 ^ val2;
            `CMP_ALU:
                alu_res = val1 - val2;
            `TST_ALU:
                alu_res = val1 & val2;
            `LDR_ALU:
                alu_res = val1 + val2;
            `STR_ALU:
                alu_res = val1 + val2;
        endcase
        // If 2 Two's Complement numbers are added, and they both have the
        // same sign (both positive or both negative), then overflow occurs
        // if and only if the result has the opposite sign. Overflow never 
        //occurs when adding operands with different signs.

        // Here we use ~ instead of != because the results might be X
        if(exec_cmd == `ADD_ALU || exec_cmd == `ADC_ALU)
            v = (val1[31] == val2[31]) & (val1[31] == ~alu_res[31]);
        else if (exec_cmd == `SUB_ALU || exec_cmd == `SBC_ALU)
            v = (val1[31] == ~val2[31]) & (val1[31] == ~alu_res[31]);
    end

    assign n = alu_res[31];
    assign z = alu_res == 32'b0 ? 1'b1 : 1'b0;

    assign status = {z, c, n, v};
    
endmodule


module ALUTB();
	reg signed [31:0] a, b;
	reg[3:0] op;
    wire [3:0] status;
    reg c;
	wire signed [31:0] o;
    ALU alu(
        .val1(a), 
        .val2(b),
        .exec_cmd(op),
        .carry_in(c),
        .alu_res(o),
        .status(status)
    );

	initial begin
	a = -12; b = 20; op = 4'b0; c = 1;
	#10 op = `MOV_ALU;
	#10 op = `MVN_ALU;
	#10 op = `ADD_ALU;
    	#10 op = `ADC_ALU;
	#10 op = `SUB_ALU;
    	#10 op = `SBC_ALU; 
	#10 op = `AND_ALU;
    	#10 op = `ORR_ALU;
    #10 op = `EOR_ALU;
    #10 op = `CMP_ALU;
    #10 op = `TST_ALU;
    #10 op = `LDR_ALU;
    #10 op = `STR_ALU;
    // Check V
    #10 begin
        a = -2147483647;
        b = -2147483647;
        op = `ADD_ALU;
    end
    // Check N
    #10 begin
        a = 10;
        b = -21;
        op = `ADD_ALU;
    end
    // Check Z
    #10 begin
        a = -10;
        b = 10;
        op = `ADD_ALU;
    end
	#10 $stop;
	end
endmodule
