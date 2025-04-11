module clk_buffer_tb();
	reg in_clk;
	wire out_clk;
	
	realtime t1,t2,t3,t4,t5,t6;
	
	clk_buffer dut(.in(in_clk),.out(out_clk));
	
	initial 
	begin
		#1;
		in_clk=1'b1;
		forever #5 in_clk=~in_clk;
	end
	
	task inp_clk;
	begin
		@(posedge in_clk) t1=$realtime;
		@(posedge in_clk) t2=$realtime;
		t3=t2-t1;
	end
	endtask
	
	task outp_clk;
	begin
		@(posedge out_clk) t4=$realtime;
		@(posedge out_clk) t5=$realtime;
		t6=t5-t4;
	end
	endtask
	
	task phase;
	//realtime f,p;
	begin
		
		if(t6==t3)
			$display(" %t %t freq is matching",t6,t3);
		else
			$display(" %t %t freq is not matching",t6,t3);
		if((t1==t4)&&(t2==t5))
			$display(" %t %t phase is matching", t1,t4);
		else 
			$display(" %t %t phase is not matching", t1,t4);
	end
	endtask
	
	initial
	begin
		fork
			inp_clk;
			outp_clk;
		join
		phase;
		#50 $finish;
	end
endmodule
