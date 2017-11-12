`timescale 1ns / 1ps


module decrypt_round(
    input wire clk,
    input wire [127:0] round_key,
    input wire [127:0] dec_state_in,
    output wire [127:0] dec_state_round
	);
	
	wire [127:0] state_ark;
	wire [127:0] state_imc;
	wire [127:0] state_isr;
	wire [127:0] state_isb;
	
	
	
	
	reg [127:0] dec_state_round_next;
	reg [127:0] dec_state_round_reg;
	
	
	add_round_key i_add_round_key(. clk(clk),. round_key(round_key),. state_ark_in(dec_state_in),. state_ark(state_ark));
	inv_mix_columns i_inv_mix_columns(. clk(clk),. state_ark(state_ark),. state_imc(state_imc));
	inv_shift_rows i_inv_shift_rows(.clk(clk),. state_isr_in(state_imc),. state_isr(state_isr));
	inv_sub_bytes i_inv_sub_bytes(.clk(clk),. state_isr(state_isr),. state_isb(state_isb));
	
	
	
	always @(posedge clk)
    begin
        dec_state_round_reg <= dec_state_round_next;
    end
	
	always @*
    begin
    	//Combinational logic
		dec_state_round_next = state_isb;
    end
    
    assign dec_state_round = dec_state_round_reg;
    
	
endmodule