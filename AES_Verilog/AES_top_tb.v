`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2017 11:40:35
// Design Name: 
// Module Name: AES_top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module AES_top_tb();
    
    localparam T = 10;
    reg clk, rst;
    wire [127:0] key;
    wire [1407:0] expanded_key;
	
	wire [127:0] plain_text;
	wire [127:0] cypher_text;
    
    
    AES_top i_AES_top(.clk(clk), .key(key), .plain_text(plain_text), .expanded_key(expanded_key), .cypher_text(cypher_text));
    
    always
    begin
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end
    
    initial
    begin
        rst = 1'b1;
        #(T/2);
        rst = 1'b0;
    end
    
    assign  key = 128'h100F0E0D0C0B0A090807060504030201;
	assign plain_text = 128'h54494D47206E616C6F4E20726F6E6F43;
    
endmodule