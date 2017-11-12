`timescale 1ns / 1ps


module AES_top(
    input wire clk,
    input wire [127:0] key,
    input wire[127:0] plain_text,
    output wire [1407:0] expanded_key,
    output wire [127:0] cypher_text,
    output wire [127:0] decrypted_plain_text
	);
	
	wire [127:0] round1_key, round2_key, round3_key, round4_key, round5_key,
				 round6_key, round7_key, round8_key, round9_key, round10_key; 
	
	expand_key i_expand_key(.clk(clk), .key(key), .expanded_key(expanded_key));

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
		.plain_text(plain_text), 
		.cypher_text(cypher_text));
	
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
		. cypher_text(cypher_text),
		. decrypted_plain_text(decrypted_plain_text) );
	
	
endmodule 