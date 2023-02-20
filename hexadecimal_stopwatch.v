// Group 3 CPE102L/A13
module hexadecimal_stopwatch (clock, pause, reset, seven_segment_0, seven_segment_1, seven_segment_2, seven_segment_3);

// Inputs: 50 MHZ Clock, SW0 for the Pause Switch, SW1 for the Reset Switch
input clock, pause, reset;

// Outputs: Four Seven Segment, Cathode
output reg [6:0]seven_segment_0;
output reg [6:0]seven_segment_1;
output reg [6:0]seven_segment_2;
output reg [6:0]seven_segment_3;

// Creates the input code
reg [3:0] seven_segment_register_0;
reg [3:0] seven_segment_register_1;
reg [3:0] seven_segment_register_2;
reg [3:0] seven_segment_register_3;


// Timer for the clock, Since the Clock is 50 MHZ, one clock cycle would be 50,000,000
reg [32:0] clock_counter;
localparam clock_cycle = 50000000;

// Binary form for each hexadecimal values
localparam	H0 = 7'b1000000,
			H1 = 7'b1111001,
			H2 = 7'b0100100,
			H3 = 7'b0110000,
			H4 = 7'b1001100,
			H5 = 7'b0100100,
			H6 = 7'b0100000,
			H7 = 7'b0001111,
			H8 = 7'b0000000,
			H9 = 7'b0000100,
			HA = 7'b0001000,
			HB = 7'b1100000,
			HC = 7'b0110001,
			HD = 7'b1000010,
			HE = 7'b0110000,
			HF = 7'b0111000;

// BCD of each input
localparam	S0 = 4'b0000,
			S1 = 4'b0001,
			S2 = 4'b0010,
			S3 = 4'b0011,
			S4 = 4'b0100,
			S5 = 4'b0101,
			S6 = 4'b0110,
			S7 = 4'b0111,
			S8 = 4'b1000,
			S9 = 4'b1001,
			SA = 4'b1010,
			SB = 4'b1011,
			SC = 4'b1100,
			SD = 4'b1101,
			SE = 4'b1110,
			SF = 4'b1111;

always @ (*) begin

	// Translates the input of seven_segment_0 to a hexadecimal output
	case (seven_segment_register_0)
		S0: seven_segment_0 <= H0;
		S1: seven_segment_0 <= H1;
		S2: seven_segment_0 <= H2;
		S3: seven_segment_0 <= H3;
		S4: seven_segment_0 <= H4;
		S5: seven_segment_0 <= H5;
		S6: seven_segment_0 <= H6;
		S7: seven_segment_0 <= H7;
		S8: seven_segment_0 <= H8;
		S9: seven_segment_0 <= H9;
		SA: seven_segment_0 <= HA;
		SB: seven_segment_0 <= HB; 
		SC: seven_segment_0 <= HC;
		SD: seven_segment_0 <= HD;
		SE: seven_segment_0 <= HE; 
		SF: seven_segment_0 <= HF; 
		default: seven_segment_0 <= H0;
	endcase
	
	// Translates the input of seven_segment_1 to a hexadecimal output
	case (seven_segment_register_1)
		S0: seven_segment_1 <= H0;
		S1: seven_segment_1 <= H1;
		S2: seven_segment_1 <= H2;
		S3: seven_segment_1 <= H3;
		S4: seven_segment_1 <= H4;
		S5: seven_segment_1 <= H5;
		S6: seven_segment_1 <= H6;
		S7: seven_segment_1 <= H7;
		S8: seven_segment_1 <= H8;
		S9: seven_segment_1 <= H9;
		SA: seven_segment_1 <= HA;
		SB: seven_segment_1 <= HB; 
		SC: seven_segment_1 <= HC;
		SD: seven_segment_1 <= HD;
		SE: seven_segment_1 <= HE; 
		SF: seven_segment_1 <= HF; 
		default: seven_segment_1 <= H0;
	endcase

	// Translates the input of seven_segment_2 to a hexadecimal output
	case (seven_segment_register_2)
		S0: seven_segment_2 <= H0;
		S1: seven_segment_2 <= H1;
		S2: seven_segment_2 <= H2;
		S3: seven_segment_2 <= H3;
		S4: seven_segment_2 <= H4;
		S5: seven_segment_2 <= H5;
		S6: seven_segment_2 <= H6;
		S7: seven_segment_2 <= H7;
		S8: seven_segment_2 <= H8;
		S9: seven_segment_2 <= H9;
		SA: seven_segment_2 <= HA;
		SB: seven_segment_2 <= HB; 
		SC: seven_segment_2 <= HC;
		SD: seven_segment_2 <= HD;
		SE: seven_segment_2 <= HE; 
		SF: seven_segment_2 <= HF; 
		default: seven_segment_2 <= H0;
	endcase

	// Translates the input of seven_segment_3 to a hexadecimal output
	case (seven_segment_register_3)
		S0: seven_segment_3 <= H0;
		S1: seven_segment_3 <= H1;
		S2: seven_segment_3 <= H2;
		S3: seven_segment_3 <= H3;
		S4: seven_segment_3 <= H4;
		S5: seven_segment_3 <= H5;
		S6: seven_segment_3 <= H6;
		S7: seven_segment_3 <= H7;
		S8: seven_segment_3 <= H8;
		S9: seven_segment_3 <= H9;
		SA: seven_segment_3 <= HA;
		SB: seven_segment_3 <= HB; 
		SC: seven_segment_3 <= HC;
		SD: seven_segment_3 <= HD;
		SE: seven_segment_3 <= HE; 
		SF: seven_segment_3 <= HF; 
		default: seven_segment_3 <= H0;
	endcase
