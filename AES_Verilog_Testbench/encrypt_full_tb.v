/* 
 * Do not change Module name 
*/
module main;
  
    reg[127:0] key;
    reg[1407:0] expandedKey;
    reg[1407:0] expandedKey_temp;
    reg[127:0] plainText;
    reg[127:0] state;
    reg[127:0] cypherText;
    reg[127:0] temp;
    integer index;

    
    initial 
        begin
        key = 128'h100F0E0D0C0B0A090807060504030201;
        plainText = 128'h54494D47206E616C6F4E20726F6E6F43;
        expandedKey = 1408'h8740b1b1656281a1735c1a6f4214c4bce2223010163e9bce3148ded3888c578ef41cabde2776451db9c4895d9533cbf7d36aeec39eb2cc402cf742aabb55c95f4dd82283b2458eea97a28bf557b6a88cff9dac6925e7051fc0142379aea0f63dda7aa976e5f326666eb4d54496f72cfe3f898f108b47f322f843f9ba5c828b85b4ce7c3273040a98a4c1723f7f0f0091c7ca76aad7c578a7dbce72aed3c974ab100f0e0d0c0b0a090807060504030201;

        expandedKey_temp[1407:0] = expandedKey[1407:0];

        //Add Round Key
        state[127:0] = key[127:0] ^ plainText[127:0];
        $display("Add Key");
        $display("%h",state[127:0]);
        
        
        for(index=1;index<10;index=index+1) //Perform first 9 rounds
        begin
            //Sub Bytes (S-Box)
            state[7:0] = sbox(state[7:0]);      //0
            state[15:8] = sbox(state[15:8]);    //1
            state[23:16] = sbox(state[23:16]);  //2
            state[31:24] = sbox(state[31:24]);  //3
            state[39:32] = sbox(state[39:32]);  //4
            state[47:40] = sbox(state[47:40]);  //5
            state[55:48] = sbox(state[55:48]);  //6
            state[63:56] = sbox(state[63:56]);  //7
            state[71:64] = sbox(state[71:64]);  //8
            state[79:72] = sbox(state[79:72]);  //9
            state[87:80] = sbox(state[87:80]);  //10
            state[95:88] = sbox(state[95:88]);  //11
            state[103:96] = sbox(state[103:96]);    //12
            state[111:104] = sbox(state[111:104]);  //13
            state[119:112] = sbox(state[119:112]);  //14
            state[127:120] = sbox(state[127:120]);  //15
            
            $display("Sub Bytes %d",index);
            $display("%h",state[127:0]);
    
            
            //Shift Rows
            temp[7:0] = state[7:0];
        	temp[15:8] = state[47:40];
        	temp[23:16] = state[87:80];
        	temp[31:24] = state[127:120];
        
        	temp[39:32] = state[39:32];
        	temp[47:40] = state[79:72];
        	temp[55:48] = state[119:112];
        	temp[63:56] = state[31:24];
        
        	temp[71:64] = state[71:64];
        	temp[79:72] = state[111:104];
        	temp[87:80] = state[23:16];
        	temp[95:88] = state[63:56];
        
        	temp[103:96] = state[103:96];
        	temp[111:104] = state[15:8];
        	temp[119:112] = state[55:48];
        	temp[127:120] = state[95:88];
            
            state[127:0] = temp[127:0];
            $display("Shift Rows");
            $display("%h",state[127:0]);
           
         
           
           //Mix Columns
            temp[7:0] =  mul_by_2(state[7:0]) ^ mul_by_3(state[15:8]) ^ state[23:16] ^ state[31:24];
        	temp[15:8] = state[7:0] ^ mul_by_2(state[15:8]) ^ mul_by_3(state[23:16]) ^ state[31:24];
        	temp[23:16] = state[7:0] ^ state[15:8] ^ mul_by_2(state[23:16]) ^ mul_by_3(state[31:24]);
        	temp[31:24] = mul_by_3(state[7:0]) ^ state[15:8] ^ state[23:16] ^ mul_by_2(state[31:24]);
        
        	temp[39:32] = mul_by_2(state[39:32]) ^ mul_by_3(state[47:40]) ^ state[55:48] ^ state[63:56];
        	temp[47:40] = state[39:32] ^ mul_by_2(state[47:40]) ^ mul_by_3(state[55:48]) ^ state[63:56];
        	temp[55:48] = state[39:32] ^ state[47:40] ^ mul_by_2(state[55:48])^mul_by_3(state[63:56]);
        	temp[63:56] = mul_by_3(state[39:32]) ^ state[47:40] ^ state[55:48] ^ mul_by_2(state[63:56]);
        
        	temp[71:64] = mul_by_2(state[71:64]) ^ mul_by_3(state[79:72]) ^ state[87:80] ^ state[95:88];
        	temp[79:72] = state[71:64] ^ mul_by_2(state[79:72]) ^ mul_by_3(state[87:80]) ^ state[95:88];
        	temp[87:80] = state[71:64] ^ state[79:72] ^ mul_by_2(state[87:80])^mul_by_3(state[95:88]);
        	temp[95:88] = mul_by_3(state[71:64]) ^ state[79:72] ^ state[87:80] ^ mul_by_2(state[95:88]);
        	
        	temp[103:96] = mul_by_2(state[103:96]) ^ mul_by_3(state[111:104]) ^ state[119:112] ^ state[127:120];
        	temp[111:104] = state[103:96] ^ mul_by_2(state[111:104]) ^ mul_by_3(state[119:112]) ^ state[127:120];
        	temp[119:112] = state[103:96] ^ state[111:104] ^ mul_by_2(state[119:112]) ^ mul_by_3(state[127:120]);
        	temp[127:120] = mul_by_3(state[103:96]) ^ state[111:104] ^ state[119:112] ^ mul_by_2(state[127:120]);
            
            state[127:0] = temp[127:0];
            $display("Mix Columns");
            $display("%h",state[127:0]);
        
        
            //Add Round Key
            
            state = state[127:0] ^ expandedKey_temp[255:128];
            $display("Add Round Key %d", index);
            $display("%h",state[127:0]);
            expandedKey_temp[1407:0] = expandedKey_temp[1407:0] >> 128;
        end
        
        
        //Perform final (10th) round
        //Sub Bytes (S-Box)
        state[7:0] = sbox(state[7:0]);      //0
        state[15:8] = sbox(state[15:8]);    //1
        state[23:16] = sbox(state[23:16]);  //2
        state[31:24] = sbox(state[31:24]);  //3
        state[39:32] = sbox(state[39:32]);  //4
        state[47:40] = sbox(state[47:40]);  //5
        state[55:48] = sbox(state[55:48]);  //6
        state[63:56] = sbox(state[63:56]);  //7
        state[71:64] = sbox(state[71:64]);  //8
        state[79:72] = sbox(state[79:72]);  //9
        state[87:80] = sbox(state[87:80]);  //10
        state[95:88] = sbox(state[95:88]);  //11
        state[103:96] = sbox(state[103:96]);    //12
        state[111:104] = sbox(state[111:104]);  //13
        state[119:112] = sbox(state[119:112]);  //14
        state[127:120] = sbox(state[127:120]);  //15
        
        $display("Sub Bytes 10");
        $display("%h",state[127:0]);

        
        //Shift Rows
        temp[7:0] = state[7:0];
    	temp[15:8] = state[47:40];
    	temp[23:16] = state[87:80];
    	temp[31:24] = state[127:120];
    
    	temp[39:32] = state[39:32];
    	temp[47:40] = state[79:72];
    	temp[55:48] = state[119:112];
    	temp[63:56] = state[31:24];
    
    	temp[71:64] = state[71:64];
    	temp[79:72] = state[111:104];
    	temp[87:80] = state[23:16];
    	temp[95:88] = state[63:56];
    
    	temp[103:96] = state[103:96];
    	temp[111:104] = state[15:8];
    	temp[119:112] = state[55:48];
    	temp[127:120] = state[95:88];
        
        state[127:0] = temp[127:0];
        $display("Shift Rows");
        $display("%h",state[127:0]);
    
    
        //Add Round Key
        state = state[127:0] ^ expandedKey_temp[255:128];
        $display("Add Round Key 10");
        $display("%h",state[127:0]);
    
    
    
    end
    
    function [7:0] sbox;
        input[7:0] address;
     
        //This function implements the "s-box", it takes in one byte
        //and returns this corresponding substitued byte
        begin
          case (address)
            8'h0 : sbox = 8'h63;
            8'h1 : sbox = 8'h7C;
            8'h2 : sbox = 8'h77;
            8'h3 : sbox = 8'h7B;
            8'h4 : sbox = 8'hF2;
            8'h5 : sbox = 8'h6B;
            8'h6 : sbox = 8'h6F;
            8'h7 : sbox = 8'hC5;
            8'h8 : sbox = 8'h30;
            8'h9 : sbox = 8'h1;
            8'hA : sbox = 8'h67;
            8'hB : sbox = 8'h2B;
            8'hC : sbox = 8'hFE;
            8'hD : sbox = 8'hD7;
            8'hE : sbox = 8'hAB;
            8'hF : sbox = 8'h76;
            8'h10 : sbox = 8'hCA;
            8'h11 : sbox = 8'h82;
            8'h12 : sbox = 8'hC9;
            8'h13 : sbox = 8'h7D;
            8'h14 : sbox = 8'hFA;
            8'h15 : sbox = 8'h59;
            8'h16 : sbox = 8'h47;
            8'h17 : sbox = 8'hF0;
            8'h18 : sbox = 8'hAD;
            8'h19 : sbox = 8'hD4;
            8'h1A : sbox = 8'hA2;
            8'h1B : sbox = 8'hAF;
            8'h1C : sbox = 8'h9C;
            8'h1D : sbox = 8'hA4;
            8'h1E : sbox = 8'h72;
            8'h1F : sbox = 8'hC0;
            8'h20 : sbox = 8'hB7;
            8'h21 : sbox = 8'hFD;
            8'h22 : sbox = 8'h93;
            8'h23 : sbox = 8'h26;
            8'h24 : sbox = 8'h36;
            8'h25 : sbox = 8'h3F;
            8'h26 : sbox = 8'hF7;
            8'h27 : sbox = 8'hCC;
            8'h28 : sbox = 8'h34;
            8'h29 : sbox = 8'hA5;
            8'h2A : sbox = 8'hE5;
            8'h2B : sbox = 8'hF1;
            8'h2C : sbox = 8'h71;
            8'h2D : sbox = 8'hD8;
            8'h2E : sbox = 8'h31;
            8'h2F : sbox = 8'h15;
            8'h30 : sbox = 8'h4;
            8'h31 : sbox = 8'hC7;
            8'h32 : sbox = 8'h23;
            8'h33 : sbox = 8'hC3;
            8'h34 : sbox = 8'h18;
            8'h35 : sbox = 8'h96;
            8'h36 : sbox = 8'h5;
            8'h37 : sbox = 8'h9A;
            8'h38 : sbox = 8'h7;
            8'h39 : sbox = 8'h12;
            8'h3A : sbox = 8'h80;
            8'h3B : sbox = 8'hE2;
            8'h3C : sbox = 8'hEB;
            8'h3D : sbox = 8'h27;
            8'h3E : sbox = 8'hB2;
            8'h3F : sbox = 8'h75;
            8'h40 : sbox = 8'h9;
            8'h41 : sbox = 8'h83;
            8'h42 : sbox = 8'h2C;
            8'h43 : sbox = 8'h1A;
            8'h44 : sbox = 8'h1B;
            8'h45 : sbox = 8'h6E;
            8'h46 : sbox = 8'h5A;
            8'h47 : sbox = 8'hA0;
            8'h48 : sbox = 8'h52;
            8'h49 : sbox = 8'h3B;
            8'h4A : sbox = 8'hD6;
            8'h4B : sbox = 8'hB3;
            8'h4C : sbox = 8'h29;
            8'h4D : sbox = 8'hE3;
            8'h4E : sbox = 8'h2F;
            8'h4F : sbox = 8'h84;
            8'h50 : sbox = 8'h53;
            8'h51 : sbox = 8'hD1;
            8'h52 : sbox = 8'h0;
            8'h53 : sbox = 8'hED;
            8'h54 : sbox = 8'h20;
            8'h55 : sbox = 8'hFC;
            8'h56 : sbox = 8'hB1;
            8'h57 : sbox = 8'h5B;
            8'h58 : sbox = 8'h6A;
            8'h59 : sbox = 8'hCB;
            8'h5A : sbox = 8'hBE;
            8'h5B : sbox = 8'h39;
            8'h5C : sbox = 8'h4A;
            8'h5D : sbox = 8'h4C;
            8'h5E : sbox = 8'h58;
            8'h5F : sbox = 8'hCF;
            8'h60 : sbox = 8'hD0;
            8'h61 : sbox = 8'hEF;
            8'h62 : sbox = 8'hAA;
            8'h63 : sbox = 8'hFB;
            8'h64 : sbox = 8'h43;
            8'h65 : sbox = 8'h4D;
            8'h66 : sbox = 8'h33;
            8'h67 : sbox = 8'h85;
            8'h68 : sbox = 8'h45;
            8'h69 : sbox = 8'hF9;
            8'h6A : sbox = 8'h2;
            8'h6B : sbox = 8'h7F;
            8'h6C : sbox = 8'h50;
            8'h6D : sbox = 8'h3C;
            8'h6E : sbox = 8'h9F;
            8'h6F : sbox = 8'hA8;
            8'h70 : sbox = 8'h51;
            8'h71 : sbox = 8'hA3;
            8'h72 : sbox = 8'h40;
            8'h73 : sbox = 8'h8F;
            8'h74 : sbox = 8'h92;
            8'h75 : sbox = 8'h9D;
            8'h76 : sbox = 8'h38;
            8'h77 : sbox = 8'hF5;
            8'h78 : sbox = 8'hBC;
            8'h79 : sbox = 8'hB6;
            8'h7A : sbox = 8'hDA;
            8'h7B : sbox = 8'h21;
            8'h7C : sbox = 8'h10;
            8'h7D : sbox = 8'hFF;
            8'h7E : sbox = 8'hF3;
            8'h7F : sbox = 8'hD2;
            8'h80 : sbox = 8'hCD;
            8'h81 : sbox = 8'hC;
            8'h82 : sbox = 8'h13;
            8'h83 : sbox = 8'hEC;
            8'h84 : sbox = 8'h5F;
            8'h85 : sbox = 8'h97;
            8'h86 : sbox = 8'h44;
            8'h87 : sbox = 8'h17;
            8'h88 : sbox = 8'hC4;
            8'h89 : sbox = 8'hA7;
            8'h8A : sbox = 8'h7E;
            8'h8B : sbox = 8'h3D;
            8'h8C : sbox = 8'h64;
            8'h8D : sbox = 8'h5D;
            8'h8E : sbox = 8'h19;
            8'h8F : sbox = 8'h73;
            8'h90 : sbox = 8'h60;
            8'h91 : sbox = 8'h81;
            8'h92 : sbox = 8'h4F;
            8'h93 : sbox = 8'hDC;
            8'h94 : sbox = 8'h22;
            8'h95 : sbox = 8'h2A;
            8'h96 : sbox = 8'h90;
            8'h97 : sbox = 8'h88;
            8'h98 : sbox = 8'h46;
            8'h99 : sbox = 8'hEE;
            8'h9A : sbox = 8'hB8;
            8'h9B : sbox = 8'h14;
            8'h9C : sbox = 8'hDE;
            8'h9D : sbox = 8'h5E;
            8'h9E : sbox = 8'hB;
            8'h9F : sbox = 8'hDB;
            8'hA0 : sbox = 8'hE0;
            8'hA1 : sbox = 8'h32;
            8'hA2 : sbox = 8'h3A;
            8'hA3 : sbox = 8'hA;
            8'hA4 : sbox = 8'h49;
            8'hA5 : sbox = 8'h6;
            8'hA6 : sbox = 8'h24;
            8'hA7 : sbox = 8'h5C;
            8'hA8 : sbox = 8'hC2;
            8'hA9 : sbox = 8'hD3;
            8'hAA : sbox = 8'hAC;
            8'hAB : sbox = 8'h62;
            8'hAC : sbox = 8'h91;
            8'hAD : sbox = 8'h95;
            8'hAE : sbox = 8'hE4;
            8'hAF : sbox = 8'h79;
            8'hB0 : sbox = 8'hE7;
            8'hB1 : sbox = 8'hC8;
            8'hB2 : sbox = 8'h37;
            8'hB3 : sbox = 8'h6D;
            8'hB4 : sbox = 8'h8D;
            8'hB5 : sbox = 8'hD5;
            8'hB6 : sbox = 8'h4E;
            8'hB7 : sbox = 8'hA9;
            8'hB8 : sbox = 8'h6C;
            8'hB9 : sbox = 8'h56;
            8'hBA : sbox = 8'hF4;
            8'hBB : sbox = 8'hEA;
            8'hBC : sbox = 8'h65;
            8'hBD : sbox = 8'h7A;
            8'hBE : sbox = 8'hAE;
            8'hBF : sbox = 8'h8;
            8'hC0 : sbox = 8'hBA;
            8'hC1 : sbox = 8'h78;
            8'hC2 : sbox = 8'h25;
            8'hC3 : sbox = 8'h2E;
            8'hC4 : sbox = 8'h1C;
            8'hC5 : sbox = 8'hA6;
            8'hC6 : sbox = 8'hB4;
            8'hC7 : sbox = 8'hC6;
            8'hC8 : sbox = 8'hE8;
            8'hC9 : sbox = 8'hDD;
            8'hCA : sbox = 8'h74;
            8'hCB : sbox = 8'h1F;
            8'hCC : sbox = 8'h4B;
            8'hCD : sbox = 8'hBD;
            8'hCE : sbox = 8'h8B;
            8'hCF : sbox = 8'h8A;
            8'hD0 : sbox = 8'h70;
            8'hD1 : sbox = 8'h3E;
            8'hD2 : sbox = 8'hB5;
            8'hD3 : sbox = 8'h66;
            8'hD4 : sbox = 8'h48;
            8'hD5 : sbox = 8'h3;
            8'hD6 : sbox = 8'hF6;
            8'hD7 : sbox = 8'hE;
            8'hD8 : sbox = 8'h61;
            8'hD9 : sbox = 8'h35;
            8'hDA : sbox = 8'h57;
            8'hDB : sbox = 8'hB9;
            8'hDC : sbox = 8'h86;
            8'hDD : sbox = 8'hC1;
            8'hDE : sbox = 8'h1D;
            8'hDF : sbox = 8'h9E;
            8'hE0 : sbox = 8'hE1;
            8'hE1 : sbox = 8'hF8;
            8'hE2 : sbox = 8'h98;
            8'hE3 : sbox = 8'h11;
            8'hE4 : sbox = 8'h69;
            8'hE5 : sbox = 8'hD9;
            8'hE6 : sbox = 8'h8E;
            8'hE7 : sbox = 8'h94;
            8'hE8 : sbox = 8'h9B;
            8'hE9 : sbox = 8'h1E;
            8'hEA : sbox = 8'h87;
            8'hEB : sbox = 8'hE9;
            8'hEC : sbox = 8'hCE;
            8'hED : sbox = 8'h55;
            8'hEE : sbox = 8'h28;
            8'hEF : sbox = 8'hDF;
            8'hF0 : sbox = 8'h8C;
            8'hF1 : sbox = 8'hA1;
            8'hF2 : sbox = 8'h89;
            8'hF3 : sbox = 8'hD;
            8'hF4 : sbox = 8'hBF;
            8'hF5 : sbox = 8'hE6;
            8'hF6 : sbox = 8'h42;
            8'hF7 : sbox = 8'h68;
            8'hF8 : sbox = 8'h41;
            8'hF9 : sbox = 8'h99;
            8'hFA : sbox = 8'h2D;
            8'hFB : sbox = 8'hF;
            8'hFC : sbox = 8'hB0;
            8'hFD : sbox = 8'h54;
            8'hFE : sbox = 8'hBB;
            8'hFF : sbox = 8'h16;
            default : sbox = 8'h0;
          endcase
        end
