`timescale 1ns / 1ps


module wrapper_top(
    input wire clk,
    output wire [15:0] led
	);

	wire[1407:0]expanded_key;
	wire [127:0] cipher_text;	
	wire [127:0] decrypted_plain_text;

	reg [15:0]led_reg;	
	reg [127:0] key, plain_text;
	
	
	always @(posedge clk)
    begin
        key[127:0] <= 128'h100F0E0D0C0B0A090807060504030201;
//	    plain_text[127:0] <= 128'h00FFFEFDFCFBFAF9F8F7F6F5F4F3F2F1;
		plain_text[127:0] <= 128'h54494d47206e616c6f4e20726f6e6f43;
	    
//	    cipher_text_reg <= cipher_text_next;
//	    expanded_key_reg <= expanded_key_next;
//	    
    end
    
   
    always @ *
	begin

//	cipher_text_next[127:0] = cipher_text[127:0];
//	expanded_key_next[1407:0] = expanded_key[1407:0];
//	led_reg[15:0] = led_reg_[15:0];

/**************************************************************************************************************
	//Test cipher text bytes with LEDs - Simulation cipher_text output : 4b286e22c5d2113d01227cc2cdf88f39*/

	if (plain_text[127:0] == 128'h54494d47206e616c6f4e20726f6e6f43) 
		led_reg[11:11] = 1'b1;
	else
		led_reg[11:11] = 1'b0;
	
	if (key[127:0] == 128'h100F0E0D0C0B0A090807060504030201) 
		led_reg[12:12] = 1'b1;
	else
		led_reg[12:12] = 1'b0;
	
	if (expanded_key[1407:0] == 1408'h8740b1b1656281a1735c1a6f4214c4bce2223010163e9bce3148ded3888c578ef41cabde2776451db9c4895d9533cbf7d36aeec39eb2cc402cf742aabb55c95f4dd82283b2458eea97a28bf557b6a88cff9dac6925e7051fc0142379aea0f63dda7aa976e5f326666eb4d54496f72cfe3f898f108b47f322f843f9ba5c828b85b4ce7c3273040a98a4c1723f7f0f0091c7ca76aad7c578a7dbce72aed3c974ab100f0e0d0c0b0a090807060504030201) 
		led_reg[13:13] = 1'b1;
	else
		led_reg[13:13] = 1'b0;
	
	if (cipher_text[127:0] == 128'h601dabc6628da2423c381762fae6db21) 
		led_reg[14:14] = 1'b1;
	else
		led_reg[14:14] = 1'b0;
	
	if (decrypted_plain_text[127:0] == 128'h54494d47206e616c6f4e20726f6e6f43) 
		led_reg[15:15] = 1'b1;
	else
		led_reg[15:15] = 1'b0;
	
	if (decrypted_plain_text[127:0] == 128'h00000000000000000000000000000000) 
		led_reg[10:10] = 1'b1;
	else
		led_reg[10:10] = 1'b0;
	
//	if (decrypted_plain_text[127:0] == 128'h4446434a2c656b65674926776b6d6d42) 
//		led_reg[9:9] = 1'b1;
//	else
//		led_reg[9:9] = 1'b0;
//	
//	if (decrypted_plain_text[127:0] == 128'h54494d47206e616c6f4e20726f6e6f43) 
//		led_reg[8:8] = 1'b1;
//	else
//		led_reg[8:8] = 1'b0;
	/**************************************************************************************************************/


	
	end
	
	aes128_top i_aes128_top(
	    . clk(clk),
	    . reset(reset),
	    . key_0(key[31:0]),
	    . key_1(key[63:32]),
	    . key_2(key[95:64]),
	    . key_3(key[127:96]),
	    . plain_text_0(plain_text[31:0]),
	    . plain_text_1(plain_text[63:32]),
	    . plain_text_2(plain_text[95:64]),
	    . plain_text_3(plain_text[127:96]),	    
	    . cipher_text_0(cipher_text[31:0]),
	    . cipher_text_1(cipher_text[63:32]),
	    . cipher_text_2(cipher_text[95:64]),
	    . cipher_text_3(cipher_text[127:96]),
	    . decrypted_plain_text_0(decrypted_plain_text[31:0]),
	    . decrypted_plain_text_1(decrypted_plain_text[63:32]),
	    . decrypted_plain_text_2(decrypted_plain_text[95:64]),
	    . decrypted_plain_text_3(decrypted_plain_text[127:96]));
	
    
	  
	assign led = led_reg;

endmodule 