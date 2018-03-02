`timescale 1ns / 1ps

module expand_key_top(
    input wire clk,
    input wire reset,
    input wire [127:0] key,
    output wire[1407:0] expanded_key
	);
	//
	reg [1407:0] expanded_key_next, expanded_key_reg;
		
	reg [7:0] rcon_index_1, rcon_index_2, rcon_index_3, rcon_index_4, rcon_index_5, rcon_index_6, rcon_index_7, rcon_index_8, rcon_index_9, rcon_index_10;
	
	wire [127:0] expanded_key_1_out, expanded_key_2_out, expanded_key_3_out, expanded_key_4_out, expanded_key_5_out, expanded_key_6_out, expanded_key_7_out, expanded_key_8_out, expanded_key_9_out, expanded_key_10_out;
	
	reg [127:0] expanded_key_2_in, expanded_key_3_in, expanded_key_4_in, expanded_key_5_in, expanded_key_6_in, expanded_key_7_in, expanded_key_8_in,expanded_key_9_in,expanded_key_10_in; 
	
	
	
//	always @(posedge clk)
//    begin    
//	    expanded_key_reg <= expanded_key_next;
//    end
	
	always @*
    begin
	    
		rcon_index_1 = 8'h01;
	    rcon_index_2 = 8'h02;
	    rcon_index_3 = 8'h03;
	    rcon_index_4 = 8'h04;
	    rcon_index_5 = 8'h05;
	    rcon_index_6 = 8'h06;
	    rcon_index_7 = 8'h07;
	    rcon_index_8 = 8'h08;
	    rcon_index_9 = 8'h09;
	    rcon_index_10 = 8'h0a;
	    
	    
	    //*********************************************************************************************************

	    expanded_key_next[127:0] = key[127:0];
	    
	    expanded_key_next[255:128] = expanded_key_1_out[127:0];
	    expanded_key_2_in[127:0] = expanded_key_1_out[127:0];
	    
	    expanded_key_next[383:256] = expanded_key_2_out[127:0];
	    expanded_key_3_in[127:0] = expanded_key_2_out[127:0];
	    
	    expanded_key_next[511:384] = expanded_key_3_out[127:0];
	    expanded_key_4_in[127:0] = expanded_key_3_out[127:0];
	    
	    expanded_key_next[639:512] = expanded_key_4_out[127:0];
	    expanded_key_5_in[127:0] = expanded_key_4_out[127:0];
	    
	    expanded_key_next[767:640] = expanded_key_5_out[127:0];
	    expanded_key_6_in[127:0] = expanded_key_5_out[127:0];
	    
	    expanded_key_next[895:768] = expanded_key_6_out[127:0];
	    expanded_key_7_in[127:0] = expanded_key_6_out[127:0];
	    
	    expanded_key_next[1023:896] = expanded_key_7_out[127:0];
	    expanded_key_8_in[127:0] = expanded_key_7_out[127:0];
	    
	    expanded_key_next[1151:1024] = expanded_key_8_out[127:0];
	    expanded_key_9_in[127:0] = expanded_key_8_out[127:0];
	    
	    expanded_key_next[1279:1152] = expanded_key_9_out[127:0];
	    expanded_key_10_in[127:0] = expanded_key_9_out[127:0];
	    
	    expanded_key_next[1407:1280] = expanded_key_10_out[127:0];
	    
	    
    end
    
 
    expand_key_core i_expand_key_core_1(
	    . clk(clk),
	    . reset(reset),
	    . key_in(key),
	    . rcon_index_in(rcon_index_1),
	    . expanded_key_out(expanded_key_1_out));
    
    expand_key_core i_expand_key_core_2(
	    . clk(clk),
	    . reset(reset),
	    . key_in(expanded_key_2_in),
	    . rcon_index_in(rcon_index_2),
	    . expanded_key_out(expanded_key_2_out));
    
    expand_key_core i_expand_key_core_3(
	    . clk(clk),
	    . reset(reset),
	    . key_in(expanded_key_3_in),
	    . rcon_index_in(rcon_index_3),
	    . expanded_key_out(expanded_key_3_out));
    
    expand_key_core i_expand_key_core_4(
	    . clk(clk),
	    . reset(reset),
	    . key_in(expanded_key_4_in),
	    . rcon_index_in(rcon_index_4),
	    . expanded_key_out(expanded_key_4_out));
    
    expand_key_core i_expand_key_core_5(
	    . clk(clk),
	    . reset(reset),
	    . key_in(expanded_key_5_in),
	    . rcon_index_in(rcon_index_5),
	    . expanded_key_out(expanded_key_5_out));
    
    expand_key_core i_expand_key_core_6(
	    . clk(clk),
	    . reset(reset),
	    . key_in(expanded_key_6_in),
	    . rcon_index_in(rcon_index_6),
	    . expanded_key_out(expanded_key_6_out));
    
    expand_key_core i_expand_key_core_7(
	    . clk(clk),
	    . reset(reset),
	    . key_in(expanded_key_7_in),
	    . rcon_index_in(rcon_index_7),
	    . expanded_key_out(expanded_key_7_out));
    
    expand_key_core i_expand_key_core_8(
	    . clk(clk),
	    . reset(reset),
	    . key_in(expanded_key_8_in),
	    . rcon_index_in(rcon_index_8),
	    . expanded_key_out(expanded_key_8_out));
    
    expand_key_core i_expand_key_core_9(
	    . clk(clk),
	    . reset(reset),
	    . key_in(expanded_key_9_in),
	    . rcon_index_in(rcon_index_9),
	    . expanded_key_out(expanded_key_9_out));
    
    expand_key_core i_expand_key_core_10(
	    . clk(clk),
	    . reset(reset),
	    . key_in(expanded_key_10_in),
	    . rcon_index_in(rcon_index_10),
	    . expanded_key_out(expanded_key_10_out));
//    

  
    assign expanded_key = expanded_key_next;
    
  
endmodule