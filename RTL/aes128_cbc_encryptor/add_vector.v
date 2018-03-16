`timescale 1ns / 1ps


module add_vector(
    input wire clk,
    input wire reset,
    input wire [127:0] vector,
    input wire [127:0] add_vector_in,
    output wire [127:0] add_vector_out
	);
	
	
	
	
	//Internal logic
	reg [127:0] vector_temp;
	reg [127:0] add_vector_temp; 
	reg [127:0] add_vector_next;
	
	
	
//	always @(posedge clk)
//    begin
//        state_ark_out_reg <= state_ark_out_next;
//    end
	
	always @*
    begin
    	//Combinational logic
    	vector_temp = vector;
    	add_vector_temp = add_vector_in;
    	//Add Round Key
        add_vector_next = add_vector_temp[127:0] ^ vector_temp[127:0];
    end
    
    assign add_vector_out = add_vector_next;
	
	
endmodule