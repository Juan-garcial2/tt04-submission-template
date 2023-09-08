module countToDisplay(
	input i_CLK,
	input i_Rst,
	input i_En,
	input [3:0] i_Count0,
	input [3:0] i_Count1,
	input [3:0] i_Count2,
	input [3:0] i_Count3,
	output [3:0] o_Q0,
	output [3:0] o_Q1,
	output [3:0] o_Q2,
	output [3:0] o_Q3
);

//Señales auxiliares
reg [3:0] r_D0;
reg [3:0] r_D1;
reg [3:0] r_D2;
reg [3:0] r_D3;

reg [3:0] r_Q0;
reg [3:0] r_Q1;
reg [3:0] r_Q2;
reg [3:0] r_Q3;

assign o_Q0 = r_Q0;
assign o_Q1 = r_Q1;
assign o_Q2 = r_Q2;
assign o_Q3 = r_Q3;

//Lo secuencial
always@(posedge i_CLK) begin
	if(i_Rst) begin
		r_Q0 <= 4'd0;
		r_Q1 <= 4'd0;
		r_Q2 <= 4'd0;
		r_Q3 <= 4'd0;
	end
	else if(i_En) begin
		if((i_Count0==4'd9)&(i_Count1==4'd9)&(i_Count2==4'd9)&(i_Count3==4'd9)) begin
			r_D0 = 4'b1111;
			r_D1 = 4'b1111;
			r_D2 = 4'b1111;
			r_D3 = 4'b0001;
		end
		else begin
			r_D0 = i_Count0;
			r_D1 = i_Count1;
			r_D2 = i_Count2;
			r_D3 = i_Count3;
		end
		r_Q0 <= r_D0;
		r_Q1 <= r_D1;
		r_Q2 <= r_D2;
		r_Q3 <= r_D3;
	end
	else begin
		r_Q0 <= r_Q0;
		r_Q1 <= r_Q1;
		r_Q2 <= r_Q2;
		r_Q3 <= r_Q3;
	end
end
/*
//Circuito combinacional que determina over load
always@*
begin
	if((i_Count0==4'd9)&(i_Count1==4'd9)&(i_Count2==4'd9)&(i_Count3==4'd9)) begin
		r_D0 = 4'b1111;
		r_D1 = 4'b1111;
		r_D2 = 4'b1111;
		r_D3 = 4'b0001;
	end
	else begin
		r_D0 = i_Count0;
		r_D1 = i_Count1;
		r_D2 = i_Count2;
		r_D3 = i_Count3;
	end
end
*/
endmodule
