`timescale 1ns / 1ps


module encrypt_final_round(
    input wire clk,
    input wire [127:0] round_key,
    input wire [127:0] state_in,
    output wire [127:0] state_round
	);
	wire [127:0] state_sb;
	wire [127:0] state_sr;
	wire [127:0] state_ark;
	
	reg [127:0] state_round_next;
	reg [127:0] state_round_reg;
	
	
	sub_bytes i_sub_bytes(. clk(clk), . state_sb_in(state_in),. state_sb_out(state_sb));
	shift_rows i_shift_rows(. clk(clk), . state_sr_in(state_sb), .state_sr_out(state_sr));
	add_round_key i_add_round_key(. clk(clk),. round_key(round_key),. state_ark_in(state_sr),. state_ark_out(state_ark));
	
	
	
	always @(posedge clk)
    begin
        state_round_reg <= state_round_next;
    end
	
	always @*
    begin
    	//Combinational logic
		state_round_next = state_ark;
    end
    
    assign state_round = state_round_reg;
	
endmodule