module FIFO(wr_en,rd_en,rst,clk,in,out,empty,full);
	input  wr_en,rd_en,rst,clk;
	input [7:0]in;
	output reg [7:0] out;
	output empty,full;
	
	reg [4:0] fifo_counter;
	reg [3:0] wr_ptr;
	reg [3:0] rd_ptr;
	
	reg [7:0] mem [15:0];
	
	integer i;
	
	always@(posedge clk)
	begin
		if(rst)
		begin
			
			wr_ptr <=0;
			for(i=0;i<16;i=i+1)
				mem[i] <=0;
		end
		
		else if(wr_en==1&&full==1'b0)
		begin
			mem[wr_ptr] <= in;
			wr_ptr <= wr_ptr+1;
		end
		
		else
			wr_ptr <= wr_ptr;
	end
	
	always@(posedge clk)
	begin
		if(rst)
		begin
			out<=0;
			rd_ptr<=0;
		end
		
		else if(rd_en==1&&empty==1'b0)
		begin
			out <= mem[rd_ptr];
			rd_ptr <= rd_ptr+1;
		end
		
		else 
			rd_ptr<=rd_ptr;
	end
	
	always@(posedge clk)
	begin
		if(rst)
			fifo_counter<=0;
		else if(wr_en && !full)
			fifo_counter<=fifo_counter+1;
		else if(rd_en && !empty)
			fifo_counter<=fifo_counter-1;
		else
			fifo_counter<=fifo_counter;
	end
	
	assign full=(fifo_counter>5'b01111)?1'b1:1'b0;
	assign empty=(fifo_counter==5'b00000)?1'b1:1'b0;
	
endmodule
