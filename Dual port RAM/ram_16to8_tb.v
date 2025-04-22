module ram_16to8_tb();

	parameter width = 8,
			  depth = 16,
			  addr = 4;
	
	reg [width-1 : 0] wr_data;
	reg [addr-1 : 0] rd_addr,wr_addr;
	reg clk,rst,re,we;
	wire [width-1 : 0] d_out;
	
	ram_16to8 dut(.wr_addr(wr_addr),.wr_data(wr_data),.re(re),.we(we),.clk(clk),.rst(rst),.rd_addr(rd_addr),.d_out(d_out));
	
	initial 
	begin
		clk=1'b1;
		forever #5 clk=~clk;
	end
	
	task initialise;
	begin
		{re,we}=2'b0;
		{rd_addr,wr_addr}=0;
		wr_data = 0;
	end
	endtask
	
	task reset;
	begin
		@(negedge clk)
			rst = 1'b1;
		@(negedge clk)
			rst = 1'b0;
	end
	endtask
	
	task write;
	input [addr-1 : 0] adr;
	input [width-1 : 0] din;
	input en;
	begin
		@(negedge clk) 
			wr_addr=adr; 
			wr_data=din;
			we=en;
			
	end
	endtask
	
	task read;
	input [addr-1 : 0] i;
	input ctrl;
	begin
		@(negedge clk) 
			rd_addr=i; 
			re=ctrl;
	end
	endtask
	
	initial 
	begin
		initialise;
		reset;
		write(4'h1, 8'hAA, 1'b1);
        write(4'h2, 8'hBB, 1'b1);
        write(4'h3, 8'hCC, 1'b1);
        read(4'h1, 1'b1);
        read(4'h2, 1'b1);
        read(4'h3, 1'b1);

        #50 $finish;
    end

endmodule
