`define EQ 4'b0000
`define NE 4'b0001
`define CS_HS 4'b0010
`define CC_LO 4'b0011
`define MI 4'b0100
`define PL 4'b0101
`define VS 4'b0110
`define VC 4'b0111
`define HI 4'b1000
`define LS 4'b1001
`define GE 4'b1010
`define LT 4'b1011
`define GT 4'b1100
`define LE 4'b1101
`define AL 4'b1110

module Condition_Check(
    input[3:0] cond,
    input[3:0] status,
    output wire result
    );

    wire z, c, n, v;
    assign {z, c, n, v} = status;

    always@(cond, status)begin
        result = 1'b0;
        case(cond)
            `EQ: begin
                if(z == 1'b1)
                    result = 1'b1;
            end

            `NE:begin
                if(z == 1'b0)
                    result = 1'b1;
            end

            `CS_HS:begin
                if(c == 1'b1)
                    result = 1'b1;
            end

            `CC_LO:begin
                if(c == 1'b0)
                    result = 1'b1;
            end
            
            `MI: begin
                if(n == 1'b1)
                    result = 1'b1;
            end

            `PL:begin
                if(n == 1'b0)
                    result = 1'b1;
            end

            `VS:begin
                if(v == 1'b1)
                    result = 1'b1;
            end

            `VC:begin
                if(v == 1'b0)
                    result = 1'b1;
            end

            `HI:begin
                if(c == 1'b1 & z == 1'b0)
                    result = 1'b1;
            end

            `LS:begin
                if(c == 1'b0 & z == 1'b1)
                    result = 1'b1;
            end
            
            `GE: begin
                if(n == v)
                    result = 1'b1;
            end

            `LT:begin
                if(n != v)
                    result = 1'b1;
            end

            `GT:begin
                if(z == 1'b0 & n == v)
                    result = 1'b1;
            end

            `LE:begin
                if(z == 1'b1& n != v)
                    result = 1'b1;
            end

            `AL:begin
                sresult = 1'b1;
            end
        endcase
    end
endmodule

