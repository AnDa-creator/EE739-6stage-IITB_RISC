// Logical Left Shift a by b bits.
module sll_barrel(
    input [15:0] a,
    input [2:0] b,
    output [15:0] c
);
// mux21(O,A,B,sel);  
// sel = 0 => O = A  
// sel = 1 => O =B  

wire [15:0]    ST1,ST2;

mux21 u0(ST1[0], a[0], 1'b0,  b[0]);
genvar i;
generate
    for (i = 0; i < 15; i = i + 1) begin : LshiftBy1
        mux21 u1(ST1[i+1], a[i+1], a[i],  b[0]);        
    end
endgenerate
mux21 u2(ST2[0], ST1[0], 1'b0,  b[1]);
mux21 u3(ST2[1], ST1[1], 1'b0,  b[1]);
generate
    for (i = 0; i < 14; i = i + 1) begin : LshiftBy2
        mux21 u4(ST2[i+2], ST1[i+2], ST1[i],  b[1]);        
    end
endgenerate
mux21 u5(c[0], ST2[0], 1'b0,  b[2]);
mux21 u6(c[1], ST2[1], 1'b0,  b[2]);
mux21 u7(c[2], ST2[2], 1'b0,  b[2]);
mux21 u8(c[3], ST2[3], 1'b0,  b[2]);
generate
    for (i = 0; i < 12; i = i + 1) begin : LshiftBy4
        mux21 u9(c[i+4], ST2[i+4], ST2[i],  b[2]);        
    end
endgenerate

endmodule

// Logical Right Shift a by b bits.
module srl_barrel(
    input [15:0] a,
    input [2:0] b,
    output [15:0] c
);
// mux21(O,A,B,sel);  
// sel = 0 => O = A  
// sel = 1 => O =B  

wire [15:0]    ST1,ST2;

mux21 u0(ST1[15], a[15], 1'b0,    b[2]);
mux21 u1(ST1[14], a[14], 1'b0,    b[2]);
mux21 u2(ST1[13], a[13], 1'b0,    b[2]);
mux21 u3(ST1[12], a[12], 1'b0,    b[2]);
genvar i;
generate
    for (i = 11; i >= 0; i = i - 1) begin : RshiftBy4
        mux21 u4(ST1[i], a[i], a[i + 4],   b[2]);        
    end
endgenerate
mux21 u5(ST2[15], ST1[15], 1'b0,    b[1]);
mux21 u6(ST2[14], ST1[14], 1'b0,    b[1]);
generate
    for (i = 13; i >= 0; i = i - 1) begin : RshiftBy2
        mux21 u7(ST2[i], ST1[i], ST1[i + 2],   b[1]);        
    end
endgenerate
mux21 u8(c[15], ST2[15], 1'b0,    b[0]);
generate
    for (i = 14; i >= 0; i = i - 1) begin : RshiftBy1
        mux21 u9(c[i], ST2[i], ST2[i + 1],   b[0]);        
    end
endgenerate
endmodule


