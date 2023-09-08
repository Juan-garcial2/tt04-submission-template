
//DIVISOR

module divisor
(
	input i_clk, 
	input i_rst, 
	input i_CE, 
	output o_divf
); 
	reg r_clk_d; 
	reg r_clk_q; 
	reg [25:0] contador_d; 
	reg [25:0] contador_q; 
	
	assign o_divf = r_clk_q;
	
always@(posedge i_clk) 
	begin 
	if(i_rst) 
		begin 
		  r_clk_q <= 1'b0; 
		  contador_q <= 1'b0; 
		end
	else if(i_CE) 
		begin 
		
		if(contador_q <= 26'd100) //249
		   begin
			  contador_d = contador_q + 1'd1; 
			  r_clk_d = 0; 
		   end
		else
		   begin
		     contador_d = 0; 
		     r_clk_d = 1'd1; 
		   end
		   
		  r_clk_q <= r_clk_d; 
		  contador_q <= contador_d; 
		end 
	else 
		begin 
		  r_clk_q <= r_clk_q; 
		  contador_q <= contador_q; 
		end 
	end 
/*
always@*
	begin 
		if(contador_q <= 26'd100) //249
		   begin
			  contador_d = contador_q + 1'd1; 
			  r_clk_d = 0; 
		   end
		else
		   begin
		     contador_d = 0; 
		     r_clk_d = 1'd1; 
		   end
   end 
	*/	
endmodule
