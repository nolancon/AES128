module read_plain_text (
	input wire clk,
	output wire [127:0] plain_text_file_in
	);

reg [127:0] plain_text_file_in_reg;
reg [7:0] temp;
reg [127:0] plain_text_file_in_next;
reg [7:0] in_ram [127:0];
integer i;
	
always @ (posedge clk)
	begin
  		plain_text_file_in_reg = plain_text_file_in_next;
	end
	
initial
begin
  	$readmemh("C:\\Users\\cmsno\\Desktop\\AES_IO\\PlainTextHex.txt", in_ram);
	
	for(i=0;i<15;i=i+1)
		begin
		temp[7:0] = in_ram[i];
		plain_text_file_in_next[127:120] = temp[7:0];
		plain_text_file_in_next = plain_text_file_in_next >> 8;
		end
	plain_text_file_in_next[127:120] = in_ram[15];
end

assign plain_text_file_in = plain_text_file_in_reg;

endmodule