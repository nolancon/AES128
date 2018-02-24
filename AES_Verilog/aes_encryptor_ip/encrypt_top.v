`timescale 1ns / 1ps


module encrypt_top(
    input wire clk,
    input wire reset,
    input wire [127:0] key,
    input wire [127:0] round1_key, 
    input wire [127:0] round2_key, 
    input wire [127:0] round3_key, 
    input wire [127:0] round4_key, 
    input wire [127:0] round5_key,
	input wire [127:0] round6_key, 
	input wire [127:0] round7_key, 
	input wire [127:0] round8_key, 
	input wire [127:0] round9_key, 
	input wire [127:0] round10_key, 
    input wire [127:0] plain_text,
    output wire [127:0] cipher_text
	);
	
	wire [127:0] enc_state_in;	
	wire [127:0] enc_state_round1_out;
	wire [127:0] enc_state_round2_in, enc_state_round2_out;
	wire [127:0] enc_state_round3_in, enc_state_round3_out;
	wire [127:0] enc_state_round4_in, enc_state_round4_out;
	wire [127:0] enc_state_round5_in, enc_state_round5_out;
	wire [127:0] enc_state_round6_in, enc_state_round6_out;
	wire [127:0] enc_state_round7_in, enc_state_round7_out;
	wire [127:0] enc_state_round8_in, enc_state_round8_out;
	wire [127:0] enc_state_round9_in, enc_state_round9_out;
	wire [127:0] enc_state_final_round_in, enc_state_final_round_out;
	

	
	reg [127:0] enc_state_round1_reg, enc_state_round1_next;
	reg [127:0] enc_state_round2_reg, enc_state_round2_next;
	reg [127:0] enc_state_round3_reg, enc_state_round3_next;
	reg [127:0] enc_state_round4_reg, enc_state_round4_next;
	reg [127:0] enc_state_round5_reg, enc_state_round5_next;
	reg [127:0] enc_state_round6_reg, enc_state_round6_next;
	reg [127:0] enc_state_round7_reg, enc_state_round7_next;
	reg [127:0] enc_state_round8_reg, enc_state_round8_next;
	reg [127:0] enc_state_round9_reg, enc_state_round9_next;
	reg [127:0] enc_state_final_round_reg, enc_state_final_round_next;
	
		
	
	always @(posedge clk)
    begin
        enc_state_round1_reg <= enc_state_round1_next;
	    enc_state_round2_reg <= enc_state_round2_next;
	    enc_state_round3_reg <= enc_state_round3_next;
	    enc_state_round4_reg <= enc_state_round4_next;
	    enc_state_round5_reg <= enc_state_round5_next;
	    enc_state_round6_reg <= enc_state_round6_next;
	    enc_state_round7_reg <= enc_state_round7_next;
	    enc_state_round8_reg <= enc_state_round8_next;
	    enc_state_round9_reg <= enc_state_round9_next;
	    enc_state_final_round_reg <= enc_state_final_round_next;
	    
    end
	
	always @*
    begin
    	//Combinational logic
		enc_state_round1_next = enc_state_round1_out;
	  	enc_state_round2_next = enc_state_round2_out;
	    enc_state_round3_next = enc_state_round3_out;
	    enc_state_round4_next = enc_state_round4_out;
	    enc_state_round5_next = enc_state_round5_out;
	    enc_state_round6_next = enc_state_round6_out;
	    enc_state_round7_next = enc_state_round7_out;
	    enc_state_round8_next = enc_state_round8_out;
	    enc_state_round9_next = enc_state_round9_out;
	    enc_state_final_round_next = enc_state_final_round_out;
	    
    end
    
    assign enc_state_round2_in = enc_state_round1_reg;
    assign enc_state_round3_in = enc_state_round2_reg;
    assign enc_state_round4_in = enc_state_round3_reg;
 	assign enc_state_round5_in = enc_state_round4_reg;
    assign enc_state_round6_in = enc_state_round5_reg;
    assign enc_state_round7_in = enc_state_round6_reg;
    assign enc_state_round8_in = enc_state_round7_reg;
    assign enc_state_round9_in = enc_state_round8_reg;
    assign enc_state_final_round_in = enc_state_round9_reg;
    assign cipher_text = enc_state_final_round_reg;
    

    add_round_key i_add_round_key(
	    . clk(clk), 
	    . reset(reset),
	    . round_key(key),
	    . state_ark_in(plain_text),
	    . state_ark_out(enc_state_in));
    
	encrypt_round i_encrypt_round_1(
		. clk(clk), 
		. reset(reset),
		. round_key(round1_key),
		. enc_state_in(enc_state_in),
		. enc_state_round(enc_state_round1_out));
	
	encrypt_round i_encrypt_round_2(
		. clk(clk), 
		. reset(reset),
		. round_key(round2_key),
		. enc_state_in(enc_state_round2_in),
		. enc_state_round(enc_state_round2_out));
    
    encrypt_round i_encrypt_round_3(
	    . clk(clk), 
	    . reset(reset),
		. round_key(round3_key),
		. enc_state_in(enc_state_round3_in),
		. enc_state_round(enc_state_round3_out));
    
    encrypt_round i_encrypt_round_4(
	    . clk(clk), 
	    . reset(reset),
		. round_key(round4_key),
		. enc_state_in(enc_state_round4_in),
		. enc_state_round(enc_state_round4_out));
    
    encrypt_round i_encrypt_round_5(
	    . clk(clk), 
	    . reset(reset),
		. round_key(round5_key),
		. enc_state_in(enc_state_round5_in),
		. enc_state_round(enc_state_round5_out));
	
	encrypt_round i_encrypt_round_6(
	    . clk(clk), 
	    . reset(reset),
		. round_key(round6_key),
		. enc_state_in(enc_state_round6_in),
		. enc_state_round(enc_state_round6_out));
	
	encrypt_round i_encrypt_round_7(
	    . clk(clk), 
	    . reset(reset),
		. round_key(round7_key),
		. enc_state_in(enc_state_round7_in),
		. enc_state_round(enc_state_round7_out));
    
    encrypt_round i_encrypt_round_8(
	    . clk(clk), 
	    . reset(reset),
		. round_key(round8_key),
		. enc_state_in(enc_state_round8_in),
		. enc_state_round(enc_state_round8_out));
    
    encrypt_round i_encrypt_round_9(
	    . clk(clk), 
	    . reset(reset),
		. round_key(round9_key),
		. enc_state_in(enc_state_round9_in),
		. enc_state_round(enc_state_round9_out));
    
     encrypt_final_round i_encrypt_final_round(
	    . clk(clk), 
	    . reset(reset),
		. round_key(round10_key),
		. state_in(enc_state_final_round_in),
		. state_round(enc_state_final_round_out));
    
	endmodule