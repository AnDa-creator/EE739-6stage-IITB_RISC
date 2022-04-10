// // creating a module for n bit register
module register_n
#(parameter N = 16)
(
	input  [N-1:0] in,
    input clk, reset, enable,
	output reg [N-1:0] out
);

	always @(posedge clk)
    if (reset)
	    out <= {N{1'b0}};
	else if (enable)
	   out <= in;

endmodule


module register_bank
(
	input  [15:0] writeData, pcWriteData,
	input  [2:0]  readAddress1, readAddress2, writeAddress,
	input	writeEnable, clk, reset, pcWriteEnable,
	output reg [15:0] readData1, readData2,
	output reg [127:0] readData_R7_to_R0 // 112 bit long sequence read for SA and SM instructions {R7 R6 R5 R4 R3 R2 R1 R0}
);
		
	reg [15:0] registerFile [0:7];
	integer i = 0;
	
	initial 
    begin 
	    for (i=0; i<8; i=i+1) begin
	        registerFile[i] = 16'b0;
        end
       
	    readData1 = 16'b0;
	    readData2 = 16'b0;
	    readData_R7_to_R0 = 127'b0;
    end
    
	always @(*) begin 
        readData1 = registerFile[readAddress1];
        readData2 = registerFile[readAddress2];
        readData_R7_to_R0 = {registerFile[7], registerFile[6], registerFile[5], registerFile[4], 
                registerFile[3], registerFile[2], registerFile[1], registerFile[0]};
	end

	always @(posedge clk) begin 
	    if (reset) begin 
            for (i=0; i<7 ; i=i+1) begin
                registerFile[i] = i; // This initialisation would be 0 in the final run...
            end
            registerFile[7] = 0; // pc starts @ loc 0
        end
        
        else begin
            if (writeEnable) begin 
                if (writeAddress < 7)
                registerFile[writeAddress] <= writeData;		   
            end
            if (pcWriteEnable) 
                registerFile[7] <= pcWriteData;
        end
	end

endmodule