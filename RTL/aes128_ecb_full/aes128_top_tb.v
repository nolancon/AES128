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

module aes128_top_tb();
    
    localparam T = 10;
    reg clk, reset;
	wire [127:0] key;
    wire [1407:0] expanded_key;
	wire [127:0] plain_text;
	wire [127:0] cipher_text;
	wire [127:0] decrypted_plain_text;	
	
    aes128_top i_aes128_top(
	    . clk(clk),
	    . reset(reset),
	    . key_0(key[31:0]),
	    . key_1(key[63:32]),
	    . key_2(key[95:64]),
	    . key_3(key[127:96]),
	    . plain_text_0(plain_text[31:0]),
	    . plain_text_1(plain_text[63:32]),
	    . plain_text_2(plain_text[95:64]),
	    . plain_text_3(plain_text[127:96]),	 
//	    . expanded_key(expanded_key),
	    . cipher_text_0(cipher_text[31:0]),
	    . cipher_text_1(cipher_text[63:32]),
	    . cipher_text_2(cipher_text[95:64]),
	    . cipher_text_3(cipher_text[127:96]),
	    . decrypted_plain_text_0(decrypted_plain_text[31:0]),
	    . decrypted_plain_text_1(decrypted_plain_text[63:32]),
	    . decrypted_plain_text_2(decrypted_plain_text[95:64]),
	    . decrypted_plain_text_3(decrypted_plain_text[127:96]));
	

    always
    begin
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end
    
    initial
    begin
        reset = 1'b1;
        #(T/2);
        reset = 1'b0;
    end
    
    assign key = 128'h100F0E0D0C0B0A090807060504030201;
    
    //assign plain_text = 128'h00FFFEFDFCFBFAF9F8F7F6F5F4F3F2F1; 
    
    assign plain_text = 128'h54494d47206e616c6f4e20726f6e6f43;
    
//    assign plain_text = 128'hF0EFEEEDECEBEAE9E8E7E6E5E4E3E2E1; 
//    assign plain_text = 128'hE0DFDEDDDCDBDAD9D8D7D6D5D4D3D2D1; 
//    assign plain_text = 128'hD0CFCECDCCCBCAC9C8C7C6C5C4C3C2C1; 
//    assign plain_text = 128'hC0BFBEBDBCBBBAB9B8B7B6B5B4B3B2B1; 
//    assign plain_text = 128'hB0AFAEADACABAAA9A8A7A6A5A4A3A2A1; 
//    assign plain_text = 128'h908F8E8D8C8B8A898887868584838281; 
//    assign plain_text = 128'h807F7E7D7C7B7A797877767574737271;    
//    assign plain_text = 128'h706F6E6D6C6B6A696867666564636261;
//    assign plain_text = 128'h605F5E5D5C5B5A595857565554535251;
//	  assign plain_text = 128'h504F4E4D4C4B4A494847464544434241;
//	  assign plain_text = 128'h403F3E3D3C3B3A393837363534333231;
//	  assign plain_text = 128'h302F2E2D2C2B2A292827262524232221;
//	  assign plain_text = 128'h201F1E1D1C1B1A191817161514131211;
//    assign plain_text = 128'h100F0E0D0C0B0A090807060504030201;
endmodule