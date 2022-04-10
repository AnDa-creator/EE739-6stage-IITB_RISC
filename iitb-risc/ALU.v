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
        result = (alu_control == 2'b00) ? total_sum[15:0]: result;                       //result
        if (alu_control == 2'b00 || alu_control == 2'b01) begin
            zero = (result == 0) ? 1'b1 : 1'b0;
            carry = (~(a[15] ^ b[15]) && (total_sum[15] ^ a[15])) ? 1'b1 : 1'b0;
        end
        else begin
            zero = 1'b0;
            carry = 1'b0;
        end
    end

endmodule