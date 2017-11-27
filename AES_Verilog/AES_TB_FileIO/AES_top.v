`timescale 1ns / 1ps


module AES_top(
    input wire clk,
    input wire [127:0] key,
    output wire [127:0] plain_text_file_in,
    output wire [127:0] cipher_text_file_out,
    output wire [1407:0] expanded_key,
    output wire [127:0] cipher_text,
    output wire [127:0] decrypted_plain_text
	);
	
	wire [127:0] round1_key, round2_key, round3_key, round4_key, round5_key,
				 round6_key, round7_key, round8_key, round9_key, round10_key; 
	
	
	
	read_plain_text i_read_plain_text(
		. clk(clk),
		. plain_text_file_in(plain_text_file_in));
	
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
		.plain_text(plain_text_file_in), 
		.cipher_text(cipher_text));
	
	write_cipher_text i_write_cipher_text(
		. clk(clk),
		. cipher_text(cipher_text),
		. cipher_text_file_out(cipher_text_file_out));
	
	decrypt_top i_decrypt_top(
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
		. cipher_text(cipher_text),
		. decrypted_plain_text(decrypted_plain_text) );
	
	
endmodule 