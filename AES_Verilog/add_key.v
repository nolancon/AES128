`timescale 1ns / 1ps


module add_key(
	input wire clk,
	input wire[127:0] key,
	input wire [127:0] plain_text,
	output wire [127:0] state_ak
	);
	
	//Internal logic
	reg [1407:0] key_temp;
	reg [127:0] state_out_reg; 
	reg [127:0] state_out_next;
	
	
	always @(posedge clk)
    begin
        state_out_reg <= state_out_next;
    end
	
	always @*
    begin
    	//Combinational logic
		key_temp[127:0] = key[127:0];

    	//Add Round Key
    	state_out_next[127:0] = key_temp[127:0] ^ plain_text[127:0];
    end
    
    assign state_ak = state_out_reg;
    
endmodule