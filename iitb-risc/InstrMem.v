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
					for(i=0;i<16;i=i+1) rom[i] = 16'b0111000000000000; // nop
				end
            else begin
                rom[0] = 16'b0111000000000000;
                rom[1] = 16'b0000000000011111; // ADDI $R0, $R0, 31;
                rom[2] = 16'b0000000000100001; // ADDI $R0, $R0, -31;
                rom[3] = 16'b0000001001000100; // ADDI $R1, $R1, 4;
                rom[4] = 16'b0001000001010001; // ADDZ $R0, $R1, $R2;
                // rom[5] = 16'b0011000100000000; // LHI $R0, #100000000;
                // rom[6] = 16'b0010100101011000; // NDU $R4, $R5, $R3;
                // rom[7] = 16'b0001000000000000; // ADD $R0, $R0, $R0;
                // rom[8] = 16'b0001001010000010; // ADDC $R1, $R2, $R0;
                // rom[2] = 16'b0101000001000000; // SW $R0, $R1, 0;
                // rom[3] = 16'b0101000001000001; // SW $R0, $R1, 1;
                // rom[4] = 16'b0101000001000100; // SW $R0, $R1, 4;
                // rom[5] = 16'b1110010000000000; // LA $R2;
                // rom[6] = 16'b1111000000000000; // SA $R0;
                // rom[5] = 16'b1100010010100000; // LM $R2, 010100000;
                // rom[6] = 16'b1101010010001010; // SM $R2, 010001010;
                // rom[4] = 16'b0100010001000000; // LW $R2, $R1, 0;
                


                // rom[3] = 16'b0001000000000000; // ADD $R0, $R0, $R0;
                // rom[4] = 16'b0010000010011000; // NDU $R0, $R1, $R3;
                // rom[5] = 16'b0000001001000001; // ADDI $R1, $R1, 1;
                // rom[6] = 16'b0000000000000001; // ADDI $R0, $R0, 1;
                // rom[7] = 16'b1011100000000011; // JRI $R4, 3;

            end

        end		
endmodule