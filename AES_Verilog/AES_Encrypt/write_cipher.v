`timescale 1ns / 1ps


module write_cipher (
	input wire clk,
	input wire [127:0] cipher_text,
//	output wire[15:0] led,	
	output wire [127:0] cipher_out
	);

reg [127:0] cipher_out_reg;
reg [127:0] cipher_text_temp;
reg [7:0] temp;
reg [7:0] out_ram [15:0];
integer i;
	
	
always @(posedge clk)
    begin
        cipher_out_reg <= cipher_text;
    end	
	
always @*
begin
	cipher_text_temp[127:0] = cipher_text[127:0];
	for(i=0;i<16;i=i+1)
		begin
		out_ram[i] = cipher_text_temp[7:0];
		cipher_text_temp = cipher_text_temp >> 8;
		end
	
//		if (out_ram[15] == 8'ha7) 
//			led_next[15] = 1'b1;
//		else
//			led_next[15] = 1'b0;
//		
//		if (out_ram[14] == 8'h28)
//			led_next[14] = 1'b1;
//		else
//			led_next[14] = 1'b0;
//		
//		if (out_ram[13] == 8'h6e)
//			led_next[13] = 1'b1;
//		else
//			led_next[13] = 1'b0;
//		
//		if (out_ram[12] == 8'h22) 
//			led_next[12] = 1'b1;
//		else
//			led_next[12] = 1'b0;
//		
//		if (out_ram[11] == 8'hc5) 
//			led_next[11] = 1'b1;
//		else
//			led_next[11] = 1'b0;
//		
//		if (out_ram[10] == 8'hd2) 
//			led_next[10] = 1'b1;
//		else
//			led_next[10] = 1'b0;
//		
//		if (out_ram[9] == 8'h11) 
//			led_next[9] = 1'b1;
//		else
//			led_next[9] = 1'b0;
//		
//		if (out_ram[8] == 8'h3d) 
//			led_next[8] = 1'b1;
//		else
//			led_next[8] = 1'b0;
//		
//		if (out_ram[7] == 8'h10) 
//			led_next[7] = 1'b1;
//		else
//			led_next[7] = 1'b0;
//		
//		if (out_ram[6] == 8'h22) 
//			led_next[6] = 1'b1;
//		else
//			led_next[6] = 1'b0;
//		
//		if (out_ram[5] == 8'h7c) 
//			led_next[5] = 1'b1;
//		else
//			led_next[5] = 1'b0;
//		
//		if (out_ram[4] == 8'hc2) 
//			led_next[4] = 1'b1;
//		else
//			led_next[4] = 1'b0;
//		
//		if (out_ram[3] == 8'hcd) 
//			led_next[3] = 1'b1;
//		else
//			led_next[3] = 1'b0;
//		
//		if (out_ram[2] == 8'hf8)
//			led_next[2] = 1'b1;
//		else
//			led_next[2] = 1'b0;	
//		
//		if (out_ram[1] == 8'h8f) 
//			led_next[1] = 1'b1;
//		else
//			led_next[1] = 1'b0;		
//		
//		if (out_ram[0] == 8'h39)
//			led_next[0] = 1'b1;
//		else
//			led_next[0] = 1'b0;
	end

assign cipher_out = cipher_out_reg;

endmodule