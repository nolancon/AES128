`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2017 20:13:27
// Design Name: 
// Module Name: AES_top
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


module AES_top(
    input wire clk,
    output wire [1407:0] finalKey
    );
    
    wire [127:0] key;
    assign  key = 128'h100F0E0D0C0B0A090807060504030201;
    
    KeyExpansion i_KeyExpansion(.clk(clk), .key(key), .expandedKey(expandedKey));
    
    
    assign finalKey = expandedKey;
       
    
endmodule
