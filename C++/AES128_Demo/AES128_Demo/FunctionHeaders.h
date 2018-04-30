/*	Conor Nolan 6/03/2018
Function Headers
*/

void AES_Encrypt(unsigned char* message, unsigned char* key);
void AES_Decrypt(unsigned char* message, unsigned char* key);
void ConvertToHex(unsigned char x);
void PrintPlainText(unsigned char* output, int length);
void PrintHex(unsigned char* output, int length);

void run_AES();
void KeyExpansion(unsigned char* inputKey, unsigned char* expandedKeys);
void KeyExpansionCore(unsigned char* in, unsigned char i);

void SubBytes(unsigned char* state);
void ShiftRows(unsigned char* state);
void MixColumns(unsigned char* state);
void AddRoundKey(unsigned char* state, unsigned char* roundKey);

void InvSubBytes(unsigned char* state);
void InvShiftRows(unsigned char* state);
void InvMixColumns(unsigned char* state);
