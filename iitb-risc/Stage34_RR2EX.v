//cntrl_in format {RR_A3_Address_sel, RR_Wr_En, EXE_ALU_Src2, EXE_ALU_Oper, Reg_D3_Sel, MEM_Wr_En} total 10 bits

module RR2EX_Pipline_Reg (clk, rst, enable, RF_A1_In, RF_A2_In, RF_A3_From_WB_In, RF_D3_From_WB_In, RR_Write_En_In, 
							RF_D1_In, RF_D2_In, RF_A1_Out, RF_A2_Out, RF_A3_From_WB_Out, RF_D3_From_WB_Out, 
							RR_Write_En_Out, RF_D1_Out, RF_D2_Out, pc_in,pc_next_in, cntrl_in,pc_data_select, instr_in, spec_taken_in, pc_out,pc_next_out, cntrl_out, instr_out, pc_data_select_out, spec_taken_out);
 
	input clk, rst, enable, RR_Write_En_In, pc_data_select, spec_taken_in;
	input [15:0] pc_in, RF_D1_In, RF_D2_In, instr_in, RF_D3_From_WB_In, pc_next_in;
	input [2:0] RF_A1_In, RF_A2_In, RF_A3_From_WB_In;
	input [9:0] cntrl_in;
	output reg RR_Write_En_Out, pc_data_select_out;
	output reg [15:0] pc_out, RF_D1_Out, RF_D2_Out, instr_out, RF_D3_From_WB_Out, pc_next_out;
	output reg [9:0] cntrl_out;
	output reg [2:0] RF_A1_Out, RF_A2_Out, RF_A3_From_WB_Out;
	output reg spec_taken_out;
	
	always @ (posedge clk) begin
		if (rst) begin
			spec_taken_out <= 0;
			pc_out <= 0;
			pc_next_out <= 0;
			cntrl_out <= 0;
			instr_out <= 0;
			RF_D1_Out <= 0;
			RF_D2_Out <= 0;
			RF_A1_Out <= 0;
			RF_A2_Out <= 0;
			RF_A3_From_WB_Out <= 0;
			RF_D3_From_WB_Out <= 0;
			RR_Write_En_Out <= 0;
			pc_data_select_out <= 0;
		end
		else begin
			if (enable) begin
				spec_taken_out <= spec_taken_in;
				pc_data_select_out <= pc_data_select;
				pc_out <= pc_in;
				pc_next_out <= pc_next_in;
				cntrl_out <= cntrl_in;
				instr_out <= instr_in;
				RF_D1_Out <= RF_D1_In;
				RF_D2_Out <= RF_D2_In;
				RF_A1_Out <= RF_A1_In;
				RF_A2_Out <= RF_A2_In;
				RF_A3_From_WB_Out <= RF_A3_From_WB_In;
				RF_D3_From_WB_Out <= RF_D3_From_WB_In;
				RR_Write_En_Out <= RR_Write_En_In;
			end
		end
	end
endmodule // RR2EX_Pipline_Reg