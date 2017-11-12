`timescale 1ns / 1ps


module inv_shift_rows(
    input wire clk,
    input wire [127:0] state_isr_in,
    output wire [127:0] state_isr
	);
	
	//Internal logic
	reg [127:0] temp; 
	reg [127:0] state_isr_reg; 
	reg [127:0] state_isr_next;
	
	
	
	always @(posedge clk)
    begin
        state_isr_reg <= state_isr_next;
    end
	
	always @*
    begin
    	//Combinational logic
    	state_isr_next = state_isr_in;
	
	  //Shift Rows
	    temp[7:0] = state_isr_next[7:0];
	    temp[15:8] = state_isr_next[111:104];
	    temp[23:16] = state_isr_next[87:80];
	    temp[31:24] = state_isr_next[63:56];
	
	    temp[39:32] = state_isr_next[39:32];
	    temp[47:40] = state_isr_next[15:8];
	    temp[55:48] = state_isr_next[119:112];
	    temp[63:56] = state_isr_next[95:88];
	
	    temp[71:64] = state_isr_next[71:64];
	    temp[79:72] = state_isr_next[47:40];
	    temp[87:80] = state_isr_next[23:16];
	    temp[95:88] = state_isr_next[127:120];
	
	    temp[103:96] = state_isr_next[103:96];
	    temp[111:104] = state_isr_next[79:72];
	    temp[119:112] = state_isr_next[55:48];
	    temp[127:120] = state_isr_next[31:24];
	    
	    state_isr_next[127:0] = temp[127:0];
    end
    
    assign state_isr = state_isr_reg;
    
endmodule