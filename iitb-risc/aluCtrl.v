// SubModule :: ALU Control
module alu_ctrl
(
    input [3:0] ALUOp,
    input [1:0] Function,
    input carry_in,
    input zero_in,
    output reg  [1:0] ALU_Control
);

    wire [5:0] ALUControlIn;
    assign ALUControlIn = {ALUOp,Function};

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
            ADD: ALU_Control = 2'b00;                           // ADD
            ADC: ALU_Control = (carry_in == 1) ? 2'b00: 2'b10;  // if carry_in is 1, then ALU_Control = 2'b00, otherwise 2'b10
            ADZ: ALU_Control = (zero_in == 1) ? 2'b00: 2'b10;   // if zero_in is 1, then ALU_Control = 2'b00, otherwise 2'b10
            ADL: ALU_Control =  2'b00;                          // ADD
            {ADI,2'b00}: ALU_Control = 2'b00;                   // ADD
            NDU: ALU_Control = 2'b01;                            // NAND
            NDC: ALU_Control =  (carry_in == 1) ? 2'b01: 2'b10;  // if carry_in is 1, then ALU_Control = 2'b01, otherwise 2'b10
            NDZ: ALU_Control =  (zero_in == 1) ? 2'b01: 2'b10;   // if zero_in is 1, then ALU_Control = 2'b01, otherwise 2'b10
            default: ALU_Control = 3'b010;                        // NOP
        endcase
    end

endmodule


