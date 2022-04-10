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
        JAL $R4, -4;

 */
    reg [15:0] rom [16:0];
    integer i;
    

    assign instruction = (pc[15:0] < 48) ? rom[rom_addr]: 16'b0111000000000000;

    always @(posedge clk)
		begin
			if(reset== 1'b1)
				begin
					for(i=0;i<16;i=i+1) rom[i] =  16'b0000000000000000; // nop
				end
            else begin
                rom[0] = 16'b0111000000000000;
                rom[1] = 16'b0000000000000111; // ADDI $R0, $R0, 7;
                rom[2] = 16'b0000001001000100; // ADDI $R1, $R1, 4;
                rom[3] = 16'b0001000001010000; // ADD $R0, $R1, $R2;
                rom[4] = 16'b0010000010011000; // NDU $R0, $R1, $R3;
                rom[5] = 16'b0000001001000001; // ADDI $R1, $R1, 1;
                rom[6] = 16'b0000000000111111; // ADDI $R0, $R0, -1;
                rom[7] = 16'b1011100000000011; // JRI $R4, 3;
                // rom[6] = 16'b0000000000000000; // NOP
                // rom[7] = 16'b0000000000000000; // NOP
                // rom[8] = 16'b0000000000000000; // NOP
                // rom[9] = 16'b0000000000000000; // NOP
                // rom[10] = 16'b0000000000000000; // NOP
                // rom[11] = 16'b0000000000000000; // NOP
                // rom[12] = 16'b0000000000000000; // NOP
                // rom[13] = 16'b0000000000000000; // NOP
                // rom[14] = 16'b0000000000000000; // NOP
                // rom[15] = 16'b0000000000000000; // NOP
            end

        end		
endmodule