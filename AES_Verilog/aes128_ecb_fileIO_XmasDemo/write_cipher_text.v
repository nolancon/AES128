module write_cipher_text (
	input wire clk,
	input wire [127:0] cipher_text,
	output wire [127:0] cipher_text_file_out
	);

reg [127:0] cipher_text_file_out_reg;
reg [127:0] cipher_text_file_out_next;
reg [127:0] cipher_text_temp;
reg [7:0] temp;
reg [7:0] out_ram [127:0];
integer i;
integer file_id;
	
always @ (posedge clk)
	begin
  		cipher_text_file_out_reg = cipher_text_file_out_next;
	end
	
always @*
begin
	cipher_text_temp[127:0] = cipher_text[127:0];
	for(i=0;i<16;i=i+1)
		begin
		out_ram[i] = cipher_text_temp[7:0];
		cipher_text_temp = cipher_text_temp >> 8;
		end
	
  	file_id = $fopen("C:\\Users\\cmsno\\Desktop\\AES_IO\\VerilogCipherTextHex.txt", "w");
	cipher_text_file_out_next = cipher_text;
	
	for(i=0;i<16;i=i+1)
		begin
		$fwrite(file_id, "%02h ", out_ram[i]);
		end
	
	$fclose(file_id);

	end

assign cipher_text_file_out = cipher_text_file_out_reg;

endmodule