endfunction

     function [7:0] mul_by_2;
    input [7:0] x;
 
    case (x)
      8'h00 : mul_by_2 = 8'h00;
      8'h01 : mul_by_2 = 8'h02;
      8'h02 : mul_by_2 = 8'h04;
      8'h03 : mul_by_2 = 8'h06;
      8'h04 : mul_by_2 = 8'h08;
      8'h05 : mul_by_2 = 8'h0A;
      8'h06 : mul_by_2 = 8'h0C;
      8'h07 : mul_by_2 = 8'h0E;
      8'h08 : mul_by_2 = 8'h10;
      8'h09 : mul_by_2 = 8'h12;
      8'h0A : mul_by_2 = 8'h14;
      8'h0B : mul_by_2 = 8'h16;
      8'h0C : mul_by_2 = 8'h18;
      8'h0D : mul_by_2 = 8'h1A;
      8'h0E : mul_by_2 = 8'h1C;
      8'h0F : mul_by_2 = 8'h1E;
      8'h10 : mul_by_2 = 8'h20;
      8'h11 : mul_by_2 = 8'h22;
      8'h12 : mul_by_2 = 8'h24;
      8'h13 : mul_by_2 = 8'h26;
      8'h14 : mul_by_2 = 8'h28;
      8'h15 : mul_by_2 = 8'h2A;
      8'h16 : mul_by_2 = 8'h2C;
      8'h17 : mul_by_2 = 8'h2E;
      8'h18 : mul_by_2 = 8'h30;
      8'h19 : mul_by_2 = 8'h32;
      8'h1A : mul_by_2 = 8'h34;
      8'h1B : mul_by_2 = 8'h36;
      8'h1C : mul_by_2 = 8'h38;
      8'h1D : mul_by_2 = 8'h3A;
      8'h1E : mul_by_2 = 8'h3C;
      8'h1F : mul_by_2 = 8'h3E;
      8'h20 : mul_by_2 = 8'h40;
      8'h21 : mul_by_2 = 8'h42;
      8'h22 : mul_by_2 = 8'h44;
      8'h23 : mul_by_2 = 8'h46;
      8'h24 : mul_by_2 = 8'h48;
      8'h25 : mul_by_2 = 8'h4A;
      8'h26 : mul_by_2 = 8'h4C;
      8'h27 : mul_by_2 = 8'h4E;
      8'h28 : mul_by_2 = 8'h50;
      8'h29 : mul_by_2 = 8'h52;
      8'h2A : mul_by_2 = 8'h54;
      8'h2B : mul_by_2 = 8'h56;
      8'h2C : mul_by_2 = 8'h58;
      8'h2D : mul_by_2 = 8'h5A;
      8'h2E : mul_by_2 = 8'h5C;
      8'h2F : mul_by_2 = 8'h5E;
      8'h30 : mul_by_2 = 8'h60;
      8'h31 : mul_by_2 = 8'h62;
      8'h32 : mul_by_2 = 8'h64;
      8'h33 : mul_by_2 = 8'h66;
      8'h34 : mul_by_2 = 8'h68;
      8'h35 : mul_by_2 = 8'h6A;
      8'h36 : mul_by_2 = 8'h6C;
      8'h37 : mul_by_2 = 8'h6E;
      8'h38 : mul_by_2 = 8'h70;
      8'h39 : mul_by_2 = 8'h72;
      8'h3A : mul_by_2 = 8'h74;
      8'h3B : mul_by_2 = 8'h76;
      8'h3C : mul_by_2 = 8'h78;
      8'h3D : mul_by_2 = 8'h7A;
      8'h3E : mul_by_2 = 8'h7C;
      8'h3F : mul_by_2 = 8'h7E;
      8'h40 : mul_by_2 = 8'h80;
      8'h41 : mul_by_2 = 8'h82;	  
      8'h42 : mul_by_2 = 8'h84;
      8'h43 : mul_by_2 = 8'h86;
      8'h44 : mul_by_2 = 8'h88;
      8'h45 : mul_by_2 = 8'h8A;
      8'h46 : mul_by_2 = 8'h8C;
      8'h47 : mul_by_2 = 8'h8E;
      8'h48 : mul_by_2 = 8'h90;
      8'h49 : mul_by_2 = 8'h92;
      8'h4A : mul_by_2 = 8'h94;
      8'h4B : mul_by_2 = 8'h96;
      8'h4C : mul_by_2 = 8'h98;
      8'h4D : mul_by_2 = 8'h9A;
      8'h4E : mul_by_2 = 8'h9C;
      8'h4F : mul_by_2 = 8'h9E;
      8'h50 : mul_by_2 = 8'hA0;
      8'h51 : mul_by_2 = 8'hA2;
      8'h52 : mul_by_2 = 8'hA4;
      8'h53 : mul_by_2 = 8'hA6;
      8'h54 : mul_by_2 = 8'hA8;
      8'h55 : mul_by_2 = 8'hAA;
      8'h56 : mul_by_2 = 8'hAC;
      8'h57 : mul_by_2 = 8'hAE;
      8'h58 : mul_by_2 = 8'hB0;
      8'h59 : mul_by_2 = 8'hB2;
      8'h5A : mul_by_2 = 8'hB4;
      8'h5B : mul_by_2 = 8'hB6;
      8'h5C : mul_by_2 = 8'hB8;
      8'h5D : mul_by_2 = 8'hBA;
      8'h5E : mul_by_2 = 8'hBC;
      8'h5F : mul_by_2 = 8'hBE;
      8'h60 : mul_by_2 = 8'hC0;
      8'h61 : mul_by_2 = 8'hC2;
      8'h62 : mul_by_2 = 8'hC4;
      8'h63 : mul_by_2 = 8'hC6;
      8'h64 : mul_by_2 = 8'hC8;
      8'h65 : mul_by_2 = 8'hCA;
      8'h66 : mul_by_2 = 8'hCC;
      8'h67 : mul_by_2 = 8'hCE;
      8'h68 : mul_by_2 = 8'hD0;
      8'h69 : mul_by_2 = 8'hD2;
      8'h6A : mul_by_2 = 8'hD4;
      8'h6B : mul_by_2 = 8'hD6;
      8'h6C : mul_by_2 = 8'hD8;
      8'h6D : mul_by_2 = 8'hDA;
      8'h6E : mul_by_2 = 8'hDC;
      8'h6F : mul_by_2 = 8'hDE;
      8'h70 : mul_by_2 = 8'hE0;
      8'h71 : mul_by_2 = 8'hE2;
      8'h72 : mul_by_2 = 8'hE4;
      8'h73 : mul_by_2 = 8'hE6;
      8'h74 : mul_by_2 = 8'hE8;
      8'h75 : mul_by_2 = 8'hEA;
      8'h76 : mul_by_2 = 8'hEC;
      8'h77 : mul_by_2 = 8'hEE;
      8'h78 : mul_by_2 = 8'hF0;	  
      8'h79 : mul_by_2 = 8'hF2;
      8'h7A : mul_by_2 = 8'hF4;
      8'h7B : mul_by_2 = 8'hF6;
      8'h7C : mul_by_2 = 8'hF8;
      8'h7D : mul_by_2 = 8'hFA;
      8'h7E : mul_by_2 = 8'hFC;
      8'h7F : mul_by_2 = 8'hFE;
      8'h80 : mul_by_2 = 8'h1B;
      8'h81 : mul_by_2 = 8'h19;
      8'h82 : mul_by_2 = 8'h1F;
      8'h83 : mul_by_2 = 8'h1D;
      8'h84 : mul_by_2 = 8'h13;
      8'h85 : mul_by_2 = 8'h11;
      8'h86 : mul_by_2 = 8'h17;
      8'h87 : mul_by_2 = 8'h15;
      8'h88 : mul_by_2 = 8'h0B;
      8'h89 : mul_by_2 = 8'h09;
      8'h8A : mul_by_2 = 8'h0F;
      8'h8B : mul_by_2 = 8'h0D;
      8'h8C : mul_by_2 = 8'h03;
      8'h8D : mul_by_2 = 8'h01;
      8'h8E : mul_by_2 = 8'h07;
      8'h8F : mul_by_2 = 8'h05;
      8'h90 : mul_by_2 = 8'h3B;
      8'h91 : mul_by_2 = 8'h39;
      8'h92 : mul_by_2 = 8'h3F;
      8'h93 : mul_by_2 = 8'h3D;
      8'h94 : mul_by_2 = 8'h33;
      8'h95 : mul_by_2 = 8'h31;
      8'h96 : mul_by_2 = 8'h37;
      8'h97 : mul_by_2 = 8'h35;
      8'h98 : mul_by_2 = 8'h2B;
      8'h99 : mul_by_2 = 8'h29;
      8'h9A : mul_by_2 = 8'h2F;
      8'h9B : mul_by_2 = 8'h2D;
      8'h9C : mul_by_2 = 8'h23;
      8'h9D : mul_by_2 = 8'h21;
      8'h9E : mul_by_2 = 8'h27;
      8'h9F : mul_by_2 = 8'h25;
      8'hA0 : mul_by_2 = 8'h5B;
      8'hA1 : mul_by_2 = 8'h59;
      8'hA2 : mul_by_2 = 8'h5F;
      8'hA3 : mul_by_2 = 8'h5D;
      8'hA4 : mul_by_2 = 8'h53;
      8'hA5 : mul_by_2 = 8'h51;
      8'hA6 : mul_by_2 = 8'h57;
      8'hA7 : mul_by_2 = 8'h55;
      8'hA8 : mul_by_2 = 8'h4B;
      8'hA9 : mul_by_2 = 8'h49;
      8'hAA : mul_by_2 = 8'h4F;
      8'hAB : mul_by_2 = 8'h4D;
      8'hAC : mul_by_2 = 8'h43;
      8'hAD : mul_by_2 = 8'h41;
      8'hAE : mul_by_2 = 8'h47;
      8'hAF : mul_by_2 = 8'h45;
      8'hB0 : mul_by_2 = 8'h7B;
      8'hB1 : mul_by_2 = 8'h79;
      8'hB2 : mul_by_2 = 8'h7F;
      8'hB3 : mul_by_2 = 8'h7D;
      8'hB4 : mul_by_2 = 8'h73;	  
      8'hB5 : mul_by_2 = 8'h71;
      8'hB6 : mul_by_2 = 8'h77;
      8'hB7 : mul_by_2 = 8'h75;
      8'hB8 : mul_by_2 = 8'h6B;
      8'hB9 : mul_by_2 = 8'h69;
      8'hBA : mul_by_2 = 8'h6F;
      8'hBB : mul_by_2 = 8'h6D;
      8'hBC : mul_by_2 = 8'h63;
      8'hBD : mul_by_2 = 8'h61;
      8'hBE : mul_by_2 = 8'h67;
      8'hBF : mul_by_2 = 8'h65;
      8'hC0 : mul_by_2 = 8'h9B;
      8'hC1 : mul_by_2 = 8'h99;
      8'hC2 : mul_by_2 = 8'h9F;
      8'hC3 : mul_by_2 = 8'h9D;
      8'hC4 : mul_by_2 = 8'h93;
	  8'hC5 : mul_by_2 = 8'h91;
      8'hC6 : mul_by_2 = 8'h97;
      8'hC7 : mul_by_2 = 8'h95;
      8'hC8 : mul_by_2 = 8'h8B;
      8'hC9 : mul_by_2 = 8'h89;
      8'hCA : mul_by_2 = 8'h8F;
      8'hCB : mul_by_2 = 8'h8D;
      8'hCC : mul_by_2 = 8'h83;
	  8'hCD : mul_by_2 = 8'h81;
      8'hCE : mul_by_2 = 8'h87;
      8'hCF : mul_by_2 = 8'h85;
      8'hC0 : mul_by_2 = 8'hBB;
      8'hD1 : mul_by_2 = 8'hB9;
      8'hD2 : mul_by_2 = 8'hBF;
      8'hD3 : mul_by_2 = 8'hBD;
      8'hD4 : mul_by_2 = 8'hB3;
	  8'hD5 : mul_by_2 = 8'hB1;
      8'hD6 : mul_by_2 = 8'hB7;
      8'hD7 : mul_by_2 = 8'hB5;
	  8'hD8 : mul_by_2 = 8'hAB;
      8'hD9 : mul_by_2 = 8'hA9;
      8'hDA : mul_by_2 = 8'hAF;
	  8'hDB : mul_by_2 = 8'hAD;
      8'hDC : mul_by_2 = 8'hA3;
	  8'hDD : mul_by_2 = 8'hA1;
      8'hDE : mul_by_2 = 8'hA7;
      8'hDF : mul_by_2 = 8'hA5;	  
      8'hE0 : mul_by_2 = 8'hDB;
      8'hE1 : mul_by_2 = 8'hD9;
      8'hE2 : mul_by_2 = 8'hDF;
      8'hE3 : mul_by_2 = 8'hDD;
      8'hE4 : mul_by_2 = 8'hD3;
      8'hE5 : mul_by_2 = 8'hD1;
	  8'hE6 : mul_by_2 = 8'hD7;
      8'hE7 : mul_by_2 = 8'hD5;
      8'hE8 : mul_by_2 = 8'hCB;
      8'hE9 : mul_by_2 = 8'hC9;
      8'hEA : mul_by_2 = 8'hCF;
      8'hEB : mul_by_2 = 8'hCD;
      8'hEC : mul_by_2 = 8'hC3;
      8'hED : mul_by_2 = 8'hC1;
      8'hEE : mul_by_2 = 8'hC7;
      8'hEF : mul_by_2 = 8'hC5;
      8'hF0 : mul_by_2 = 8'hFB;
      8'hF1 : mul_by_2 = 8'hF9;
      8'hF2 : mul_by_2 = 8'hFF;
      8'hF3 : mul_by_2 = 8'hFD;
      8'hF4 : mul_by_2 = 8'hF3;
      8'hF5 : mul_by_2 = 8'hF1;
      8'hF6 : mul_by_2 = 8'hF7;
      8'hF7 : mul_by_2 = 8'hF5;
      8'hF8 : mul_by_2 = 8'hEB;
      8'hF9 : mul_by_2 = 8'hE9;
      8'hFA : mul_by_2 = 8'hEF;
      8'hFB : mul_by_2 = 8'hED;
      8'hFC : mul_by_2 = 8'hE3;
      8'hFD : mul_by_2 = 8'hE1;
      8'hFE : mul_by_2 = 8'hE7;
      8'hFF : mul_by_2 = 8'hE5;	  
      default : mul_by_2 = 0;
    endcase
  endfunction

  function [7:0] mul_by_3;
    input [7:0] x;
 
    case (x)
      8'h00 : mul_by_3 = 8'h00;
      8'h01 : mul_by_3 = 8'h03;
      8'h02 : mul_by_3 = 8'h06;
      8'h03 : mul_by_3 = 8'h05;
      8'h04 : mul_by_3 = 8'h0C;
      8'h05 : mul_by_3 = 8'h0F;
      8'h06 : mul_by_3 = 8'h0A;
      8'h07 : mul_by_3 = 8'h09;
      8'h08 : mul_by_3 = 8'h18;
      8'h09 : mul_by_3 = 8'h1B;
      8'h0A : mul_by_3 = 8'h1E;
      8'h0B : mul_by_3 = 8'h1D;
      8'h0C : mul_by_3 = 8'h14;
      8'h0D : mul_by_3 = 8'h17;
      8'h0E : mul_by_3 = 8'h12;
      8'h0F : mul_by_3 = 8'h11;
      8'h10 : mul_by_3 = 8'h30;
      8'h11 : mul_by_3 = 8'h33;
      8'h12 : mul_by_3 = 8'h36;
      8'h13 : mul_by_3 = 8'h35;
      8'h14 : mul_by_3 = 8'h3C;
      8'h15 : mul_by_3 = 8'h3F;
      8'h16 : mul_by_3 = 8'h3A;
      8'h17 : mul_by_3 = 8'h39;
      8'h18 : mul_by_3 = 8'h28;
      8'h19 : mul_by_3 = 8'h2B;
      8'h1A : mul_by_3 = 8'h2E;
      8'h1B : mul_by_3 = 8'h2D;
      8'h1C : mul_by_3 = 8'h24;
      8'h1D : mul_by_3 = 8'h27;
      8'h1E : mul_by_3 = 8'h22;
      8'h1F : mul_by_3 = 8'h21;
      8'h20 : mul_by_3 = 8'h60;
      8'h21 : mul_by_3 = 8'h63;
      8'h22 : mul_by_3 = 8'h66;
      8'h23 : mul_by_3 = 8'h65;
      8'h24 : mul_by_3 = 8'h6C;
      8'h25 : mul_by_3 = 8'h6F;
      8'h26 : mul_by_3 = 8'hDA;
      8'h27 : mul_by_3 = 8'h69;
      8'h28 : mul_by_3 = 8'h78;
      8'h29 : mul_by_3 = 8'h7B;
      8'h2A : mul_by_3 = 8'h7E;
      8'h2B : mul_by_3 = 8'h7D;
      8'h2C : mul_by_3 = 8'h74;
      8'h2D : mul_by_3 = 8'h77;
      8'h2E : mul_by_3 = 8'h72;
   	  8'h2F : mul_by_3 = 8'h71;
      8'h30 : mul_by_3 = 8'h50;
      8'h31 : mul_by_3 = 8'h53;
      8'h32 : mul_by_3 = 8'h56;
      8'h33 : mul_by_3 = 8'h55;
      8'h34 : mul_by_3 = 8'h5C;
      8'h35 : mul_by_3 = 8'h5F;
      8'h36 : mul_by_3 = 8'h5A;
      8'h37 : mul_by_3 = 8'h59;
      8'h38 : mul_by_3 = 8'h48;
      8'h39 : mul_by_3 = 8'h4B;
      8'h3A : mul_by_3 = 8'h4E;
      8'h3B : mul_by_3 = 8'h4D;
      8'h3C : mul_by_3 = 8'h44;
      8'h3D : mul_by_3 = 8'h47;
      8'h3E : mul_by_3 = 8'h42;
      8'h3F : mul_by_3 = 8'h41;
      8'h40 : mul_by_3 = 8'hC0;
      8'h41 : mul_by_3 = 8'hC3;	  
      8'h42 : mul_by_3 = 8'hC6;
      8'h43 : mul_by_3 = 8'hC5;
      8'h44 : mul_by_3 = 8'hCC;
      8'h45 : mul_by_3 = 8'hCF;
      8'h46 : mul_by_3 = 8'hCA;
      8'h47 : mul_by_3 = 8'hC9;
      8'h48 : mul_by_3 = 8'hD8;
      8'h49 : mul_by_3 = 8'hDB;
      8'h4A : mul_by_3 = 8'hDE;
      8'h4B : mul_by_3 = 8'hDD;
      8'h4C : mul_by_3 = 8'hD4;
      8'h4D : mul_by_3 = 8'hD7;
      8'h4E : mul_by_3 = 8'hD2;
      8'h4F : mul_by_3 = 8'hD1;
      8'h50 : mul_by_3 = 8'hF0;
      8'h51 : mul_by_3 = 8'hF3;
      8'h52 : mul_by_3 = 8'hF6;
      8'h53 : mul_by_3 = 8'hF5;
      8'h54 : mul_by_3 = 8'hFC;
      8'h55 : mul_by_3 = 8'hFF;
      8'h56 : mul_by_3 = 8'hFA;
      8'h57 : mul_by_3 = 8'hF9;
      8'h58 : mul_by_3 = 8'hE8;
      8'h59 : mul_by_3 = 8'hEB;
      8'h5A : mul_by_3 = 8'hEE;
      8'h5B : mul_by_3 = 8'hED;
      8'h5C : mul_by_3 = 8'hE4;
      8'h5D : mul_by_3 = 8'hE7;
      8'h5E : mul_by_3 = 8'hE2;
      8'h5F : mul_by_3 = 8'hE1;
      8'h60 : mul_by_3 = 8'hA0;
      8'h61 : mul_by_3 = 8'hA3;
      8'h62 : mul_by_3 = 8'hA6;
      8'h63 : mul_by_3 = 8'hA5;
      8'h64 : mul_by_3 = 8'hAC;
      8'h65 : mul_by_3 = 8'hAF;
      8'h66 : mul_by_3 = 8'hAA;
      8'h67 : mul_by_3 = 8'hA9;
      8'h68 : mul_by_3 = 8'hB8;
      8'h69 : mul_by_3 = 8'hBB;
      8'h6A : mul_by_3 = 8'hBE;
      8'h6B : mul_by_3 = 8'hBD;
      8'h6C : mul_by_3 = 8'hB4;
      8'h6D : mul_by_3 = 8'hB7;
      8'h6E : mul_by_3 = 8'hB2;
      8'h6F : mul_by_3 = 8'hB1;
      8'h70 : mul_by_3 = 8'h90;
      8'h71 : mul_by_3 = 8'h93;
      8'h72 : mul_by_3 = 8'h96;
      8'h73 : mul_by_3 = 8'h95;
      8'h74 : mul_by_3 = 8'h9C;
      8'h75 : mul_by_3 = 8'h9F;
      8'h76 : mul_by_3 = 8'h9A;
      8'h77 : mul_by_3 = 8'h99;
      8'h78 : mul_by_3 = 8'h88;	  
      8'h79 : mul_by_3 = 8'h8B;
      8'h7A : mul_by_3 = 8'h8E;
      8'h7B : mul_by_3 = 8'h8D;
      8'h7C : mul_by_3 = 8'h84;
      8'h7D : mul_by_3 = 8'h87;
      8'h7E : mul_by_3 = 8'h82;
      8'h7F : mul_by_3 = 8'h81;
      8'h80 : mul_by_3 = 8'h9B;
      8'h81 : mul_by_3 = 8'h98;
      8'h82 : mul_by_3 = 8'h9D;
      8'h83 : mul_by_3 = 8'h9E;
      8'h84 : mul_by_3 = 8'h97;
      8'h85 : mul_by_3 = 8'h94;
      8'h86 : mul_by_3 = 8'h91;
      8'h87 : mul_by_3 = 8'h92;
      8'h88 : mul_by_3 = 8'h83;
      8'h89 : mul_by_3 = 8'h80;
      8'h8A : mul_by_3 = 8'h85;
      8'h8B : mul_by_3 = 8'h86;
      8'h8C : mul_by_3 = 8'h8F;
      8'h8D : mul_by_3 = 8'h8C;
      8'h8E : mul_by_3 = 8'h89;
      8'h8F : mul_by_3 = 8'h8A;
      8'h90 : mul_by_3 = 8'hAB;
      8'h91 : mul_by_3 = 8'hA8;
      8'h92 : mul_by_3 = 8'hAD;
      8'h93 : mul_by_3 = 8'hAE;
      8'h94 : mul_by_3 = 8'hA7;
      8'h95 : mul_by_3 = 8'hA4;
      8'h96 : mul_by_3 = 8'hA1;
      8'h97 : mul_by_3 = 8'hA2;
      8'h98 : mul_by_3 = 8'hB3;
      8'h99 : mul_by_3 = 8'hB0;
      8'h9A : mul_by_3 = 8'hB5;
      8'h9B : mul_by_3 = 8'hB6;
      8'h9C : mul_by_3 = 8'hBF;
      8'h9D : mul_by_3 = 8'hBC;
      8'h9E : mul_by_3 = 8'hB9;
      8'h9F : mul_by_3 = 8'hBA;
      8'hA0 : mul_by_3 = 8'hFB;
      8'hA1 : mul_by_3 = 8'hF8;
      8'hA2 : mul_by_3 = 8'hFD;
      8'hA3 : mul_by_3 = 8'hFE;
      8'hA4 : mul_by_3 = 8'hF7;
      8'hA5 : mul_by_3 = 8'hF4;
      8'hA6 : mul_by_3 = 8'hF1;
      8'hA7 : mul_by_3 = 8'hF2;
      8'hA8 : mul_by_3 = 8'hE3;
      8'hA9 : mul_by_3 = 8'hE0;
      8'hAA : mul_by_3 = 8'hE5;
      8'hAB : mul_by_3 = 8'hE6;
      8'hAC : mul_by_3 = 8'hEF;
      8'hAD : mul_by_3 = 8'hEC;
      8'hAE : mul_by_3 = 8'hE9;
      8'hAF : mul_by_3 = 8'hEA;
      8'hB0 : mul_by_3 = 8'hCB;
      8'hB1 : mul_by_3 = 8'hC8;
      8'hB2 : mul_by_3 = 8'hCD;
      8'hB3 : mul_by_3 = 8'hCE;
      8'hB4 : mul_by_3 = 8'hC7;	  
      8'hB5 : mul_by_3 = 8'hC4;
      8'hB6 : mul_by_3 = 8'hC1;
      8'hB7 : mul_by_3 = 8'hC2;
      8'hB8 : mul_by_3 = 8'hD3;
      8'hB9 : mul_by_3 = 8'hD0;
      8'hBA : mul_by_3 = 8'hD5;
      8'hBB : mul_by_3 = 8'hD6;
      8'hBC : mul_by_3 = 8'hDF;
      8'hBD : mul_by_3 = 8'hDC;
      8'hBE : mul_by_3 = 8'hD9;
      8'hBF : mul_by_3 = 8'hDA;
      8'hC0 : mul_by_3 = 8'h5B;
      8'hC1 : mul_by_3 = 8'h58;
      8'hC2 : mul_by_3 = 8'h5D;
      8'hC3 : mul_by_3 = 8'h5E;
      8'hC4 : mul_by_3 = 8'h57;
	  8'hC5 : mul_by_3 = 8'h54;
      8'hC6 : mul_by_3 = 8'h51;
      8'hC7 : mul_by_3 = 8'h52;
      8'hC8 : mul_by_3 = 8'h43;
      8'hC9 : mul_by_3 = 8'h40;
      8'hCA : mul_by_3 = 8'h45;
      8'hCB : mul_by_3 = 8'h46;
      8'hCC : mul_by_3 = 8'h4F;
	  8'hCD : mul_by_3 = 8'h4C;
      8'hCE : mul_by_3 = 8'h49;
      8'hCF : mul_by_3 = 8'h4A;
      8'hC0 : mul_by_3 = 8'h6B;
      8'hD1 : mul_by_3 = 8'h68;
      8'hD2 : mul_by_3 = 8'h6D;
      8'hD3 : mul_by_3 = 8'h6E;
      8'hD4 : mul_by_3 = 8'h67;
	  8'hD5 : mul_by_3 = 8'h64;
      8'hD6 : mul_by_3 = 8'h61;
      8'hD7 : mul_by_3 = 8'h62;
	  8'hD8 : mul_by_3 = 8'h73;
      8'hD9 : mul_by_3 = 8'h70;
      8'hDA : mul_by_3 = 8'h75;
	  8'hDB : mul_by_3 = 8'h76;
      8'hDC : mul_by_3 = 8'h7F;
	  8'hDD : mul_by_3 = 8'h7C;
      8'hDE : mul_by_3 = 8'h79;
      8'hDF : mul_by_3 = 8'h7A;	  
      8'hE0 : mul_by_3 = 8'h3B;
      8'hE1 : mul_by_3 = 8'h38;
      8'hE2 : mul_by_3 = 8'h3D;
      8'hE3 : mul_by_3 = 8'h3E;
      8'hE4 : mul_by_3 = 8'h37;
      8'hE5 : mul_by_3 = 8'h34;
	  8'hE6 : mul_by_3 = 8'h31;
      8'hE7 : mul_by_3 = 8'h32;
      8'hE8 : mul_by_3 = 8'h23;
      8'hE9 : mul_by_3 = 8'h20;
      8'hEA : mul_by_3 = 8'h25;
      8'hEB : mul_by_3 = 8'h26;
      8'hEC : mul_by_3 = 8'h2F;
      8'hED : mul_by_3 = 8'h2C;
      8'hEE : mul_by_3 = 8'h29;
      8'hEF : mul_by_3 = 8'h2A;
      8'hF0 : mul_by_3 = 8'h0B;
      8'hF1 : mul_by_3 = 8'h08;
      8'hF2 : mul_by_3 = 8'h0D;
      8'hF3 : mul_by_3 = 8'h0E;
      8'hF4 : mul_by_3 = 8'h07;
      8'hF5 : mul_by_3 = 8'h04;
      8'hF6 : mul_by_3 = 8'h01;
      8'hF7 : mul_by_3 = 8'h02;
      8'hF8 : mul_by_3 = 8'h13;
      8'hF9 : mul_by_3 = 8'h10;
      8'hFA : mul_by_3 = 8'h15;
      8'hFB : mul_by_3 = 8'h16;
      8'hFC : mul_by_3 = 8'h1F;
      8'hFD : mul_by_3 = 8'h1C;
      8'hFE : mul_by_3 = 8'h19;
      8'hFF : mul_by_3 = 8'h1A;	  
      default : mul_by_3 = 0;
    endcase
  endfunction
  
  
endmodule