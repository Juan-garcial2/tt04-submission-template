
module state_Machine(
	input [11:0] i_Lv,
	input i_CLK,
	input i_RST,
	output o_Pulse
);

reg r_D;
reg r_Q;

assign o_Pulse = r_Q;

always@(posedge i_CLK) begin
	if(i_RST) begin
		r_Q<=0;
	end
	else begin
		
		if(i_Lv>12'd2000)
		begin
			r_D = 1'd1;
		end
		else
		begin
			r_D = 1'd0;
		end
	
		r_Q<=r_D;
	end
end
/*
always@*
begin
	if(i_Lv>12'd2000)
	begin
		r_D = 1'd1;
	end
	else
	begin
		r_D = 1'd0;
	end
end

*/
endmodule 

/*module state_Machine(
	input i_CLK,
	input i_RST,
	input [11:0] i_Lv,
	output o_Pulse
);

//Declaracion de estados
localparam [1:0] s0 = 2'b00,
					  s1 = 2'b01,
					  s2 = 2'b10;
					  
//Declaracion de señales
reg [1:0] estado_act, estado_sig;
reg r_D;
reg r_Q;

//Link de flip flop con salida
assign o_Pulse = r_Q;

//Lo secuencial
always@(posedge i_CLK) begin
	if(i_RST) begin
		estado_act<=s0;
		r_Q<=1'd0;
	end	
	else begin
		estado_act<=estado_sig;
		r_Q<=r_D;
	end
end

//Lo combinacional
always@* begin
	case(estado_act)
		s0: begin
			if(i_Lv>12'd2048) begin
				estado_sig = s1;
				r_D = 1'd1;
			end
			else begin
				estado_sig = s0;
				r_D = 1'd0;
			end
		end
		s1: begin
			if(i_Lv>12'd2048) begin
				estado_sig = s2;
				r_D = 4'd0;
			end
			else begin
				estado_sig = s0;
				r_D = 4'd0;
			end
		end
		default: begin
			if(i_Lv<=12'd2048) begin
				estado_sig = s0;
				r_D = 1'd0;
			end
			else begin
				estado_sig = s2;
				r_D = 1'd0;
			end
		end
	endcase
end

endmodule
*/
