`timescale 1ns / 1ps


module add_round_key(
    input wire clk,
    input wire [1407:0] expanded_key,
    input wire [127:0] state_mc,
    output wire [127:0] state_ark
	);
	
	
	
	
	//Internal logic
	reg [1407:0] expanded_key_temp;
	reg [127:0] state_ark_temp; 
	reg [127:0] state_ark_reg; 
	reg [127:0] state_ark_next;
	
	
	
	always @(posedge clk)
    begin
        state_ark_reg <= state_ark_next;
    end
	
	always @*
    begin
    	//Combinational logic
    	expanded_key_temp = expanded_key;
    	state_ark_temp = state_mc;
    	//Add Round Key
        state_ark_next = state_ark_temp[127:0] ^ expanded_key_temp[255:128];
//	    state_ark_next = state_ark_temp;
    end
    
    assign state_ark = state_ark_reg;
	
	
endmodule