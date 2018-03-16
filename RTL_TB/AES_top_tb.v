module AES_top_tb;
    
    localparam T = 10;
    reg clk, rst;
    wire [127:0] key;
    wire [1407:0] expandedKey;
    
    KeyExpansion i_KeyExpansion(.clk(clk), .key(key), .expandedKey(expandedKey));
    
    always
    begin
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end
    
    initial
    begin
        rst = 1'b1;
        #(T/2);
        rst = 1'b0;
    end
    
    assign  key = 128'h100F0E0D0C0B0A090807060504030201;

    
endmodule