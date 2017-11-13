`timescale 1ns / 1ps


module decrypt_round(
    input wire clk,
    input wire [127:0] round_key,
    input wire [127:0] dec_state_in,
    output wire [127:0] dec_state_round
	);
	
	wire [127:0] state_ark_out;
	wire [127:0] state_imc_out;
	wire [127:0] state_isr_out;
	wire [127:0] state_isb_out;
	
	
	
	
	reg [127:0] dec_state_round_next;
	reg [127:0] dec_state_round_reg;
	
	
	add_round_key i_add_round_key(. clk(clk),. round_key(round_key),. state_ark_in(dec_state_in),. state_ark_out(state_ark_out));
	inv_mix_columns i_inv_mix_columns(. clk(clk),. state_imc_in(state_ark_out),. state_imc_out(state_imc_out));
	inv_shift_rows i_inv_shift_rows(.clk(clk),. state_isr_in(state_imc_out),. state_isr_out(state_isr_out));
	inv_sub_bytes i_inv_sub_bytes(.clk(clk),. state_isb_in(state_isr_out),. state_isb_out(state_isb_out));
	
	
	
	always @(posedge clk)
    begin
        dec_state_round_reg <= dec_state_round_next;
    end
	
	always @*
    begin
    	//Combinational logic
		dec_state_round_next = state_isb_out;
    end
    
    assign dec_state_round = dec_state_round_reg;
    
	
endmodule