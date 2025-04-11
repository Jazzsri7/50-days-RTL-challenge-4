module clk_buffer(in,out);
	input in;
	output out;
	
	buf B1(out,in);
	
endmodule
