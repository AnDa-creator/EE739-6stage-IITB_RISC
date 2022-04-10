// Verilog code for instruction memory
 module instr_mem          // a synthesisable rom implementation
 (
    input   [15:0]  pc,
    input clk, reset,
    output wire [15:0]  instruction
 );
    wire [3:0] rom_addr = pc[3:0];

/*
    ADDI $R0, $R0, 7;
    ADDI $R1, $R1, 4;
    Loop: 
        ADD $R0, $R1, $R2;
        NDU $R0, $R1, $R3;
        ADDI $R1, $R1, 1;
        JMP Loop;

 */
    reg [15:0] rom [16:0];
    integer i;
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
        rom[8] = 16'b0000000000000000; // NOP
        rom[9] = 16'b0000000000000000; // NOP
        rom[10] = 16'b0000000000000000; // NOP
        rom[11] = 16'b0000000000000000; // NOP
        rom[12] = 16'b0000000000000000; // NOP
        rom[13] = 16'b0000000000000000; // NOP
        rom[14] = 16'b0000000000000000; // NOP
        rom[15] = 16'b0000000000000000; // NOP
    end

    assign instruction = (pc[15:0] < 48) ? rom[rom_addr[3:0]]: 16'd0;

    always @(posedge clk)
		begin
			if(reset== 1'b1)
				begin
					for(i=0;i<16;i=i+1) rom[i] =  16'b0111000000000000; // nop
				end
        end		
endmodule