//fpga4student.com: FPga projects, Verilog projects, VHDL projects
// Verilog code for instruction memory
 module instr_mem          // a synthesisable rom implementation  
 (  
      input     [15:0]     pc,  
      output wire     [15:0]          instruction  
 );  
      wire [2 : 0] rom_addr = pc[3 : 1];  
      /*   
      NOP
      addi $r1, $r1, 7;
      addi $r2, $r2, 5;
      add  $r3, $r1, $r2;
      mul  $r4, $r1, $r2;
      addi $r5, $r5, 1;
      sll $r6, $r1, $r5; 
      sll_test $r7, $r1, $r5;
 */  
      reg [15:0] rom[7:0];  
      initial  
      begin
          rom[0] = 16'b0000000000000000; // NOP   
          rom[1] = 16'hE48F; // addi R1 15 R1=15
          rom[2] = 16'hE904; // addi R2 4 R2=4
          rom[3] = 16'hF206; // addi R4 6 R4=6
          rom[4] = 16'hFB30; // addi R6 48 R6=48
          rom[5] = 16'h0535; // mul R3 R1 R2 R3=R1*R2
          rom[6] = 16'h1156; // sll R5 R4 R2 R5=R4<<R2
          rom[7] = 16'h1907; // srl R0 R6 R2 R0=R6>>R2
          
               //  rom[0] = 16'b0000000000000000; // NOP
               //  rom[1] = 16'b1110010010000111; // addi $r1, $r1, 7; 
               //  rom[2] = 16'b1110100100000101; // addi $r2, $r2, 5;
               //  rom[3] = 16'b0000100010110000; // add  $r3, $r1, $r2;
               //  rom[4] = 16'b0000100011000101; // mul  $r4, $r1, $r2;
               //  rom[5] = 16'b1111011010000001; // addi $r5, $r5, 1;
               //  rom[6] = 16'b0000011011100110; // sll $r6, $r1, $r5;
               //  rom[7] = 16'b0000011011110111; // srl $r7, $r1, $r5;
                 
      end  
      assign instruction = (pc[15:0] < 48 )? rom[rom_addr[2:0]]: 16'd0;  
 endmodule   