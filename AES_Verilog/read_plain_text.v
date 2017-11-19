module read_plain_text (
	input wire clk,
	output wire [127:0] file_in
	);

reg [127:0] file_in_reg;
reg [7:0] temp;
reg [127:0] file_in_next;
reg [7:0] in_ram [127:0];
integer i;
	
always @ (posedge clk)
	begin
  		file_in_reg = file_in_next;
	end
	
initial
begin
  	$readmemh("C:\\Users\\cmsno\\Desktop\\inputH.txt", in_ram);
	
	for(i=0;i<15;i=i+1)
		begin
		temp[7:0] = in_ram[i];
		file_in_next[127:120] = temp[7:0];
		file_in_next = file_in_next >> 8;
		end
	file_in_next[127:120] = in_ram[15];
end

assign file_in = file_in_reg;

endmodule