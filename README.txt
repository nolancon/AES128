README for AES128
*****************
Repository containing C++ and Verilog to implement AES128 for final year project.

AES_C++ = C++ program to implement AES.

AES_Verilog = Verilog to implement AES:
-> AES_top
	-> expand_key
	-> key_scheduler
	-> encrypt_top
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
	-> decrypt_top
		-> decrypt_initial_round
			-> add_round_key
			-> inv_shift_rows
			-> inv_sub_bytes
		-> decrypt_round
			-> add_round_key	
			-> inv_mix_columns
			-> inv_shift_rows
			-> inv_sub_bytes
		-> add_round_key

AES_Verilog_Testbench = Some verilog testbench files created during process of writing working Verilog.
