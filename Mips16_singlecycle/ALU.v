//fpga4student.com: FPga projects, Verilog projects, VHDL projects
// Verilog code for ALU
module alu(       
      input          [15:0]     a,          //src1  
      input          [15:0]     b,          //src2  
      input          [2:0]     alu_control,     //function sel  
      output     reg     [15:0]     result,          //result       
      output zero  
   );
wire [15:0]     sll_temp, srl_temp;
sll_barrel sll0(.a(a), .b(b[2:0]), .c(sll_temp));
srl_barrel srl0(.a(a), .b(b[2:0]), .c(srl_temp));

 always @(*)  //fpga4student.com: FPga projects, Verilog projects, VHDL projects
 begin   
      case(alu_control)  
      3'b000: result = a + b; // add  
      3'b001: result = a - b; // sub  
      3'b010: result = a & b; // and  
      3'b011: result = a | b; // or  
      3'b100: begin if (a<b) result = 16'd1;  
                     else result = 16'd0;  
                     end
      3'b101: result = a[7:0] * b[7:0]; // mul
      3'b110: result = sll_temp; // shift left 
      3'b111: result = srl_temp; // shift right 
      default:result = a + b; // add  
      endcase  
 end  
 assign zero = (result==16'd0) ? 1'b1: 1'b0;  
 endmodule  