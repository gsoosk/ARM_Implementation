module PC (
   input clk, rst,
   input load, 
   input[31:0] pc_in,
   output reg[31:0] pc_out
);

    always @(posedge clk, posedge rst) begin
        if (rst) pc_out <= 32'b0;
        else if (clk && load) pc_out <= pc_in;
        else pc_out <= pc_out;
    end
endmodule