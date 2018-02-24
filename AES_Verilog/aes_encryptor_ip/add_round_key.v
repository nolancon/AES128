`timescale 1ns / 1ps


module add_round_key(
    input wire clk,
    input wire reset,
    input wire [127:0] round_key,
    input wire [127:0] state_ark_in,
    output wire [127:0] state_ark_out
	);
	
	
	
	
	//Internal logic
	reg [127:0] round_key_temp;
	reg [127:0] state_ark_out_temp; 
	reg [127:0] state_ark_out_next;
	
	
	
//	always @(posedge clk)
//    begin
//        state_ark_out_reg <= state_ark_out_next;
//    end
	
	always @*
    begin
    	//Combinational logic
    	round_key_temp = round_key;
    	state_ark_out_temp = state_ark_in;
    	//Add Round Key
        state_ark_out_next = state_ark_out_temp[127:0] ^ round_key_temp[127:0];
    end
    
    assign state_ark_out = state_ark_out_next;
	
	
endmodule