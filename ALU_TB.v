
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
