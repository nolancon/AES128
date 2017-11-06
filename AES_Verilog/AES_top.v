`timescale 1ns / 1ps


module AES_top(
    input wire clk,
    input wire [127:0] key,
    input wire[127:0] plainText,
    output wire [1407:0] expandedKey,
    output wire [127:0] state_out
	);
	

	
	KeyExpansion i_KeyExpansion(.clk(clk), .key(key), .expandedKey(expandedKey));
//	encrypt_full i_encrypt_full(.clk(clk), .expandedKey(expandedKey), .plainText(plainText), .cypherText(cypherText));
	InitialAddRoundKey i_InitialRoundKey(.clk(clk), .expandedKey(expandedKey), . plainText(plainText), .state_out(state_out));
	
	
endmodule 