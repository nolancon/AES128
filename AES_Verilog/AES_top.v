`timescale 1ns / 1ps


module AES_top(
    input wire clk,
    input wire [127:0] key,
    input wire[127:0] plain_text,
    output wire [1407:0] expanded_key,
    output wire [127:0] cypher_text
	);
	

	
	expand_key i_expand_key(.clk(clk), .key(key), .expanded_key(expanded_key));
	
//	encrypt_full i_encrypt_full(.clk(clk), .expanded_key(expanded_key), .plain_text(plain_text), .cypher_text(cypher_text));
	
	
	encrypt_top i_encrypt_top(. clk(clk),. key(key), .expanded_key(expanded_key), .plain_text(plain_text),. state_ak(state_ak), .cypher_text(cypher_text));
	
	
endmodule 