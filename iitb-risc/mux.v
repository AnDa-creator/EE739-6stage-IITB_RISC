module mux_21
#(
    parameter IN_WIDTH = 16,
    parameter OUT_WIDTH = 16
) 
(
    output reg [OUT_WIDTH-1:0] O,
    input [IN_WIDTH-1:0] A, B,
    input sel
);
 // sel = 0 => O = A
 // sel = 1 => O =B

    always @(*)
        case(sel)
            0: O = A;
            1: O = B;
        endcase
endmodule

module mux_16_bit_4_input
#(
    parameter IN_WIDTH = 1,
    parameter OUT_WIDTH = 1
) 
(
    output reg [OUT_WIDTH-1:0] O,
    input [IN_WIDTH-1:0] A, B, C, D,
    input [1:0] sel
);
// sel = 0 => O = A
// sel = 1 => O = B
// sel = 2 => O = C
// sel = 3 => O = D
    always @(*)
    case(sel)
        0: O = A;
        1: O = B;
        2: O = C;
        3: O = D;
    endcase
endmodule