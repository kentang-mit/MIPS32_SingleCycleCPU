/////////////////////////////////////////////////////////////
//                                                         //
// School of Software of SJTU                              //
//                                                         //
/////////////////////////////////////////////////////////////

module sc_computer (resetn,mem_clk,in_port0,in_port1,out_port0,out_port1,out_port2,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
   
   //input resetn,clock,mem_clk;
	input resetn, mem_clk;
	wire clock;
	input [3:0]  in_port0, in_port1;
   //output [31:0] pc,inst,aluout,memout;
   wire [31:0] pc,inst,aluout,memout;
   //output        imem_clk,dmem_clk;
   wire imem_clk, dmem_clk;
   output [31:0] 	out_port0, out_port1, out_port2;
	wire	 [31:0] out_port0, out_port1, out_port2;
   wire   [31:0] data;
   wire          wmem; // all these "wire"s are used to connect or interface the cpu,dmem,imem and so on.
   output wire [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
	clock_div div(resetn,mem_clk,clock);
   sc_cpu cpu (clock,resetn,inst,memout,pc,wmem,aluout,data);          // CPU module.
   sc_instmem  imem (pc,inst,clock,mem_clk,imem_clk);                  // instruction memory.
   sc_datamem  dmem (aluout,data,memout,wmem,clock,mem_clk,dmem_clk,resetn,in_port0,in_port1,out_port0,out_port1,out_port2); // data memory.
	sevenseg ss0(out_port0[3:0],HEX0);
	sevenseg ss1(out_port0[7:4],HEX1);
	sevenseg ss2(out_port1[3:0],HEX2);
	sevenseg ss3(out_port1[7:4],HEX3);
	sevenseg ss4(out_port2[3:0],HEX4);
	sevenseg ss5(out_port2[7:4],HEX5);
endmodule



