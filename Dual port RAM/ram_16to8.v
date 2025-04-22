module ram_16to8(wr_data,d_out,rd_addr,wr_addr,clk,we,re,rst);
	
	parameter width = 8,
			  depth = 16,
			  addr = 4;
	
	input [width-1 : 0] wr_data;
	input [addr-1 : 0] rd_addr,wr_addr;
	input clk,rst,re,we;
	output reg [width-1 : 0]d_out;
			  
	reg [(width-1):0] mem [(depth-1):0];
	
	integer i;
	
	always@(posedge clk)
	begin
		if(rst)
		begin
			d_out <= 0;
			for(i=0;i<15;i=i+1)
				mem[i] <= 0;
		end
		else 
		begin
			if(we)
				mem[wr_addr] <= wr_data;
		    if(re)
				d_out <= mem[rd_addr];
		end
	end 
	
endmodule 
