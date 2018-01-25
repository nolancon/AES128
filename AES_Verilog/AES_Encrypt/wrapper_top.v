`timescale 1ns / 1ps


module wrapper_top(
    input wire clk,
    output wire [15:0] led
	);

	wire[1407:0]expanded_key;
	wire [127:0] cipher_text;	
	
	reg [127:0] cipher_text_next;
	reg [127:0] cipher_text_reg;
	
	reg [1407:0]expanded_key_next;
	reg [1407:0]expanded_key_reg;
	
	wire [15:0] led_reg_;
	reg [15:0]led_reg;
	
	reg [127:0] key, plain_in;
	reg[15:0] led_reg_reg;
	reg[7:0] temp0, temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9, temp10, temp11, temp12, temp13, temp14, temp15;
	
	
	always @(posedge clk)
    begin
        key[127:0] <= 128'h100F0E0D0C0B0A090807060504030201;
	    plain_in[127:0] <= 128'h00FFFEFDFCFBFAF9F8F7F6F5F4F3F2F1;
	    
	    cipher_text_reg <= cipher_text_next;
	    expanded_key_reg <= expanded_key_next;
	    
	    led_reg_reg <= led_reg;
//	    temp0[7:0] <= cipher_text_temp[7:0];
//		temp1[7:0] <= cipher_text_temp[15:8];
//		temp2[7:0] <= cipher_text_temp[23:16];
//		temp3[7:0] <= cipher_text_temp[31:24];
//		temp4[7:0] <= cipher_text_temp[39:32];
//		temp5[7:0] <= cipher_text_temp[47:40];
//		temp6[7:0] <= cipher_text_temp[55:48];
//		temp7[7:0] <= cipher_text_temp[63:56];
//		temp8[7:0] <= cipher_text_temp[71:64];
//		temp9[7:0] <= cipher_text_temp[79:72];
//		temp10[7:0] <= cipher_text_temp[87:80];
//		temp11[7:0] <= cipher_text_temp[95:88];
//		temp12[7:0] <= cipher_text_temp[103:96];
//		temp13[7:0] <= cipher_text_temp[111:104];
//		temp14[7:0] <= cipher_text_temp[119:112];
//		temp15[7:0] <= cipher_text_temp[127:120];	
    end
    
   
    always @ *
	begin

	cipher_text_next[127:0] = cipher_text[127:0];
	expanded_key_next[1407:0] = expanded_key[1407:0];
	led_reg[15:0] = led_reg_[15:0];
		
//Test cipher text bytes with LEDs  
//Simulation cipher_text output : 4b286e22c5d2113d01227cc2cdf88f39

//	if (key[127:0] == 128'h100F0E0D0C0B0A090807060504030201) 
//		led_reg[10:10] = 1'b1;
//	else
//		led_reg[10:10] = 1'b0;
	
//	if (plain_in[127:0] == 128'h00FFFEFDFCFBFAF9F8F7F6F5F4F3F2F1) 
//		led_reg[11:11] = 1'b1;
//	else
//		led_reg[11:11] = 1'b0;
//
//	if (cipher_text_reg[127:0] == 128'h4b286e22c5d2113d01227cc2cdf88f39) 
//		led_reg[12:12] = 1'b1;
//	else
//		led_reg[12:12] = 1'b0;
//	
//	if (cipher_text_reg[127:0] == 128'h00000000000000000000000000000000) 
//		led_reg[13:13] = 1'b1;
//	else
//		led_reg[13:13] = 1'b0;
//	
//	if (expanded_key_reg[1407:1376] == 32'h8740b1b1) 
//		led_reg[14:14] = 1'b1;
//	else
//		led_reg[14:14] = 1'b0;
//	
//	if (expanded_key_reg[1407:1376] == 32'h00000000) 
//		led_reg[15:15] = 1'b1;
//	else
//		led_reg[15:15] = 1'b0;
//	
//	if (cipher_text_next[127:0] == 128'h4b286e22c5d2113d01227cc2cdf88f39) 
//		led_reg[1:1] = 1'b1;
//	else
//		led_reg[1:1] = 1'b0;
//	
//	if (cipher_text_next[127:0] == 128'h00000000000000000000000000000000) 
//		led_reg[6:6] = 1'b1;
//	else
//		led_reg[6:6] = 1'b0;
//	
//	if (expanded_key[1407:1376] == 32'h8740b1b1) 
//		led_reg[7:7] = 1'b1;
//	else
//		led_reg[7:7] = 1'b0;
//	
//	if (expanded_key_next[1407:1376] == 32'h00000000) 
//		led_reg[8:8] = 1'b1;
//	else
//		led_reg[8:8] = 1'b0;
//	if (temp0[7:0] == 8'h00) 
	
	
//	if (cipher_text_temp[7:0] == cipher_text[7:0]) 
//		led_reg[0:0] = 1'b1;
//	else
//		led_reg[0:0] = 1'b0;
//	
//	if (temp1[7:0] == 8'h00) 
//		led_reg[1:1] = 1'b1;
//	else
//		led_reg[1:1] = 1'b0;
//	
//	if (temp2[7:0] == 8'hf8) 
//		led_reg[2:2] = 1'b1;
//	else
//		led_reg[2:2] = 1'b0;
//	
//	if (temp3[7:0] == 8'hcd) 
//		led_reg[3:3] = 1'b1;
//	else
//		led_reg[3:3] = 1'b0;
//	
//	if (temp4[7:0] == 8'hc2) 
//		led_reg[4:4] = 1'b1;
//	else
//		led_reg[4:4] = 1'b0;
//	
//	if (temp5[7:0] == 8'h7c) 
//		led_reg[5:5] = 1'b1;
//	else
//		led_reg[5:5] = 1'b0;
//	
//	if (temp6[7:0] == 8'h22) 
//		led_reg[6:6] = 1'b1;
//	else
//		led_reg[6:6] = 1'b0;
//	
//	if (temp7[7:0] == 8'h01) 
//		led_reg[7:7] = 1'b1;
//	else
//		led_reg[7:7] = 1'b0;
//	
//	if (temp8[7:0] == 8'h3d) 
//		led_reg[8:8] = 1'b1;
//	else
//		led_reg[8:8] = 1'b0;
//	
//	if (temp9[7:0] == 8'h11) 
//		led_reg[9:9] = 1'b1;
//	else
//		led_reg[9:9] = 1'b0;
//	
//	if (expanded_key[7:0] == 8'h00) 
//		led_reg[10:10] = 1'b1;
//	else
//		led_reg[10:10] = 1'b0;
//	
//	if (plain_in[7:0] == 8'hf1) 
//		led_reg[11:11] = 1'b1;
//	else
//		led_reg[11:11] = 1'b0;
//	
//	if (expanded_key[1407:1400] == 8'hb9) 
//		led_reg[12:12] = 1'b1;
//	else
//		led_reg[12:12] = 1'b0;
//	
//	if (expanded_key[1399:1392] == 8'h40) 
//		led_reg[13:13] = 1'b1;
//	else
//		led_reg[13:13] = 1'b0;
//	
//	if (expanded_key[1407:1400] == 8'h87) 
//		led_reg[14:14] = 1'b1;
//	else
//		led_reg[14:14] = 1'b0;
//		
//	if (temp15[7:0] == 8'h00)
//		led_reg[15:15] = 1'b1;
//	else
//		led_reg[15:15] = 1'b0;
//	
	
	end
	
	 AES_top i_AES_top(
	    . clk(clk),
	    . key(key),
	    . plain_in(plain_in),
	    . expanded_key(expanded_key),
	    . led(led_reg_),
	    . cipher_text(cipher_text));
    
	    

	assign led = led_reg_;
endmodule 