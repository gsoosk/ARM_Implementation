module Hazard_Detection_Unit(
    input clk, rst,
    input mem_wb_en,
    input [3:0] mem_dest,
    input exe_wb_en,
    input [3:0] exe_dest,
    input [3:0] src_1,
    input [3:0] src_2,
    input two_src,
    input fwd_en, 
    input exec_mem_read_en,
    output hazard_detected_signal
);

    wire hazard_with_fwd, hazard_without_fwd;


    assign hazard_without_fwd = (src_1 == exe_dest & exe_wb_en == 1'b1) | 
                                (src_1 == mem_dest & mem_wb_en == 1'b1) | 
                                (src_2 == exe_dest & exe_wb_en == 1'b1 & two_src == 1'b1) | 
                                (src_2 == mem_dest & mem_wb_en == 1'b1 & two_src == 1'b1) ? 1'b1 : 1'b0;

    assign hazard_with_fwd = (src_1 == exe_dest & exe_wb_en == 1'b1) | 
                            (src_2 == exe_dest & exe_wb_en == 1'b1 & two_src == 1'b1) ? 1'b1 : 1'b0; 

    assign hazard_detected_signal = fwd_en ? hazard_with_fwd & exec_mem_read_en :  
                                    hazard_without_fwd;
    

endmodule