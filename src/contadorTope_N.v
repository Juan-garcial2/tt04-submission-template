module contadorTope_N #(parameter N = 4'd9)(
	input i_En,
	input i_GRst,
	input i_Clk,
	input [3:0] i_A,
	input [3:0] i_B,
	output [3:0] o_Q
);

reg [3:0]r_D;
reg [3:0] r_Q;

//Asignación continua
assign o_Q = r_Q;

//Lo secuencial
always@(posedge i_Clk)
begin
	if(i_GRst) //Reset 
	begin
	r_Q <= 4'b0;
	end
	else if(i_En)
	begin
	
		if(r_Q == N) //Tope
		begin
			r_D = 4'd9;
		end
		else
		begin
			r_D = i_A+i_B;
		end
		r_Q<=r_D;
	end
	else
	begin
		r_Q <= r_Q;
	end
end
/*
//Lo combinacional
always@*
begin
	if(r_Q == N) //Tope
	begin
		r_D = 4'd9;
	end
	else
	begin
		r_D = i_A+i_B;
	end
end
*/
endmodule
