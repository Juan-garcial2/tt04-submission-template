module contadorPulsos(
		input i_En,
		input i_Rst,
		input i_Pulso,
		output [3:0] o_Q0,
		output [3:0] o_Q1,
		output [3:0] o_Q2,
		output [3:0] o_Q3
);

//Señales auxiliares
wire [3:0] w_M01; //0=>1

wire [3:0] w_M1;
wire [3:0] w_M12;
assign w_M12 = w_M01 & w_M1; //1=>2

wire [3:0] w_M2;
wire [3:0] w_M23;
assign w_M23 = w_M12 & w_M2; //2=>3


contadorUnidades contador0(
	.i_En(i_En),
	.i_GRst(i_Rst),
	.i_Clk(i_Pulso),
	.i_A(o_Q0),
	.i_B(4'd1),
	.i_OL(o_Q3&o_Q2&o_Q1),
	.o_Q(o_Q0),
	.o_M1(w_M01)
);

contadorUnidades contador1(
	.i_En(i_En),
	.i_GRst(i_Rst),
	.i_Clk(i_Pulso),
	.i_A(o_Q1),
	.i_B(w_M01),
	.i_OL(o_Q3&o_Q2),
	.o_Q(o_Q1),
	.o_M1(w_M1)
);

contadorUnidades contador2(
	.i_En(i_En),
	.i_GRst(i_Rst),
	.i_Clk(i_Pulso),
	.i_A(o_Q2),
	.i_B(w_M12),
	.i_OL(o_Q3),
	.o_Q(o_Q2),
	.o_M1(w_M2)
);

contadorTope_N contador3(
	.i_En(i_En),
	.i_GRst(i_Rst),
	.i_Clk(i_Pulso),
	.i_A(o_Q3),
	.i_B(w_M23),
	.o_Q(o_Q3)
);



endmodule
