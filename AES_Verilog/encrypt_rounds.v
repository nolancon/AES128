`timescale 1ns / 1ps


module encrypt_rounds(
    input wire clk,
    input wire [1407:0] expanded_key,
    input wire [127:0] state_ak,
    output wire [127:0] state_sb,
    output wire [127:0] state_sr,
    output wire [127:0] state_mc,
    output wire [127:0] state_ark,
    output wire [127:0] state_rounds
	);
	
	sub_bytes i_sub_bytes(. clk(clk), . state_ak(state_ak),. state_sb(state_sb));
	shift_rows i_shift_rows(. clk(clk), . state_sb(state_sb), .state_sr(state_sr));
	mix_columns i_mix_columns(. clk(clk), . state_mc(state_mc), . state_sr(state_sr));
	add_round_key i_add_round_key(. clk(clk),. expanded_key(expanded_key),. state_mc(state_mc),. state_ark(state_ark));
	
	
	
	
endmodule