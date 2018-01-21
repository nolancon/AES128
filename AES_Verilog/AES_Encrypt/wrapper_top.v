`timescale 1ns / 1ps


module wrapper_top(
    input wire clk,
//    input wire plain_text,
//    output wire cipher_text,
    output wire [15:0] led
	);


	reg [127:0] plain_text;
	reg [127:0] cipher_text_temp;
	reg [127:0] cipher_text_reg;
	reg [127:0] cipher_text_reg2;

	reg [127:0] key_;
	reg[15:0] led_;
	reg[7:0] temp0, temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9, temp10, temp11, temp12, temp13, temp14, temp15;
	
	wire [127:0] cipher_text;	
	wire [1407:0] expanded_key;
	
	always @(posedge clk)
    begin
        key_[127:0] = 128'h100F0E0D0C0B0A090807060504030201;
	   	cipher_text_reg [127:0] = 128'h4b286e22c5d2113d01227cc2cdf88f39;
		cipher_text_reg2 [127:0] = 128'ha71e174fed2f12b172c823be01041f87;
//	    							   4b286e22c5d2113d01227cc2cdf88f39
	    
    end
    
    always @ *
	begin
//	temp = cipher_text_reg[7:0];

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

	
		
//	if(cipher_text_temp[127:0]==cipher_text_reg[127:0])
//		led_[15:0] = 16'b1111111111111111;
//	else if (cipher_text_temp[127:0]==cipher_text_reg2[127:0])
//		led_[15:0] = 16'b1111111111111111;
//	else
//		led_[15:0] = 16'b1000000100000001;


//Test cipher text bytes with LEDs  
//Simulation cipher_text output4b286e22c5d2113d01227cc2cdf88f39


	if (temp0[7:0] == 8'h39) 
		led_[0:0] = 1'b1;
	else
		led_[0:0] = 1'b0;
	
	if (temp1[7:0] == 8'h8f) 
		led_[1:1] = 1'b1;
	else
		led_[1:1] = 1'b0;
	
	if (temp2[7:0] == 8'hf8) 
		led_[2:2] = 1'b1;
	else
		led_[2:2] = 1'b0;
	
	if (temp3[7:0] == 8'hcd) 
		led_[3:3] = 1'b1;
	else
		led_[3:3] = 1'b0;
	
	if (temp4[7:0] == 8'hc2) 
		led_[4:4] = 1'b1;
	else
		led_[4:4] = 1'b0;
	
	if (temp5[7:0] == 8'h7c) 
		led_[5:5] = 1'b1;
	else
		led_[5:5] = 1'b0;
	
	if (temp6[7:0] == 8'h22) 
		led_[6:6] = 1'b1;
	else
		led_[6:6] = 1'b0;
	
	if (temp7[7:0] == 8'h01) 
		led_[7:7] = 1'b1;
	else
		led_[7:7] = 1'b0;
	
	if (temp8[7:0] == 8'h3d) 
		led_[8:8] = 1'b1;
	else
		led_[8:8] = 1'b0;
	
	if (temp9[7:0] == 8'h11) 
		led_[9:9] = 1'b1;
	else
		led_[9:9] = 1'b0;
	
	if (temp10[7:0] == 8'hd2) 
		led_[10:10] = 1'b1;
	else
		led_[10:10] = 1'b0;
	
	if (temp11[7:0] == 8'hc5) 
		led_[11:11] = 1'b1;
	else
		led_[11:11] = 1'b0;
	
	if (temp12[7:0] == 8'h22) 
		led_[12:12] = 1'b1;
	else
		led_[12:12] = 1'b0;
	
	if (temp13[7:0] == 8'h6e) 
		led_[13:13] = 1'b1;
	else
		led_[13:13] = 1'b0;
	
	if (temp14[7:0] == 8'h28) 
		led_[14:14] = 1'b1;
	else
		led_[14:14] = 1'b0;
		
	if (temp15[7:0] == 8'h4b)
		led_[15:15] = 1'b1;
	else
		led_[15:15] = 1'b0;
	

	end
	
	AES_top i_AES_top(
	    . clk(clk),
	    . key(key_),
	    . cipher_out(cipher_text));
	    
//	    . plain_in(plain_text),
//	    . led(led),
//	    . expanded_key(expanded_key), 

	assign led = led_;
endmodule 