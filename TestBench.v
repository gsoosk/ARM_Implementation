module TB();
 reg clk = 0;
 reg rst = 0;
 initial begin
  #15 rst = 1;
  #2 rst = 0;
 end
always begin
clk = #10 !clk;
end
 ARM cpu(clk,rst);
endmodule