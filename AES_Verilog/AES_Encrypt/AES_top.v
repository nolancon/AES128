`timescale 1ns / 1ps


module AES_top(
    input wire clk,
    input wire [127:0] key,
    input wire [127:0] plain_in,
    output wire [15:0] led,
    output wire [1407:0] expanded_key,
    output wire [127:0] cipher_text
	);
	
	wire [127:0] round1_key, round2_key, round3_key, round4_key, round5_key,
				 round6_key, round7_key, round8_key, round9_key, round10_key; 
	
	wire [1407:0] expanded_key_out;	
	wire [127:0] cipher_out;
	
	reg [1407:0] expanded_key_next;	
	reg [1407:0] expanded_key_reg;	
	reg [127:0] cipher_out_next;
	reg [127:0] cipher_out_reg;
//	wire [127:0] key_in, plain_in;
	
	reg [127:0] key_;
	reg [1407:0] expanded_key_;	
	
	reg [15:0] led_check;
	
	
	
		reg [15:0] led_check_reg;
	
	
		wire [15:0] led_wire;
	

	always @(posedge clk)
    begin
//	            expanded_key_[1407:0] <= 1408'h8740b1b1656281a1735c1a6f4214c4bce2223010163e9bce3148ded3888c578ef41cabde2776451db9c4895d9533cbf7d36aeec39eb2cc402cf742aabb55c95f4dd82283b2458eea97a28bf557b6a88cff9dac6925e7051fc0142379aea0f63dda7aa976e5f326666eb4d54496f72cfe3f898f108b47f322f843f9ba5c828b85b4ce7c3273040a98a4c1723f7f0f0091c7ca76aad7c578a7dbce72aed3c974ab100f0e0d0c0b0a090807060504030201;
	    
        cipher_out_reg <= cipher_out_next;
	    expanded_key_reg <=expanded_key_next;
	    led_check_reg <= led_check;
    end
	
//	read_ram i_read_ram(
//		. clk(clk),
//		. key_in(key_in));
//		. plain_in(plain_in));

	always @*
    begin
	    cipher_out_next = cipher_out;
    	expanded_key_next= expanded_key_out;
	    key_[127:0] = key[127:0];
	    
//	if (key_[127:0] == 128'h100F0E0D0C0B0A090807060504030201) 
//		led_check[9:9] = 1'b1;
//	else
//		led_check[9:9] = 1'b0;
//	    
//	    

	
	if (plain_in[127:0] == 128'h00FFFEFDFCFBFAF9F8F7F6F5F4F3F2F1) 
		led_check[12:12] = 1'b1;
	else
		led_check[12:12] = 1'b0;
	
	if (key[127:0] == 128'h100F0E0D0C0B0A090807060504030201) 
		led_check[13:13] = 1'b1;
	else
		led_check[13:13] = 1'b0;
	
	if (expanded_key[1407:0] == 1408'h8740b1b1656281a1735c1a6f4214c4bce2223010163e9bce3148ded3888c578ef41cabde2776451db9c4895d9533cbf7d36aeec39eb2cc402cf742aabb55c95f4dd82283b2458eea97a28bf557b6a88cff9dac6925e7051fc0142379aea0f63dda7aa976e5f326666eb4d54496f72cfe3f898f108b47f322f843f9ba5c828b85b4ce7c3273040a98a4c1723f7f0f0091c7ca76aad7c578a7dbce72aed3c974ab100f0e0d0c0b0a090807060504030201) 
		led_check[14:14] = 1'b1;
	else
		led_check[14:14] = 1'b0;
	
	if (cipher_text[127:0] == 128'h4b286e22c5d2113d01227cc2cdf88f39) 
		led_check[15:15] = 1'b1;
	else
		led_check[15:15] = 1'b0;
//		

//		
////		expanded_key_[1407:0] = expanded_key[1407:0];
//	
//	if (expanded_key_next[1407:1376] == 32'h8740b1b1) 
//		led_check[11:11] = 1'b1;
//	else
//		led_check[11:11] = 1'b0;
////	
//	if (expanded_key_next[1407:1376] == 32'h00000000) 
//		led_check[12:12] = 1'b1;
//	else
//		led_check[12:12] = 1'b0;
//	
//	if (expanded_key_reg[1407:1376] == 32'h8740b1b1) 
//		led_check[13:13] = 1'b1;
//	else
//		led_check[13:13] = 1'b0;
////	
//	if (expanded_key_reg[1407:1376] == 32'h00000000) 
//		led_check[14:14] = 1'b1;
//	else
//		led_check[14:14] = 1'b0;
////	   
//	    led_check_ = led_check2;
    end
    
	
	expand_key_top i_expand_key_top(
		.clk(clk), 
		.key(key),
		.expanded_key(expanded_key_out));

	key_scheduler i_key_scheduler(
	    . clk(clk),
	    . expanded_key(expanded_key_out),
	    . round1_key(round1_key),
	    . round2_key(round2_key),
	    . round3_key(round3_key),
	    . round4_key(round4_key),
	    . round5_key(round5_key),
	    . round6_key(round6_key),
	    . round7_key(round7_key),
	    . round8_key(round8_key),
	    . round9_key(round9_key),
	    . round10_key(round10_key));

	encrypt_top i_encrypt_top(
		. clk(clk),
		. key(key), 
		. round1_key(round1_key),
	    . round2_key(round2_key),
	    . round3_key(round3_key),
	    . round4_key(round4_key),
	    . round5_key(round5_key),
	    . round6_key(round6_key),
	    . round7_key(round7_key),
	    . round8_key(round8_key),
	    . round9_key(round9_key),
	    . round10_key(round10_key),
		.plain_text(plain_in), 
		.cipher_text(cipher_out));
	
//	write_cipher i_write_cipher(
//		. clk(clk),
//		. cipher_text(cipher_text),
//		. cipher_out(cipher_out));		

assign cipher_text = cipher_out_reg;
assign expanded_key = expanded_key_reg;
assign led = led_check;
//    assign led = led_wire;
    

endmodule 