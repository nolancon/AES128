`timescale 1ns / 1ps


module wrapper_top(
    input wire clk,
    output wire [15:0] led
	);


	reg [127:0] cipher_text_temp;
	reg [127:0] cipher_text_reg;

	reg [127:0] key_;
	reg[15:0] led_reg;
	reg[7:0] temp0, temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9, temp10, temp11, temp12, temp13, temp14, temp15;
	
	wire [127:0] cipher_text;	
	
	always @(posedge clk)
    begin
        key_[127:0] = 128'h100F0E0D0C0B0A090807060504030201;	    
    end
    
    always @ *
	begin

	cipher_text_temp[127:0] = cipher_text[127:0];
	temp0 = cipher_text_reg[7:0];
	temp1 = cipher_text_reg[15:8];
	temp2 = cipher_text_reg[23:16];
	temp3 = cipher_text_reg[31:24];
	temp4 = cipher_text_reg[39:32];
	temp5 = cipher_text_reg[47:40];
	temp6 = cipher_text_reg[55:48];
	temp7 = cipher_text_reg[63:56];
	temp8 = cipher_text_reg[71:64];
	temp9 = cipher_text_reg[79:72];
	temp10 = cipher_text_reg[87:80];
	temp11 = cipher_text_reg[95:88];
	temp12 = cipher_text_reg[103:96];
	temp13 = cipher_text_reg[111:104];
	temp14 = cipher_text_reg[119:112];
	temp15 = cipher_text_reg[127:120];	

//Test cipher text bytes with LEDs  
//Simulation cipher_text output: 4b286e22c5d2113d01227cc2cdf88f39

	if (temp0[7:0] == 8'h39) 
		led_reg[0:0] = 1'b1;
	else
		led_reg[0:0] = 1'b0;
	
	if (temp1[7:0] == 8'h8f) 
		led_reg[1:1] = 1'b1;
	else
		led_reg[1:1] = 1'b0;
	
	if (temp2[7:0] == 8'hf8) 
		led_reg[2:2] = 1'b1;
	else
		led_reg[2:2] = 1'b0;
	
	if (temp3[7:0] == 8'hcd) 
		led_reg[3:3] = 1'b1;
	else
		led_reg[3:3] = 1'b0;
	
	if (temp4[7:0] == 8'hc2) 
		led_reg[4:4] = 1'b1;
	else
		led_reg[4:4] = 1'b0;
	
	if (temp5[7:0] == 8'h7c) 
		led_reg[5:5] = 1'b1;
	else
		led_reg[5:5] = 1'b0;
	
	if (temp6[7:0] == 8'h22) 
		led_reg[6:6] = 1'b1;
	else
		led_reg[6:6] = 1'b0;
	
	if (temp7[7:0] == 8'h01) 
		led_reg[7:7] = 1'b1;
	else
		led_reg[7:7] = 1'b0;
	
	if (temp8[7:0] == 8'h3d) 
		led_reg[8:8] = 1'b1;
	else
		led_reg[8:8] = 1'b0;
	
	if (temp9[7:0] == 8'h11) 
		led_reg[9:9] = 1'b1;
	else
		led_reg[9:9] = 1'b0;
	
	if (temp10[7:0] == 8'hd2) 
		led_reg[10:10] = 1'b1;
	else
		led_reg[10:10] = 1'b0;
	
	if (temp11[7:0] == 8'hc5) 
		led_reg[11:11] = 1'b1;
	else
		led_reg[11:11] = 1'b0;
	
	if (temp12[7:0] == 8'h22) 
		led_reg[12:12] = 1'b1;
	else
		led_reg[12:12] = 1'b0;
	
	if (temp13[7:0] == 8'h6e) 
		led_reg[13:13] = 1'b1;
	else
		led_reg[13:13] = 1'b0;
	
	if (temp14[7:0] == 8'h28) 
		led_reg[14:14] = 1'b1;
	else
		led_reg[14:14] = 1'b0;
		
	if (temp15[7:0] == 8'h4b)
		led_reg[15:15] = 1'b1;
	else
		led_reg[15:15] = 1'b0;
	

	end
	
	AES_top i_AES_top(
	    . clk(clk),
	    . key(key_),
	    . cipher_out(cipher_text));
	    
	assign led = led_reg;
	
endmodule 