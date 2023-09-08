module tt_um_FreqMeter_Juan_Garcial(
 input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
 output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
 input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
output wire [7:0] uio_out,  // IOs: Bidirectional Output path
output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
input  wire       ena,      // will go high when the design is enabled
input  wire       clk,      // clock
input  wire       rst_n     // reset_n - low to reset 

);

//Salida ADC
	assign w_ADCout[7:0] = ui_in [7:0];
	assign w_ADCout[11:8] = uio_in [3:0];
	assign uo_out[1:0] = disp_select;
	assign uo_out[4:2] = segment_select;
	assign uo_out[5] = segments_;
	assign uo_out[7:6] = 0;
	assign uio_out = 0;
	assign uio_oe = 255;
	assign i_En = ena;
	assign i_RST = rst_n;
	assign i_CLK_adc = clk;
	
wire i_CLK_adc;
 wire i_RST;
 wire i_En;
wire [11:0] w_ADCout;
reg [1:0] disp_select;
reg [2:0] segment_select;
reg segments_;


	
//Pulso sumador
wire w_Pulse;

//Señal de reloj de referencia
wire w_CLK_1Hz;
wire w_CLK_Muestreo;

assign led = w_Pulse;
assign led2 = w_CLK_1Hz;


//Señales de contadores a countToDisplay
wire [3:0] w_D0;
wire [3:0] w_D1;
wire [3:0] w_D2;
wire [3:0] w_D3;

//Señales de countToDisplay a BCD
wire [3:0] w_Q0;
wire [3:0] w_Q1;
wire [3:0] w_Q2;
wire [3:0] w_Q3;
/*
//ADC
unnamed u0 (
		.CLOCK (i_CLK_adc), //      clk.clk
		.RESET (i_RST), //    reset.reset
		.CH0   (w_ADCout)   // readings.CH0
);
*/
//Detector de flancos
state_Machine state_Machine(
	.i_Lv(w_ADCout),
	.i_CLK(w_CLK_Muestreo),
	.i_RST(i_RST),
	.o_Pulse(w_Pulse)
);

//Divisor de frecuencias reseteo
divisor2 freqDiv(
	.i_clk(i_CLK_adc), 
	.i_rst(i_RST), 
	.i_CE(i_En), 
	.o_divf(w_CLK_1Hz)
);

//Divisor de frecuencias muestreo pulsos 
divisor freqDiv1(
	.i_clk(i_CLK_adc), 
	.i_rst(i_RST), 
	.i_CE(i_En), 
	.o_divf(w_CLK_Muestreo)
);


//Contador de pulsos
contadorPulsos contadorPulsos(
	.i_En(i_En),
	.i_Rst(w_CLK_1Hz|i_RST),
	.i_Pulso(w_Pulse),
	.o_Q0(w_D0),
	.o_Q1(w_D1),
	.o_Q2(w_D2),
	.o_Q3(w_D3)
);

//Count to display
countToDisplay countToDisplay(
	.i_CLK(w_CLK_1Hz),
	.i_Rst(i_RST),
	.i_En(i_En),
	.i_Count0(w_D0),
	.i_Count1(w_D1),
	.i_Count2(w_D2),
	.i_Count3(w_D3),
	.o_Q0(w_Q0),
	.o_Q1(w_Q1),
	.o_Q2(w_Q2),
	.o_Q3(w_Q3)
);

reg clk_500u;
reg [12:0] count_a;
reg [3:0] data_select;

 always@(*)begin
 
 	case(disp_select)
				    
		0: data_select = w_Q0; // 0
		1: data_select = w_Q1; // 1
	        2: data_select = w_Q2; // 2
	        3: data_select = w_Q3; // 3
		
		default: data_select = 4'b1111; // Display nothing or error
 
 	endcase
 end

reg [6:0] o_Unidades;

always@(*)begin //selection of module to send output
    
    case(segment_select)
            
            0: segments_ = o_Unidades[0]; // 0
            1: segments_ = o_Unidades[1]; // 1
            2: segments_ = o_Unidades[2]; // 2
            3: segments_ = o_Unidades[3]; // 3
            4: segments_ = o_Unidades[4]; // 4
            5: segments_ = o_Unidades[5]; // 5
            6: segments_ = o_Unidades[6]; // 5
            default: segments_ = 1'b1; // Display nothing or error
                        
        endcase
    
    end
  always@(posedge clk_500u,negedge i_RST)begin
    
    	if(i_RST == 0)begin
    	
    		segment_select = 0;
         	disp_select = 0;
    	
    	
    	end
    	else begin
    	
    		segment_select = segment_select + 1;
    		if(segment_select == 7)begin
    		
    			disp_select = disp_select +1;
    			segment_select = 0; 		
    		
    		end
    	
    	
    	end
    
         
    end


 always@(posedge i_CLK_adc)begin
    
        count_a = count_a +1;
        
        if(count_a < 5000)begin
            
            
            clk_500u = 0;
            
        end
        else begin
        
            clk_500u = 1;
            count_a = 0;
            
        end
    
    end

//BCD 0
BCD BCD_0(
	.in_A(data_select),
	.out_B(o_Unidades)
);
/*
//BCD 1
BCD BCD_1(
	.in_A(w_Q1),
	.out_B(o_Decenas)
);

//BCD 2
BCD BCD_2(
	.in_A(w_Q2),
	.out_B(o_Centenas)
);

//BCD 3
BCD BCD_3(
	.in_A(w_Q3),
	.out_B(o_Miles)
);
*/

endmodule
