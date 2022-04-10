module ID2RR_Pipline_Reg (clk, rst, enable, pc_in, pc_next_in, instr_in, spec_taken_in, 
							pc_out, pc_next_out, instr_out, spec_taken_out, cntrl_in, cntrl_out,
							pc_data_select, pc_data_select_out);
 
	input clk, rst, enable, spec_taken_in, pc_data_select;
	input [15:0] pc_in, pc_next_in, instr_in;
    input [9:0] cntrl_in;
	output reg spec_taken_out, pc_data_select_out;
	output reg [15:0] pc_out, pc_next_out, instr_out;
    output reg [9:0] cntrl_out;

	always @ (posedge clk) begin
		if (rst) begin
			pc_out <= 0;
			pc_next_out <= 0;
			pc_data_select_out <= 0;
			instr_out <= 0;
			spec_taken_out <= 0;
            cntrl_out <= 0;
		end
		else begin
			if (enable) begin
				pc_out <= pc_in;
				pc_next_out <= pc_next_in;
				pc_data_select_out <= pc_data_select;
				instr_out <= instr_in;
				spec_taken_out <= spec_taken_in;
                cntrl_out <= cntrl_in;
			end
		end
	end
endmodule // ID2RR_Pipline_Reg