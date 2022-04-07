// SubModule ALU
module alu
(
    input   [15:0]  a,              //src1
    input   [15:0]  b,              //src2
    input   [1:0]   alu_control,     //Control signal for ALU
    output reg [15:0]   result,     //result
    output reg zero,                          //zero
    output reg carry                          //carry
);

    reg [16:0] total_sum;

    initial begin
        zero = 1'b0;
        carry = 1'b0;
        result = 0;
    end

    always @(*) begin
        case(alu_control)
            2'b00: total_sum = {1'b0, a} + {1'b0, b};   // add
            2'b01: result = ~(a & b);                 // Nand
            default: result = 0;                       // NOP
        endcase
    end

    always @(*) begin
        result = (alu_control == 2'b00) ? total_sum[15:0]: result;                       //result
        zero = (result == 16'd0) ? 1'b1: 1'b0;                                             //zero
        carry = (total_sum[16] == 1'b1) ? 1'b1: 1'b0;                                      //carry
    end

endmodule