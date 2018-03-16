`timescale 1ns / 1ps


module encrypt_round(
    input wire clk,
    input wire reset,
    input wire [127:0] round_key,
    input wire [127:0] enc_state_in,
    output wire [127:0] enc_state_round
	);
	
	wire [127:0] state_sb_out;
	wire [127:0] state_sr_out;
	wire [127:0] state_mc_out;
	wire [127:0] state_ark_out;
	
	reg [127:0] enc_state_round_next;
	reg [127:0] enc_state_round_reg;
	
	
	sub_bytes i_sub_bytes(. clk(clk), . reset(reset), . state_sb_in(enc_state_in),. state_sb_out(state_sb_out));
	shift_rows i_shift_rows(. clk(clk), . reset(reset), . state_sr_in(state_sb_out), .state_sr_out(state_sr_out));
	mix_columns i_mix_columns(. clk(clk), . reset(reset), . state_mc_in(state_sr_out), . state_mc_out(state_mc_out));
	add_round_key i_add_round_key(. clk(clk), . reset(reset), . round_key(round_key),. state_ark_in(state_mc_out),. state_ark_out(state_ark_out));
	
	
	
//	always @(posedge clk)
//    begin
//        enc_state_round_reg <= enc_state_round_next;
//    end
	
	always @*
    begin
    	//Combinational logic
		enc_state_round_next = state_ark_out;
    end
    
    assign enc_state_round = enc_state_round_next;
	
endmodule