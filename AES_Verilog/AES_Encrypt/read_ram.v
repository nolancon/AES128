`timescale 1ns / 1ps


module read_ram (
	input wire clk,
	output wire [127:0] key_in,	
	output wire [127:0] plain_in	
//	output wire [15:0] led
	);

//reg[15:0] led_reg;
//reg [15:0] led_next;

reg [7:0]tempk;
reg [127:0] key_next;
reg [7:0] key_ram [15:0];
	
reg [7:0]temp;
reg [127:0] plain_next;
reg [7:0] plain_ram [15:0];
	
integer i;
integer j;
	

always @(posedge clk)
begin
	// Read 16B key from ram
	key_ram[0] = 8'h01;
	key_ram[1] = 8'h02;
	key_ram[2] = 8'h03;
	key_ram[3] = 8'h04;
	key_ram[4] = 8'h05;
	key_ram[5] = 8'h06;
	key_ram[6] = 8'h07;
	key_ram[7] = 8'h08;
	key_ram[8] = 8'h09;
	key_ram[9] = 8'h0a;
	key_ram[10] = 8'h0b;
	key_ram[11] = 8'h0c;
	key_ram[12] = 8'h0d;
	key_ram[13] = 8'h0e;
	key_ram[14] = 8'h0f;
	key_ram[15] = 8'h10;
	    
	// Read 16B plain text from ram
	plain_ram[0] = 8'hf1;
	plain_ram[1] = 8'hf2;
	plain_ram[2] = 8'hf3;
	plain_ram[3] = 8'hf4;
	plain_ram[4] = 8'hf5;
	plain_ram[5] = 8'hf6;
	plain_ram[6] = 8'hf7;
	plain_ram[7] = 8'hf8;
	plain_ram[8] = 8'hf9;
	plain_ram[9] = 8'hfa;
	plain_ram[10] = 8'hfb;
	plain_ram[11] = 8'hfc;
	plain_ram[12] = 8'hfd;
	plain_ram[13] = 8'hfe;
	plain_ram[14] = 8'hff;
	plain_ram[15] = 8'h00;
	
//	led_reg <= led_next;
	
end
    
always@*
begin
	    
	for(i=0;i<15;i=i+1)
	begin
		temp[7:0] = plain_ram[i];
		plain_next[127:120] = temp[7:0];
		plain_next = plain_next >> 8;
	end
	
	plain_next[127:120] = plain_ram[15];

	for(j=0;j<15;j=j+1)
	begin
		tempk[7:0] = key_ram[j];
		key_next[127:120] = tempk[7:0];
		key_next = key_next >> 8;
	end
				
	key_next[127:120] = key_ram[15];
	
	
//	if (key_ram[14] == 8'h0f) 
//		led_next[15:0] = 16'b1111111111111111;
//	else
//		led_next[15:0] = 16'b0000000000000000;		

end

assign key_in = key_next;
assign plain_in = plain_next;
//assign led = led_reg;

endmodule