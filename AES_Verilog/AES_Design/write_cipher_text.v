module write_cipher_text (
	input wire clk,
	input wire [127:0] cipher_text,
	output wire [127:0] file_out
	);

reg [127:0] file_out_reg;
reg [127:0] file_out_next;
//reg [7:0] out_ram [127:0];
integer i;
integer file_id;
	
always @ (posedge clk)
	begin
  		file_out_reg = file_out_next;
	end
	
always @*
begin
  	file_id = $fopen("C:\\Users\\cmsno\\Desktop\\outputH.txt", "w");
	file_out_next = cipher_text;
//	#10
//	for(i=0;i<16;i=i+1)
//		begin
			$fwrite(file_id, "%02h ", file_out_next);
//		end
//		#10
		$fclose(file_id);
	end

assign file_out = file_out_reg;

endmodule