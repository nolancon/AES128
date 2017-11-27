`timescale 1ns / 1ps


module decrypt_initial_round(
    input wire clk,
    input wire [127:0] round_key,
    input wire [127:0] state_in,
    output wire [127:0] state_round
	);
		
	wire [127:0] state_ark;	
	wire [127:0] state_isr;
	wire [127:0] state_isb;
	
	reg [127:0] state_round_next;
	reg [127:0] state_round_reg;
	
    
	add_round_key i_add_round_key(. clk(clk),. round_key(round_key),. state_ark_in(state_in),. state_ark_out(state_ark));
    inv_shift_rows i_inv_shift_rows(. clk(clk),. state_isr_in(state_ark),. state_isr_out(state_isr));
    inv_sub_bytes i_inv_sub_bytes(. clk(clk),. state_isb_in(state_isr),. state_isb_out(state_isb));
    
    
    always @(posedge clk)
    begin
        state_round_reg <= state_round_next;
    end
	
	always @*
    begin
    	//Combinational logic
		state_round_next = state_isb;
    end
    
    assign state_round = state_round_reg;
    
endmodule