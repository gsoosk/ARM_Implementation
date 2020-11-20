
module Status_Register (
    input clk, rst,
    input s,
    input [3:0] status_in,

    output reg [3:0] status
);

  	// assign {z, c, n, v} = status;

	always@(negedge clk, posedge rst) 
	begin
		if (rst) status <= 0;
		else if (s) status <= status_in;
		else status <= status;
	end
	
endmodule