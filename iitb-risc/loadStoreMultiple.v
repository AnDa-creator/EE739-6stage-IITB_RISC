module load_store_multi_block
#(	
	parameter LA = 4'b1110,
	parameter SA = 4'b1111,
	parameter LM = 4'b1100,
	parameter SM = 4'b1101
)
(
	input  [127:0] reg_data_form_id_128,
	input  [15:0] ir, rf_d2,
	input clk,
	output reg [2:0] reg_index_la_sa, reg_index_lm_sm,
	output reg freeze, reg_or_mem_enable, nop_mux_select,
	output reg [15:0] mem_data_for_sa_sm
);

	reg [7:0] imm;
	
	initial begin 
		reg_index_la_sa = 3'b000;
		reg_index_lm_sm = 3'b000;
		freeze = 1'b1;
		reg_or_mem_enable = 1'b0;
		mem_data_for_sa_sm = 16'b0000000000000000;
		nop_mux_select = 1'b0;
    end
    
	always @(*) begin 
	    imm = ir[7:0];
		if ((reg_index_la_sa >=0) && (reg_index_la_sa <=5) && ((ir[15:12] == LA) || (ir[15:12] == SA) || (ir[15:12] == LM) || (ir[15:12] == SM)))
			freeze = 1'b0;
		else
			freeze = 1'b1;
			
		if (imm[7 - reg_index_la_sa] == 1'b1)
			reg_or_mem_enable = 1'b1;
		else
			reg_or_mem_enable = 1'b0;
			
		if ((ir[15:12] == SA) || (ir[15:12] == SM)) begin
			if(reg_index_la_sa == 0)
				mem_data_for_sa_sm = reg_data_form_id_128[15 : 0];
			else if(reg_index_la_sa == 1)
				mem_data_for_sa_sm = reg_data_form_id_128[31 : 16];
			else if(reg_index_la_sa == 2)
				mem_data_for_sa_sm = reg_data_form_id_128[47 : 32];
			else if(reg_index_la_sa == 3)
				mem_data_for_sa_sm = reg_data_form_id_128[63 : 48];
			else if(reg_index_la_sa == 4)
				mem_data_for_sa_sm = reg_data_form_id_128[79 : 64];
			else if(reg_index_la_sa == 5)
				mem_data_for_sa_sm = reg_data_form_id_128[95 : 80];
			else if(reg_index_la_sa == 6)
				mem_data_for_sa_sm = reg_data_form_id_128[111 : 96];
		end
		else begin
			mem_data_for_sa_sm = rf_d2;
		end				
	end
	
	always @(*) begin 
		if (((ir[15:12] == LA) || (ir[15:12] == SA) || (ir[15:12] == LM) || (ir[15:12] == SM)))
			nop_mux_select = 1'b1;
		else
			nop_mux_select = 1'b0;		
	end

	always @(posedge clk) begin 
	  imm = ir[7:0];
	  if (reg_index_la_sa >= 6) begin 
		reg_index_la_sa = 3'b000;
		reg_index_lm_sm = 3'b000;
	  end
      else if ((ir[15:12] == LA) || (ir[15:12] == SA)) begin
	    reg_index_la_sa = reg_index_la_sa + 1;
	  end
	  else if ((ir[15:12] == LM) || (ir[15:12] == SM)) begin
			if (imm[7 - reg_index_la_sa] == 1'b1) begin
				reg_index_lm_sm = reg_index_lm_sm + 1;
			end	
	    reg_index_la_sa = reg_index_la_sa + 1;
	  end
	end

endmodule