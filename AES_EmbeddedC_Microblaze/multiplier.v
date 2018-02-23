`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.02.2018 13:44:50
// Design Name: 
// Module Name: multiplier
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


module multiplier(
    input wire clk,
    input [15:0] a,
    input [15:0] b,
    output [32:0] p
    );
    
    reg [32:0] p_reg;
    
    always @ (posedge clk)
    begin
        p_reg <= a * b;
    end
             
    assign p = p_reg;
endmodule
