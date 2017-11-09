`timescale 1ns / 1ps


module encrypt_top(
    input wire clk,
    input wire [127:0] key,
    input wire [1407:0] expanded_key,
    input wire [127:0] plain_text,
    output wire [127:0] state_ak,
    output wire [127:0] cypher_text
	);
	
	add_key i_add_key(.clk(clk), .key(key), . plain_text(plain_text), .state_ak(state_ak));
	
	encrypt_rounds i_encrypt_rounds(. clk(clk), 
		. expanded_key(expanded_key),
		. state_ak(state_ak),
		. state_sb(state_sb),
		. state_sr(state_sr),
		. state_mc(state_mc),
		. state_ark(state_ark),
		. state_rounds(state_rounds));
	
	
	endmodule