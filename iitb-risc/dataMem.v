 // SubModule :: Data Memory
 module data_memory  
 (  
      input                         clk,              // clock
      input                         rst,              // reset  signal
      input     [15:0]              mem_access_addr,  // address input, shared by read and write port
      input     [15:0]              mem_write_data,   // data to be written
      input                         mem_write_en,     // enable write port 
      input                         mem_read,         // enable read port
      output     [15:0]             mem_read_data  
 );  
      integer i;  
      reg [15:0] ram [4096:0];  
      wire [11 : 0] ram_addr = mem_access_addr[11 : 0]; 

      initial begin  
           for(i=0;i<4096;i=i+1)  
                ram[i] <= 16'd0;  
      end  
      always @(posedge clk) begin  
           if (mem_write_en && ~rst) begin 
                ram[ram_addr] <= mem_write_data;  
      end

      always @(posedge clk) begin
          if (rst) begin
              for(i=0;i<4096;i=i+1)  
                ram[i] <= 16'd0; 
      end  
      
      assign mem_read_data = (mem_read==1'b1) ? ram[ram_addr]: 16'd0;   
 endmodule  