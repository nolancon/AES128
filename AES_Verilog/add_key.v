`timescale 1ns / 1ps


module add_key(
	input wire clk,
	input wire[127:0] key,
	input wire [127:0] add_key_in,
	output wire [127:0] add_key_out
	);
	
	//Internal logic
	reg [1407:0] key_temp;
	reg [127:0] state_in_reg; 
	reg [127:0] state_in_next;
	
	
	always @(posedge clk)
    begin
        state_in_reg <= state_in_next;
    end
	
	always @*
    begin
    	//Combinational logic
		key_temp[127:0] = key[127:0];

    	//Add Round Key
    	state_in_next[127:0] = key_temp[127:0] ^ add_key_in[127:0];
    end
    
    assign add_key_out = state_in_reg;
    
endmodule