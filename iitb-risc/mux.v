module mux21(O,A,B,sel);  
 // sel = 0 => O = A  
 // sel = 1 => O =B  
parameter IN_WIDTH = 1;
parameter OUT_WIDTH = 1;

 output reg [OUT_WIDTH-1:0] O;  
 input [IN_WIDTH-1:0] A,B;
 input sel;

 always @(*) 
     case(sel)
         0: O = A;
         1: O = B;
    endcase
endmodule  

module mux41(O,A,B,C,D,sel);  
// sel = 0 => O = A  
// sel = 1 => O = B 
// sel = 2 => O = C
// sel = 3 => O = D 
parameter IN_WIDTH = 1;
parameter OUT_WIDTH = 1;

 output reg [OUT_WIDTH-1:0] O;  
 input [IN_WIDTH-1:0] A,B,C,D;
 input [1:0] sel;

 always @(*) 
     case(sel)
         0: O = A; 
         1: O = B; 
         2: O = C; 
         3: O = D; 
    endcase
endmodule  