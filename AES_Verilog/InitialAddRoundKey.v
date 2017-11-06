`timescale 1ns / 1ps


module InitialAddRoundKey(
	input wire clk,
	input wire[1407:0] expandedKey,
	input wire [127:0] plainText,
	output wire [127:0] state_out
	);
	
	//Internal logic
	reg [1407:0] expandedKey_temp;
	reg [127:0] state_out_reg; 
	reg [127:0] state_out_next;
	
	
	always @(posedge clk)
    begin
        state_out_reg <= state_out_next;
    end
	
	always @*
    begin
    	//Combinational logic
		expandedKey_temp[1407:0] = expandedKey[1407:0];

    	//Add Round Key
    	state_out_next[127:0] = expandedKey_temp[127:0] ^ plainText[127:0];
    end
    
    assign state_out = state_out_reg;
    
endmodule