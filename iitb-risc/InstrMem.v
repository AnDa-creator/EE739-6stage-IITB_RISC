// Verilog code for instruction memory
 module instr_mem          // a synthesisable rom implementation  
 (  
      input     [15:0]     pc,  
      output wire     [15:0]          instruction  
 );  
      wire [3 : 0] rom_addr = pc[4 : 1];  
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
      reg [15:0] rom[16:0];  
      initial  
      begin
          
                rom[0] = 16'b0000000000000000; // NOP
                rom[1] = 16'b1110010010000111; // addi $r1, $r1, 7; 
                rom[2] = 16'b1110100100000101; // addi $r2, $r2, 5;
                rom[3] = 16'b0000100010110000; // add  $r3, $r1, $r2;
                rom[4] = 16'b0000100011000101; // mul  $r4, $r1, $r2;
                rom[5] = 16'b1111011010000001; // addi $r5, $r5, 1;
                rom[6] = 16'b0000011011100110; // sll $r6, $r1, $r5;
                rom[7] = 16'b0000011011110111; // srl $r7, $r1, $r5;
                 
      end  
      assign instruction = (pc[15:0] < 48 )? rom[rom_addr[3:0]]: 16'd0;  
 endmodule   