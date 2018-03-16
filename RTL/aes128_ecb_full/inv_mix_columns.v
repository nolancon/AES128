`timescale 1ns / 1ps
//`include "tables.v"
//import tables;

module inv_mix_columns(
    input wire clk,
    input wire reset,
    input wire [127:0] state_imc_in,
    output wire [127:0] state_imc_out
	);
	
		
	//Internal logic
	reg [127:0] temp; 
	reg [127:0] state_imc_out_reg; 
	reg [127:0] state_imc_out_next;
	
	wire [127:0] mul_14_out;
	reg [127:0] mul_14_reg;
	
	wire [127:0] mul_13_out;
	reg [127:0] mul_13_reg;
	
	wire [127:0] mul_11_out;
	reg [127:0] mul_11_reg;
	
	wire [127:0] mul_9_out;
	reg [127:0] mul_9_reg;
	
	
	always @(posedge clk)
    begin
        state_imc_out_reg <= state_imc_out_next;
		mul_14_reg <= mul_14_out;
    	mul_13_reg <= mul_13_out;
    	mul_11_reg <= mul_11_out;
    	mul_9_reg <= mul_9_out;
    end
	
	always @*
    begin
//    	//Combinational logic
    	state_imc_out_next = state_imc_in;
    	
        temp[7:0] =  (mul_14_reg[7:0]) ^ (mul_11_reg[15:8]) ^ (mul_13_reg[23:16]) ^ (mul_9_reg[31:24]);
        temp[15:8] = (mul_9_reg[7:0]) ^ (mul_14_reg[15:8]) ^ (mul_11_reg[23:16]) ^ (mul_13_reg[31:24]);
        temp[23:16] = (mul_13_reg[7:0]) ^ (mul_9_reg[15:8]) ^ (mul_14_reg[23:16]) ^ (mul_11_reg[31:24]);
        temp[31:24] = (mul_11_reg[7:0]) ^ (mul_13_reg[15:8]) ^ (mul_9_reg[23:16]) ^ (mul_14_reg[31:24]);
    
        temp[39:32] = (mul_14_reg[39:32]) ^ (mul_11_reg[47:40]) ^ (mul_13_reg[55:48]) ^ (mul_9_reg[63:56]);
        temp[47:40] = (mul_9_reg[39:32]) ^ (mul_14_reg[47:40]) ^ (mul_11_reg[55:48]) ^ (mul_13_reg[63:56]);
        temp[55:48] = (mul_13_reg[39:32]) ^ (mul_9_reg[47:40]) ^ (mul_14_reg[55:48])^ (mul_11_reg[63:56]);
        temp[63:56] = (mul_11_reg[39:32]) ^ (mul_13_reg[47:40]) ^ (mul_9_reg[55:48]) ^ (mul_14_reg[63:56]);
    
        temp[71:64] = (mul_14_reg[71:64]) ^ (mul_11_reg[79:72]) ^ (mul_13_reg[87:80]) ^ (mul_9_reg[95:88]);
        temp[79:72] = (mul_9_reg[71:64]) ^ (mul_14_reg[79:72]) ^ (mul_11_reg[87:80]) ^ (mul_13_reg[95:88]);
        temp[87:80] = (mul_13_reg[71:64]) ^ (mul_9_reg[79:72]) ^ (mul_14_reg[87:80])^ (mul_11_reg[95:88]);
        temp[95:88] = (mul_11_reg[71:64]) ^ (mul_13_reg[79:72]) ^ (mul_9_reg[87:80]) ^ (mul_14_reg[95:88]);
        
        temp[103:96] = (mul_14_reg[103:96]) ^ (mul_11_reg[111:104]) ^ (mul_13_reg[119:112]) ^ (mul_9_reg[127:120]);
        temp[111:104] = (mul_9_reg[103:96]) ^ (mul_14_reg[111:104]) ^ (mul_11_reg[119:112]) ^ (mul_13_reg[127:120]);
        temp[119:112] = (mul_13_reg[103:96]) ^ (mul_9_reg[111:104]) ^ (mul_14_reg[119:112]) ^ (mul_11_reg[127:120]);
        temp[127:120] = (mul_11_reg[103:96]) ^ (mul_13_reg[111:104]) ^ (mul_9_reg[119:112]) ^ (mul_14_reg[127:120]);
        
        state_imc_out_next[127:0] = temp[127:0];


    end
    
    assign state_imc_out = state_imc_out_next;
    
    mul_14 i_mul_14(
	    . mul_14_in(state_imc_in),
	    . mul_14_out(mul_14_out));
    
    mul_13 i_mul_13(
	    . mul_13_in(state_imc_in),
	    . mul_13_out(mul_13_out));
    
    mul_11 i_mul_11(
	    . mul_11_in(state_imc_in),
	    . mul_11_out(mul_11_out));
    
    mul_9 i_mul_9(
	    . mul_9_in(state_imc_in),
	    . mul_9_out(mul_9_out));
		

     
    
endmodule