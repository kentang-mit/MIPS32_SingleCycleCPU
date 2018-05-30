module sc_datamem (addr,datain,dataout,we,clock,mem_clk,dmem_clk,resetn,in_port0,in_port1,out_port0,out_port1,out_port2);
 
   input  [31:0]  addr;
   input  [31:0]  datain;
   
   input          we, clock, mem_clk;
	input [3:0]	in_port0, in_port1;
	output [31:0]	out_port0, out_port1, out_port2;
   output [31:0]  dataout;
   output        	dmem_clk;
	input				resetn;
   wire [31:0]		io_read_data;
	wire [31:0]		mem_dataout;
   wire           dmem_clk;    
   wire           write_enable, write_io_enable, write_datamem_enable; 
   assign         write_enable = we & ~clock; 
   
   assign         dmem_clk = mem_clk & ( ~ clock) ; 
   assign 			write_io_enable = addr[7] & write_enable;
	assign			write_datamem_enable = ~addr[7] & write_enable;
	

   mux2x32 mem_io_dataout_mux(mem_dataout,io_read_data,addr[7],dataout);
	ram  dram(addr[6:2],dmem_clk,datain,write_datamem_enable,mem_dataout);
	io_input_reg io_input_regx2(addr,dmem_clk,io_read_data,in_port0,in_port1);
	io_output_reg io_output_regx2(addr,datain,write_io_enable,dmem_clk,resetn,out_port0,out_port1,out_port2);
endmodule 