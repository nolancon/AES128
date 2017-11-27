`timescale 1ns / 1ps


module wrapper_top(
    input wire clk
	);
	 
	 wire [127:0]key;
	 wire[127:0] plain_text;
	 wire [127:0] file_in;
	 wire [127:0] file_out;
	 wire [1407:0] expanded_key;
	 wire [127:0] cipher_text;
	 wire [127:0] decrypted_plain_text;
   
    
	AES_top i_AES_top(
	    . clk(clk), 
	    . key(key), 
	    . plain_text(plain_text),
//	    . file_in(file_in),
//	    . file_out(file_out),
	    . expanded_key(expanded_key), 
	    . cipher_text(cipher_text),
	    . decrypted_plain_text(decrypted_plain_text));
	
	 
    assign key = 128'h100F0E0D0C0B0A090807060504030201;

endmodule 