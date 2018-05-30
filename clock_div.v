module clock_div(resetn,input_clk, output_clk);
input input_clk,resetn;
output reg output_clk;
initial
begin
	output_clk = 0;
end
always @(posedge input_clk)
begin
	if(~resetn)
		output_clk <= 0;
	output_clk <= ~output_clk;
end
endmodule