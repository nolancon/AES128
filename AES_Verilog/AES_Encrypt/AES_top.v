`timescale 1ns / 1ps


module AES_top(
    input wire clk,
    input wire [127:0] key,
    output wire [127:0] cipher_out
	);

	
	wire [1407:0] expanded_key;
	wire [127:0] round1_key, round2_key, round3_key, round4_key, round5_key,
				 round6_key, round7_key, round8_key, round9_key, round10_key; 

	wire [127:0] key_in, plain_in;
	wire [127:0] cipher_text;
	
	reg [127:0] key_;

	always @(posedge clk)
    begin
        key_[127:0] = 128'h100F0E0D0C0B0A090807060504030201;
    end
	
	read_ram i_read_ram(
		. clk(clk),
		. key_in(key_in),
//		. led(led),
		. plain_in(plain_in));
	
	expand_key i_expand_key(
		.clk(clk), 
		.key(key), 
		.expanded_key(expanded_key));

	key_scheduler i_key_scheduler(
	    . clk(clk),
	    . expanded_key(expanded_key),
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
		.cipher_text(cipher_text));
	
	write_cipher i_write_cipher(
		. clk(clk),
		. cipher_text(cipher_text),
		. cipher_out(cipher_out));		
	
endmodule 