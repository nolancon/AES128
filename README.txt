README for AES128
*****************
Repository containing C++ and Verilog to implement AES128 for final year project.

C++ = C++ program to implement AES.

C_Microblaze_Tests = C code to test crypto modes through UART to Microblaze processor.

RTL_TB = Some verilog testbench files created during process of writing working Verilog.

RTL = Verilog to implement AES128-ECB & AES128-CBC:

	AES128-CBC Hierarchy:
	Encryption:
	-> aes128_cbc_encrypt_top
		-> expand_key
		-> key_scheduler
		-> encrypt_top
			-> add_vector
			-> add_round_key	
			-> encrypt_round
				-> sub_bytes
				-> shift_rows
				-> mix_columns
				-> add_round_key
			-> encrypt_final_round
				-> sub_bytes
				-> shift_rows
				-> add_round_key
	Decryption:
	-> aes128_cbc_decrypt_top
		-> expand_key
		-> key_scheduler
		-> decrypt_top
			-> decrypt_initial_round
				-> add_round_key
				-> inv_shift_rows
				-> inv_sub_bytes
			-> decrypt_round
				-> add_round_key	
				-> inv_mix_columns
					-> mul_9
					-> mul_11
					-> mul_12
					-> mul_13
				-> inv_shift_rows
				-> inv_sub_bytes
			-> add_round_key
			-> add_vector

