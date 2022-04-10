// SubModule :: ALU Control
module alu_ctrl
(   
    input [15:0] instr,
    input [1:0] aluCtrlOp,
    input carry_in,
    input zero_in,
    input reg_write_enable_in,
    output reg carry_write_en, zero_write_en,
	output reg reg_write_enable_out,
    output reg  [1:0] alu_operation_out
);

    wire [5:0] ALUControlIn;
    assign ALUControlIn = {instr[15:12],instr[1:0]};

    parameter ADD = 6'b000100;
    parameter ADC = 6'b000110;
    parameter ADZ = 6'b000101;
    parameter ADL = 6'b000111;
    parameter ADI = 4'b0000;
    parameter NDU = 6'b001000;
    parameter NDC = 6'b001010;
    parameter NDZ = 6'b001001; // ADD anything we want later


    always @(ALUControlIn) begin
        case (ALUControlIn)
            ADD, ADL,{ADI,2'b00} : begin
                if (reg_write_enable_in) begin 
                    alu_operation_out = 2'b00;
		            carry_write_en = 1;
		            zero_write_en = 1;
		            reg_write_enable_out = 1;
                end
		    end
            ADC: begin 
                if (carry_in && reg_write_enable_in) begin 
                    carry_write_en = 1;
                    zero_write_en = 1;
                    alu_operation_out = 2'b00;
                    reg_write_enable_out = 1;
                end
                else begin 
                    carry_write_en = 0;
                    zero_write_en = 0;
                    alu_operation_out = 2'b10;
                    reg_write_enable_out = 0;
                end
		    end
            ADZ: begin 
                if (reg_write_enable_in) begin
                    if (zero_in) begin 
                        carry_write_en = 1;
                        zero_write_en = 1;
                        alu_operation_out = 2'b00;
                        reg_write_enable_out = 1;
                    end
                    else begin 
                        carry_write_en = 0;
                        zero_write_en = 0;
                        alu_operation_out = 2'b10;
                        reg_write_enable_out = 0;
                    end
                end
		    end
            NDU: begin 
                if (reg_write_enable_in) begin 
                    alu_operation_out = 2'b01;
                    zero_write_en = 1;
                    carry_write_en = 0;
                    reg_write_enable_out = 1;
		        end
            end
            NDC: begin 
                if (reg_write_enable_in) begin
                    if (carry_in) begin 
                        carry_write_en = 0;
                        zero_write_en = 1;
                        alu_operation_out = 2'b01;
                        reg_write_enable_out = 1;
                    end
                    else begin 
                        carry_write_en = 0;
                        zero_write_en = 0;
                        alu_operation_out = 2'b10;
                        reg_write_enable_out = 0;
                    end
		        end
            end
            NDZ: begin if (reg_write_enable_in) begin
                    if (zero_in) begin 
                        carry_write_en = 0;
                        zero_write_en = 1;
                        alu_operation_out = 2'b01;
                        reg_write_enable_out = 1;
                    end
                    else begin 
                        carry_write_en = 0;
                        zero_write_en = 0;
                        alu_operation_out = 2'b10;
                        reg_write_enable_out = 0;
                    end
		        end
            end		  
            default: begin
                carry_write_en = 0;
                zero_write_en = 0;
                reg_write_enable_out = reg_write_enable_in;
                alu_operation_out = aluCtrlOp;
            end
        endcase
    end

endmodule


