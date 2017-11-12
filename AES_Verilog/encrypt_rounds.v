`timescale 1ns / 1ps


module encrypt_round(
    input wire clk,
    input wire [127:0] round_key,
    input wire [127:0] enc_state_in,
    output wire [127:0] enc_state_round
	);
	
	wire [127:0] state_sb;
	wire [127:0] state_sr;
	wire [127:0] state_mc;
	wire [127:0] state_ark;
	
	reg [127:0] enc_state_round_next;
	reg [127:0] enc_state_round_reg;
	
	
	sub_bytes i_sub_bytes(. clk(clk), . state_ak(enc_state_in),. state_sb(state_sb));
	shift_rows i_shift_rows(. clk(clk), . state_sb(state_sb), .state_sr(state_sr));
	mix_columns i_mix_columns(. clk(clk), . state_mc(state_mc), . state_sr(state_sr));
	add_round_key i_add_round_key(. clk(clk),. round_key(round_key),. state_ark_in(state_mc),. state_ark(state_ark));
	
	
	
	always @(posedge clk)
    begin
        enc_state_round_reg <= enc_state_round_next;
    end
	
	always @*
    begin
    	//Combinational logic
		enc_state_round_next = state_ark;
    end
    
    assign enc_state_round = enc_state_round_reg;
	
endmodule