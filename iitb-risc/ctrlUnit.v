module control_decoder (opcode, ir_lsb_2, RR_A1_Address_sel, RR_A2_Address_sel, RR_A3_Address_sel, RR_Wr_En, 
						EXE_ALU_Src, EXE_ALU_Oper, Reg_D3_Sel, MEM_Wr_En, pc_data_select);

input [3:0] opcode;
input [1:0] ir_lsb_2;


output reg RR_A1_Address_sel, RR_A2_Address_sel, RR_Wr_En, MEM_Wr_En, pc_data_select;
output reg [1:0] RR_A3_Address_sel, EXE_ALU_Oper, Reg_D3_Sel, EXE_ALU_Src2;

always @(*) begin
    case (opcode)
		4'b0001: begin	                                    //ADD, ADC, ADZ, ADL
			RR_A1_Address_sel = 1'b0;                       // No address select
			RR_A2_Address_sel = 1'b0;                       // No address select
			RR_A3_Address_sel = 2'b00;                      // No address select
			RR_Wr_En = 1'b1;                                // Write to register
			pc_data_select = 1'b0;                          // No PC data select
			if ( ir_lsb_2 == 2'b11)                         // if instruction is ADL Need shift and then add
				EXE_ALU_Src = 2'b10;
			else
				EXE_ALU_Src = 2'b00;
			EXE_ALU_Oper = 2'b00;
			Reg_D3_Sel = 2'b00;
			MEM_Wr_En = 1'b0;
		end		
		4'b0000: begin                                      //ADI
			RR_A1_Address_sel = 1'b0;
			RR_A2_Address_sel = 1'b1;                       // not required during ADI
			RR_A3_Address_sel = 2'b01;                      //changed now for ADI not working
			RR_Wr_En = 1'b1;                                // Write to register
			pc_data_select = 1'b0;                          // No PC data select
			EXE_ALU_Src = 2'b01;                            // ALU source 2 is immediate
			EXE_ALU_Oper = 2'b00;                           
			Reg_D3_Sel = 2'b00;
			MEM_Wr_En = 1'b0; 
		end
		4'b0010: begin                                      //NDU, NDC, NDZ
			RR_A1_Address_sel = 1'b0;
			RR_A2_Address_sel = 1'b0;
			RR_A3_Address_sel = 2'b00;
			RR_Wr_En = 1'b1;
			pc_data_select = 1'b0;
			EXE_ALU_Src2 = 2'b00;
			EXE_ALU_Oper = 2'b01;
			Reg_D3_Sel = 2'b00;
			MEM_Wr_En = 1'b0;
		end	
		4'b0011: begin                                      //LHI
			RR_A1_Address_sel = 1'b1;                       // not required during LHI
			RR_A2_Address_sel = 1'b1;                       // not required during LHI
			RR_A3_Address_sel = 2'b10;
			RR_Wr_En = 1'b1;
			pc_data_select = 1'b0;
			EXE_ALU_Src2 = 2'b10;
			EXE_ALU_Oper = 2'b10;                           // no ALU operation
			Reg_D3_Sel = 2'b10;
			MEM_Wr_En = 1'b0;
		end
		4'b0100: begin                                      //LW
			RR_A1_Address_sel = 1'b1;
			RR_A2_Address_sel = 1'b1;                       // not required during LW
			RR_A3_Address_sel = 2'b10;
			RR_Wr_En = 1'b1;
			pc_data_select = 1'b0;
			EXE_ALU_Src2 = 2'b01;
			EXE_ALU_Oper = 2'b00;
			Reg_D3_Sel = 2'b01;
			MEM_Wr_En = 1'b0;
		end
		4'b0101: begin                                      //SW
			RR_A1_Address_sel = 1'b1;
			RR_A2_Address_sel = 1'b1; 
			RR_A3_Address_sel = 2'b00;                      // not required during SW
			RR_Wr_En = 1'b0;
			pc_data_select = 1'b0;
			EXE_ALU_Src2 = 2'b01;
			EXE_ALU_Oper = 2'b00;
			Reg_D3_Sel = 2'b01;                             // not required during SW
			MEM_Wr_En = 1'b1;
		end
		4'b1001: begin                                      // JAL
			RR_A1_Address_sel = 1'b1 ;                      // not rqd for jal
			RR_A2_Address_sel = 1'b1;                       // not rqd for jal 
			RR_A3_Address_sel = 2'b10;                      // ir 11:9 
			RR_Wr_En = 1'b1;
			EXE_ALU_Src2 = 2'b00;
			pc_data_select = 1'b1;
			EXE_ALU_Oper = 2'b00;
			Reg_D3_Sel = 2'b00; 
			MEM_Wr_En = 1'b0;
		end
		4'b1010 : begin                                     // JLR
			RR_A1_Address_sel = 1'b1;                       // not rqd for jlr
			RR_A2_Address_sel = 1'b0; 
			RR_A3_Address_sel = 2'b10;                      // ir 11:9 
			RR_Wr_En = 1'b1;
			EXE_ALU_Src2 = 2'b00;
			pc_data_select = 1'b1;
			EXE_ALU_Oper = 2'b00;
			Reg_D3_Sel = 2'b00; 
			MEM_Wr_En = 1'b0;
		end
		4'b1110, 4'b1100: begin                             //LA and LM
			RR_A1_Address_sel = 1'b0;
			RR_A2_Address_sel = 1'b1;                       // not required during LA and LM
			RR_A3_Address_sel = 2'b10;                      // does not matter, the mux at mem stage select accordingly
			RR_Wr_En = 1'b1;
			pc_data_select = 1'b0;
			EXE_ALU_Src2 = 2'b01;
			EXE_ALU_Oper = 2'b00;
			Reg_D3_Sel = 2'b01;
			MEM_Wr_En = 1'b0;
		end
		4'b1111, 4'b1101: begin                             //SA and SM
			RR_A1_Address_sel = 1'b0;
			RR_A2_Address_sel = 1'b1;                       // not required during SA and SM
			RR_A3_Address_sel = 2'b00;                      // not required during SA and SM
			RR_Wr_En = 1'b0;
			pc_data_select = 1'b0;
			EXE_ALU_Src2 = 2'b01;
			EXE_ALU_Oper = 2'b00;
			Reg_D3_Sel = 2'b01;                             // not required during SA and SM
			MEM_Wr_En = 1'b1;
		end

		default: begin  // corresponding to NOP
			RR_A1_Address_sel = 1'b0;
			RR_A2_Address_sel = 1'b0;
			RR_A3_Address_sel = 2'b10;
			RR_Wr_En = 1'b0;
			pc_data_select = 1'b0;
		    EXE_ALU_Src2 = 2'b00;
			EXE_ALU_Oper = 2'b00;
			Reg_D3_Sel = 2'b00;
			MEM_Wr_En = 1'b0; 
		end

	endcase
		
endmodule