module FIFO_tb();
	reg  wr_en,rd_en,rst,clk;
	reg [7:0]in;
	wire [7:0] out;
	wire empty,full;
	
	FIFO dut(.clk(clk),.rst(rst),.in(in),.out(out),.wr_en(wr_en),.rd_en(rd_en),.empty(empty),.full(full));
	
	task initialise;
	begin
		rst=1'b0;
		wr_en=1'b0;
		rd_en=1'b0;
		in=8'b0;
	end
	endtask
	
	initial 
	begin
		clk=1'b1;
		forever #5 clk=~clk;
	end
	
	task reset;
	begin
		@(negedge clk)
			rst=1'b1;
		@(negedge clk)
			rst=1'b0;
	end
	endtask
	
	task write;
	input [7:0] d;
	begin
		@(negedge clk)
			in=d;
			wr_en=1;
	end
	endtask
	
	task read;
	begin
		@(negedge clk)
			rd_en=1;
	end
	endtask
	
	initial 
	begin
		initialise;
		reset;
		repeat(17)
			write({$random}%32);
		wr_en=0;
		repeat(17)
			read();
		rd_en=1'b0;
		#100 $finish;
	end
endmodule
	
