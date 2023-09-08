module contadorUnidades #(parameter N = 4'd9)(
	input i_En,
	input i_GRst,
	input i_Clk,
	input [3:0] i_A,
	input [3:0] i_B,
	input [3:0] i_OL,
	output [3:0] o_Q,
	output reg [3:0] o_M1
);

reg [3:0]r_D;
reg r_Rst;
reg [3:0] r_Q;

//Asignación continua
assign o_Q = r_Q;

//Lo secuencial
always@(posedge i_Clk)
begin
	if(r_Rst | i_GRst) //Reset 
	begin
	r_Q <= 4'b0;
	end
	else if(i_En)
	begin
	
		r_D = i_A+i_B;
	if(r_Q == N)
	begin
		if(i_OL == 4'd9) begin
			r_D = 4'd9;
		end
		else begin
		o_M1 = 4'b0001;
		end
	end
	else
	begin
		o_M1 = 4'b0000;
	end
	
	if(r_Q == (N+1))
	begin
		r_Rst = 1'b1;
	end
	else
	begin
		r_Rst = 1'b0;
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
	r_D = i_A+i_B;
	if(r_Q == N)
	begin
		if(i_OL == 4'd9) begin
			r_D = 4'd9;
		end
		else begin
		o_M1 = 4'b0001;
		end
	end
	else
	begin
		o_M1 = 4'b0000;
	end
	
	if(r_Q == (N+1))
	begin
		r_Rst = 1'b1;
	end
	else
	begin
		r_Rst = 1'b0;
	end
end
*/
endmodule

