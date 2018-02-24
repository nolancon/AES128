AES Encryptor IP
Modules for the encryptor IP which is integrated into a Microblaze design along with a UART in order to interface with the host PC.
Top Module - encryptor_top
Inputs 32bit x 8 -> 4 key and 4 plain text.
Outputs 32bit x 4 -> cipher text.
32 bit signals are arranged into 128 bit registers in the top module for processing in the IP design.
This is because Microblaze design only allows for max 32 bit registers.