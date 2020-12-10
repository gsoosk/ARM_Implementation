module Hazard_Detection_Unit(
    input clk, rst,
    input mem_wb_enable,
    input [3:0] mem_dest,
    input exe_wb_enable,
    input [3:0] exe_dest,
    input [3:0] Rn,
    input [3:0] src_2,
    input two_src,
    output hazard_detected_signal
);

    assign hazard_detected_signal = (Rn == exe_dest & exe_wb_enable == 1'b1) | 
                                    (Rn == mem_dest & mem_wb_en) | 
                                    (src2 == exe_dest & exe_wb_en & two_src) | 
                                    (src2 == mem_dest & mem_wb_en & src_2) ? 1'b1 : 1'b0;

endmodule