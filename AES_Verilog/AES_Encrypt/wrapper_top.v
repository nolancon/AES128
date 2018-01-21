`timescale 1ns / 1ps


module wrapper_top(
    input wire clk,
    input wire plain_text,
    output wire cipher_text,
    output wire [15:0] led
	);

	reg [127:0] cipher_text_reg;

	reg [127:0] key_;
	reg[15:0] led_;
	reg[7:0] temp;
	reg[7:0] temp2;
	reg[7:0] temp3;
	
	
	wire [1407:0] expanded_key;
	
	always @(posedge clk)
    begin
        key_[127:0] = 128'h100F0E0D0C0B0A090807060504030201;
	   	cipher_text_reg[127:0] = cipher_text;
	    
    end
    
    always @ *
	begin
	temp = cipher_text_reg[7:0];
	if (temp == 8'h39) 
		led_[0:0] = 1'b1;
	else
		led_[0:0] = 1'b0;
	
	temp2 = cipher_text_reg[15:8];
	if (temp2 == 8'h8f) 
		led_[1:1] = 1'b1;
	else
		led_[1:1] = 1'b0;
//	
	temp3 = cipher_text_reg[127:120];
	if (temp3 == 8'h4b) 
		led_[15:15] = 1'b1;
	else
		led_[15:15] = 1'b0;


//	if (key_[0] == 8'h01) 
//		led_[0] = 1'b1;
//	else
//		led_[0] = 1'b0;
	
//	if (key_[1] == 8'h02) 
//		led_[1] = 1'b1;
//	else
//		led_[1] = 1'b0;
	end
	
	AES_top i_AES_top(
	    . clk(clk),
	    . key(key_),
//	    . plain_text(plain_text),
//	    . led(led),
//	    . expanded_key(expanded_key), 
	    . cipher_text(cipher_text));

	assign led = led_;
endmodule 