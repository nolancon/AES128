`timescale 1ns / 1ps


module wrapper_top(
    input wire clk,
    output cipher_text,
    output decrypted_plain_text
//    input [7:0] swt,
//    output [7:0] led
	);
	 
	 wire [127:0]key;
	 wire[127:0] plain_text;
	 wire [1407:0] expanded_key;
	 wire cipher_text;
	 wire decrypted_plain_text;
   
   
//   assign led[0] = swt[0];
//   always @(*)
//	   begin
//		   led = sw;
//	   end
	   
   	assign key = 128'h100F0E0D0C0B0A090807060504030201;
	assign plain_text = 128'h00FFFEFDFCFBFAF9F8F7F6F5F4F3F2F1; 
    
	AES_top i_AES_top(
	    . clk(clk), 
	    . key(key), 
	    . plain_text(plain_text),
	    . expanded_key(expanded_key), 
	    . cipher_text(cipher_text),
	    . decrypted_plain_text(decrypted_plain_text));
	
	 
    
	

endmodule 