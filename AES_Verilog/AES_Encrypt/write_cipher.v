`timescale 1ns / 1ps


module write_cipher (
	input wire clk,
	input wire [127:0] cipher_text,
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

	end

assign cipher_out = cipher_out_reg;

endmodule