end

always @ (posedge clock) begin

	// If the reset switch [SW1] is on, the clock counter and all the registers of the seven segment will return to zero.
	if (reset == 1) begin
		clock_counter <= 0;
		seven_segment_register_0 <= S0; 
		seven_segment_register_1 <= S0;
		seven_segment_register_2 <= S0;
		seven_segment_register_3 <= S0;
	// If the pause switch [SW0] is on, the clock counter would return to zero, while the segment registers will keep their values
	end else if (pause == 1) begin
		clock_counter <= 0;
		seven_segment_register_0 <= seven_segment_register_0; 
		seven_segment_register_1 <= seven_segment_register_1;
		seven_segment_register_2 <= seven_segment_register_2;
		seven_segment_register_3 <= seven_segment_register_3;
	/*
	The stopwatch function:
	
	The clock counter will count until one clock cycle
	If seven_segment_register_0 is not 7'b1111111, it will increment until it is equal to the condition
	Once the condition is met, the seven_segment_register_0 will reset to zero and increment the next register
	This goes the same for all register until seven_segment_register_3, which will hold the values until reset
	*/
	end else begin
		clock_counter <= clock_counter + 1;
		if (clock_counter == clock_cycle) begin 
			if (seven_segment_register_0 == SF) begin
				seven_segment_register_0 <= 0;
				seven_segment_register_1 <= seven_segment_register_1 + 1;
				clock_counter <= 0;
			end else begin
				seven_segment_register_0 <= seven_segment_register_0 + 1;
				clock_counter <= 0;
			end
			
			if (seven_segment_register_1 == SF) begin
				seven_segment_register_0 <= 0;
				seven_segment_register_1 <= 0;
				seven_segment_register_2 <= seven_segment_register_2 + 1;
				clock_counter <= 0;
			end
			
			if (seven_segment_register_2 == SF) begin
				seven_segment_register_0 <= 0;
				seven_segment_register_1 <= 0;
				seven_segment_register_2 <= 0;
				seven_segment_register_3 <= seven_segment_register_3 + 1;
				clock_counter <= 0;
			end
			
			if (seven_segment_register_3 == SF) begin
				seven_segment_register_0 <= SF;
				seven_segment_register_1 <= SF;
				seven_segment_register_2 <= SF;
				seven_segment_register_3 <= SF;
				clock_counter <= 0;
			end
		end
	end
end

endmodule



