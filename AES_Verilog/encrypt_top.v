`timescale 1ns / 1ps


module encrypt_top(
    input wire clk,
    input wire [127:0] key,
    input wire [1407:0] expanded_key,
    input wire [127:0] plain_text,
    output wire [127:0] cypher_text
	);
	
	wire [127:0] state_in;	
	wire [127:0] state_round1_out;
	wire [127:0] state_round2_in, state_round2_out;
	wire [127:0] state_round3_in, state_round3_out;
	wire [127:0] state_round4_in, state_round4_out;
	wire [127:0] state_round5_in, state_round5_out;
	wire [127:0] state_round6_in, state_round6_out;
	wire [127:0] state_round7_in, state_round7_out;
	wire [127:0] state_round8_in, state_round8_out;
	wire [127:0] state_round9_in, state_round9_out;
	wire [127:0] state_final_round_in, state_final_round_out;
	
	
	wire [127:0] round1_key, round2_key, round3_key, round4_key, round5_key,
				 round6_key, round7_key, round8_key, round9_key, round10_key; 
	
	
	reg [127:0] state_round1_reg, state_round1_next;
	reg [127:0] state_round2_reg, state_round2_next;
	reg [127:0] state_round3_reg, state_round3_next;
	reg [127:0] state_round4_reg, state_round4_next;
	reg [127:0] state_round5_reg, state_round5_next;
	reg [127:0] state_round6_reg, state_round6_next;
	reg [127:0] state_round7_reg, state_round7_next;
	reg [127:0] state_round8_reg, state_round8_next;
	reg [127:0] state_round9_reg, state_round9_next;
	reg [127:0] state_final_round_reg, state_final_round_next;
//	reg [127:0] cypher_text_reg, cypher_text_next;
	
		
	
	always @(posedge clk)
    begin
        state_round1_reg <= state_round1_next;
	    state_round2_reg <= state_round2_next;
	    state_round3_reg <= state_round3_next;
	    state_round4_reg <= state_round4_next;
	    state_round5_reg <= state_round5_next;
	    state_round6_reg <= state_round6_next;
	    state_round7_reg <= state_round7_next;
	    state_round8_reg <= state_round8_next;
	    state_round9_reg <= state_round9_next;
	    state_final_round_reg <= state_final_round_next;
	    
    end
	
	always @*
    begin
    	//Combinational logic
		state_round1_next = state_round1_out;
	  	state_round2_next = state_round2_out;
	    state_round3_next = state_round3_out;
	    state_round4_next = state_round4_out;
	    state_round5_next = state_round5_out;
	    state_round6_next = state_round6_out;
	    state_round7_next = state_round7_out;
	    state_round8_next = state_round8_out;
	    state_round9_next = state_round9_out;
	    state_final_round_next = state_final_round_out;
	    
    end
    
    assign state_round2_in = state_round1_reg;
    assign state_round3_in = state_round2_reg;
    assign state_round4_in = state_round3_reg;
 	assign state_round5_in = state_round4_reg;
    assign state_round6_in = state_round5_reg;
    assign state_round7_in = state_round6_reg;
    assign state_round8_in = state_round7_reg;
    assign state_round9_in = state_round8_reg;
    assign state_final_round_in = state_round9_reg;
    assign cypher_text = state_final_round_reg;
    
	
		
	add_key i_add_key(.clk(clk), .key(key), . plain_text(plain_text), .state_in(state_in));
    
    key_scheduler i_key_scheduler(
	    . clk(clk),
	    . expanded_key(expanded_key),
	    . round1_key(round1_key),
	    . round2_key(round2_key),
	    . round3_key(round3_key),
	    . round4_key(round4_key),
	    . round5_key(round5_key),
	    . round6_key(round6_key),
	    . round7_key(round7_key),
	    . round8_key(round8_key),
	    . round9_key(round9_key),
	    . round10_key(round10_key));
	
	encrypt_round i_encrypt_round_1(
		. clk(clk), 
		. round_key(round1_key),
		. state_in(state_in),
		. state_round(state_round1_out));
	
	encrypt_round i_encrypt_round_2(
		. clk(clk), 
		. round_key(round2_key),
		. state_in(state_round2_in),
		. state_round(state_round2_out));
    
    encrypt_round i_encrypt_round_3(
	    . clk(clk), 
		. round_key(round3_key),
		. state_in(state_round3_in),
		. state_round(state_round3_out));
    
    encrypt_round i_encrypt_round_4(
	    . clk(clk), 
		. round_key(round4_key),
		. state_in(state_round4_in),
		. state_round(state_round4_out));
    
    encrypt_round i_encrypt_round_5(
	    . clk(clk), 
		. round_key(round5_key),
		. state_in(state_round5_in),
		. state_round(state_round5_out));
	
	encrypt_round i_encrypt_round_6(
	    . clk(clk), 
		. round_key(round6_key),
		. state_in(state_round6_in),
		. state_round(state_round6_out));
	
	encrypt_round i_encrypt_round_7(
	    . clk(clk), 
		. round_key(round7_key),
		. state_in(state_round7_in),
		. state_round(state_round7_out));
    
    encrypt_round i_encrypt_round_8(
	    . clk(clk), 
		. round_key(round8_key),
		. state_in(state_round8_in),
		. state_round(state_round8_out));
    
    encrypt_round i_encrypt_round_9(
	    . clk(clk), 
		. round_key(round9_key),
		. state_in(state_round9_in),
		. state_round(state_round9_out));
    
     encrypt_final_round i_encrypt_final_round(
	    . clk(clk), 
		. round_key(round10_key),
		. state_in(state_final_round_in),
		. state_round(state_final_round_out));
    
	endmodule