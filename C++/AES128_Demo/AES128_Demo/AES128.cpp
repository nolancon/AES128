/*	Conor Nolan 6/03/2018
AES128 Functions
*/

#include "Tables.h"
#include "FunctionHeaders.h"
#include <stdio.h>
#include <iostream>

unsigned char expandedKey[176];

void ConvertToHex(unsigned char x)
{
	if (x / 16 < 10) std::cout << (char)((x / 16) + '0');
	if (x / 16 >= 10) std::cout << (char)((x / 16 - 10) + 'A');

	if (x % 16 < 10) std::cout << (char)((x % 16) + '0');
	if (x % 16 >= 10) std::cout << (char)((x % 16 - 10) + 'A');

}

void PrintPlainText(unsigned char* output, int length)
{
	for (int i = 0; i < length; i++)
	{
		std::cout << (output[i]);
	}
}

void PrintHex(unsigned char* output, int length)
{
	for (int i = 0; i < length; i++)
	{
		ConvertToHex(output[i]);
		std::cout << " ";
	}
}

void run_AES()
{
	unsigned char message[] = "Conor Nolan GMIT";		//String to encrypt

	unsigned char key[16] = {				//Key to be expanded 
		1, 2, 3, 4,
		5, 6, 7, 8,
		9, 10, 11, 12,
		13, 14, 15, 16,
	};

	//(Padding Removed in this version) Message is encrypted in blocks of 16. Therefore if a block is less than 16, it must be 'padded' with 0s up to 16 bytes in size
	int messageLength = strlen((const char*)message);	//Get length of message and store in messageLength


	std::cout << "Plain Text : " << std::endl;				//print message in plain text (before padding)
	PrintPlainText(message, messageLength);

	std::cout << "\n\nPlain Text (Hex): " << std::endl;		//print message in hex (before padding)
	PrintHex(message, messageLength);

	std::cout << "\n\nKey" << std::endl;						//print key in hex
	PrintHex(key, 16);


	//Expand the Key
	KeyExpansion(key, expandedKey);


	//Encrypt Message:
	for (int i = 0; i < messageLength; i += 16)
		AES_Encrypt(message + i, key);


	std::cout << "\n\nCypher Text: \n";
	PrintPlainText(message, messageLength);

	std::cout << "\n\nCypher Text (Hex): " << std::endl;
	PrintHex(message, messageLength);

	KeyExpansion(key, expandedKey);
	for (int i = 0; i < messageLength; i += 16)
		AES_Decrypt(message + i, key);

	std::cout << "\n\nDecrypted Plain Text : " << std::endl;
	PrintPlainText(message, messageLength);

	std::cout << "\n\nDecrypted Plain Text (Hex): " << std::endl;
	PrintHex(message, messageLength);


	std::cin.ignore();
}



void AES_Encrypt(unsigned char* message, unsigned char* key)
{
	unsigned char state[16];
	for (int i = 0; i< 16; i++)
	{
		state[i] = message[i];		//Copy message (Plain Text to be encrypted) into state string
	}

	int numberOfRounds = 9;			//Declare number of rounds in Encryption process (9 + Final round = 10) - Initial round is just XOR ing with initial key

	AddRoundKey(state, key);		//Pass state and key to AddRoundKey function

									//Rounds
	for (int i = 0; i< numberOfRounds; i++)
	{
		std::cout << "\n\nRound " << i + 1 << std::endl;	//Display Round number
		SubBytes(state);			//Pass state to SubBytes
		ShiftRows(state);			//Pass state to ShiftRows
		MixColumns(state);			//Pass state to MixColumns
		AddRoundKey(state, expandedKey + (16 * (i + 1)));		//Pass state to AddRoundKey, also pass expanded Key 															
	}															//(increment in 16 bytes at a time (176 byte expandedKey => initial round + 9 + final round = 11x16 = 176)


																//Final Round
	std::cout << "\n\nFinal Round " << std::endl;
	SubBytes(state);				//Pass state to SubBytes
	ShiftRows(state);				//Pass state to ShiftRows
	AddRoundKey(state, expandedKey + 160); //Pass state to AddRoundKey, also pass last 16 bytes of 176 expandedKey

										   //Copy over message with encrypted message
	for (int i = 0; i< 16; i++)
	{
		message[i] = state[i];
	}
}


void AES_Decrypt(unsigned char* message, unsigned char* key)
{
	unsigned char state[16];
	int numberOfRounds = 9;			//Declare number of rounds in Decryption process (Initial Round + 9 = 10) => Final round is just XORing with initital key (which also = first 16 bytes of expandedKey)
	for (int i = 0; i< 16; i++)
	{
		state[i] = message[i];		//Copy message (message is now the cyphertext since encryption and it is to be decrypted) to state for it to be passed through functions
	}

	//Initial Round
	std::cout << "\n\nInitial Round " << std::endl;

	AddRoundKey(state, expandedKey + 160);		//Pass state and last 16 bytes of expandedKey to AddRoundKey (Last 16 bytes because we are now decrypting ie working backwards)
	InvShiftRows(state);						//Pass state to InvShiftRows
	InvSubBytes(state);							//Pass state to InvSubBytes 

												//Rounds
	for (int i = 0; i< numberOfRounds; i++)
	{
		std::cout << "\n\nRound " << i + 2 << std::endl;		//Display Round number

		AddRoundKey(state, expandedKey + (160 - ((i + 1) * 16)));		//Pass state to AddRoundKey, also pass expanded Key 															
																		//This time decrementing in 16 bytes per round starting at 160 (161-176 used in Initial Round 		
		InvMixColumns(state);						//Pass state to InvMixColumns
		InvShiftRows(state);						//Pass state to InvShiftRows
		InvSubBytes(state);							//Pass state to InvSubBytes
	}

	//Final Round

	AddRoundKey(state, key);						//Pass state to addRoundKey, also pass key (key = expandedKeys[0-15]) Same as initial AddRoundKey in Encryption!

													//Copy over message with decrypted message (Restoring it to original form)
	for (int i = 0; i< 16; i++)
	{
		message[i] = state[i];
	}
}


void KeyExpansionCore(unsigned char* in, unsigned char i)
{
	//rotate left
	//| 0 | 1 | 2 | 3 | => | 1 | 2 | 3 | 0 |
	unsigned char t = in[0];
	in[0] = in[1];
	in[1] = in[2];
	in[2] = in[3];
	in[3] = t;

	//S-Box Four Bytes
	//Substitue each byte for corresponding S-Box value
	in[0] = s_box[in[0]];
	in[1] = s_box[in[1]];
	in[2] = s_box[in[2]];
	in[3] = s_box[in[3]];

	//RCon
	//First byte is XORd with corresponding RCon value ( i = rconCounter which is incremented for each key expansion core call ie every 16 bytes of expanded key)
	in[0] ^= rcon[i];

}



void KeyExpansion(unsigned char* inputKey, unsigned char* expandedKeys)
{
	for (int i = 0; i < 16; i++)
		expandedKeys[i] = inputKey[i];

	//Variables
	int bytesGenerated = 16; //16 bytes generated already
	int rconCounter = 1; //RCon iteration begins at 1
	unsigned char temp[4]; //Temp storage for core

	while (bytesGenerated < 176)	//Loop through expanded key
	{
		// read 4 bytes for the core
		for (int i = 0; i < 4; i++)
			temp[i] = expandedKeys[i + bytesGenerated - 4]; //temp takes last 4 bytes of each 16 bytes (each round key) of expandedKeys

															// Perform the core once for each 16 byte round key
		if (bytesGenerated % 16 == 0)
		{
			KeyExpansionCore(temp, rconCounter);  //send temp to KeyExpansionCore()
			rconCounter++;
		}

		//XOR temp with [bytesGenerated-16], and store in expandedKeys:
		for (unsigned char a = 0; a < 4; a++)
		{
			expandedKeys[bytesGenerated] = expandedKeys[bytesGenerated - 16] ^ temp[a];
			bytesGenerated++;
		}
	}
	std::cout << "\n\nExpanded Key" << std::endl;
	for (int i = 0; i < 176; i++)
	{
		ConvertToHex(expandedKeys[i]);
		std::cout << " ";
	}

}



void AddRoundKey(unsigned char* state, unsigned char* roundKey)
{
	for (int i = 0; i< 16; i++)
	{
		state[i] ^= roundKey[i];	//XOR each byte in state with round key
	}
	std::cout << "\nAddRoundKey" << std::endl;
	for (int i = 0; i < 16; i++)
	{
		ConvertToHex(state[i]);		//Print state in Hex
		std::cout << " ";
	}
}

void SubBytes(unsigned char* state)		//SubsBytes - Substitute bytes in state with bytes in s_box (encryption)
{
	for (int i = 0; i < 16; i++)
	{
		state[i] = s_box[state[i]];			//perform sub
	}
	std::cout << "\nSubBytes" << std::endl;
	for (int i = 0; i < 16; i++)
	{
		ConvertToHex(state[i]);					//Print state in Hex
		std::cout << " ";
	}
}

void InvSubBytes(unsigned char* state)		//InvSubsBytes - Substitute bytes in state with bytes in inv_s_box (decryption - undo subBytes)
{
	for (int i = 0; i < 16; i++)
	{
		state[i] = inv_s_box[state[i]];		//perform sub
	}
	std::cout << "\nInverted SubBytes" << std::endl;
	for (int i = 0; i < 16; i++)
	{
		ConvertToHex(state[i]);					//Print state in Hex
		std::cout << " ";
	}

}


void ShiftRows(unsigned char* state)
{
	/* Shift Rows left (encryption)

	|  0 |  4 |  8 | 12 |	=>	|  0 |  4 |  8 | 12 |	-No movement
	|  1 |  5 |  9 | 13 |   =>	|  5 |  9 | 13 |  1 | 	-Shift 1 spaces left
	|  2 |  6 | 10 | 14 |	=>	| 10 | 14 |  2 |  6 |	-Shift 2 spaces left
	|  3 |  7 | 11 | 15 |   =>	| 15 |  3 |  7 | 11 |   -Shift 3 spaces left

	*/
	unsigned char tmp[16];
	tmp[0] = state[0];
	tmp[1] = state[5];
	tmp[2] = state[10];
	tmp[3] = state[15];

	tmp[4] = state[4];
	tmp[5] = state[9];
	tmp[6] = state[14];
	tmp[7] = state[3];

	tmp[8] = state[8];
	tmp[9] = state[13];
	tmp[10] = state[2];
	tmp[11] = state[7];

	tmp[12] = state[12];
	tmp[13] = state[1];
	tmp[14] = state[6];
	tmp[15] = state[11];

	for (int i = 0; i< 16; i++)
	{
		state[i] = tmp[i];			//copy tmp back into state
	}

	std::cout << "\nShiftRows" << std::endl;
	for (int i = 0; i < 16; i++)
	{
		ConvertToHex(state[i]);		//Print state in Hex
		std::cout << " ";
	}

}


void InvShiftRows(unsigned char* state)
{
	/* undo shift rows left (decryption)

	|  0 |  4 |  8 | 12 |	=>	|  0 |  4 |  8 | 12 |
	|  5 |  8 | 13 |  1 |   =>	|  1 |  5 |  9 | 13 |
	| 10 | 14 |  2 |  6 |	=>	|  2 |  6 | 10 | 14 |
	| 15 |  3 |  7 | 11 |   =>	|  3 |  7 | 11 | 15 |

	*/
	unsigned char tmp[16];
	tmp[0] = state[0];
	tmp[1] = state[13];
	tmp[2] = state[10];
	tmp[3] = state[7];

	tmp[4] = state[4];
	tmp[5] = state[1];
	tmp[6] = state[14];
	tmp[7] = state[11];

	tmp[8] = state[8];
	tmp[9] = state[5];
	tmp[10] = state[2];
	tmp[11] = state[15];

	tmp[12] = state[12];
	tmp[13] = state[9];
	tmp[14] = state[6];
	tmp[15] = state[3];

	for (int i = 0; i< 16; i++) //copy tmp back into state
	{
		state[i] = tmp[i];
	}

	std::cout << "\nInverted ShiftRows" << std::endl;
	for (int i = 0; i < 16; i++)
	{
		ConvertToHex(state[i]);		//Print state in Hex
		std::cout << " ";
	}

}


void MixColumns(unsigned char* state)
{
	/*
	16 bytes of plain text is multiplied byte special matrix. Look-up tables mul2 and mul3 are implemented for speed and convenience

	Plain Text:					Special Matrix:				Products XORd together:		res = Result of calculation.
	(1st 4 bytes with top row)	The same is done for all rows/cols

	|  P |  n |  x |  l |	.	|  2 |  3 |  1 |  1 |	=>	(P*2)+(l*3)+(a*1)+(i*1) =>  |res|   |   |   |
	|  l |    |  t |  o |   	|  1 |  2 |  3 |  1 |									|   |   |   |   |
	|  a |  T |    |  c |		|  1 |  1 |  2 |  3 |									|   |   |   |   |
	|  i |  e |  B |  k |   	|  3 |  1 |  1 |  2 |									|   |   |   |   |
	*/
	unsigned char tmp[16];

	tmp[0] = (unsigned char)(mul2[state[0]] ^ mul3[state[1]] ^ state[2] ^ state[3]);	//This line is represented in above explanation
	tmp[1] = (unsigned char)(state[0] ^ mul2[state[1]] ^ mul3[state[2]] ^ state[3]);
	tmp[2] = (unsigned char)(state[0] ^ state[1] ^ mul2[state[2]] ^ mul3[state[3]]);
	tmp[3] = (unsigned char)(mul3[state[0]] ^ state[1] ^ state[2] ^ mul2[state[3]]);

	tmp[4] = (unsigned char)(mul2[state[4]] ^ mul3[state[5]] ^ state[6] ^ state[7]);
	tmp[5] = (unsigned char)(state[4] ^ mul2[state[5]] ^ mul3[state[6]] ^ state[7]);
	tmp[6] = (unsigned char)(state[4] ^ state[5] ^ mul2[state[6]] ^ mul3[state[7]]);
	tmp[7] = (unsigned char)(mul3[state[4]] ^ state[5] ^ state[6] ^ mul2[state[7]]);

	tmp[8] = (unsigned char)(mul2[state[8]] ^ mul3[state[9]] ^ state[10] ^ state[11]);
	tmp[9] = (unsigned char)(state[8] ^ mul2[state[9]] ^ mul3[state[10]] ^ state[11]);
	tmp[10] = (unsigned char)(state[8] ^ state[9] ^ mul2[state[10]] ^ mul3[state[11]]);
	tmp[11] = (unsigned char)(mul3[state[8]] ^ state[9] ^ state[10] ^ mul2[state[11]]);

	tmp[12] = (unsigned char)(mul2[state[12]] ^ mul3[state[13]] ^ state[14] ^ state[15]);
	tmp[13] = (unsigned char)(state[12] ^ mul2[state[13]] ^ mul3[state[14]] ^ state[15]);
	tmp[14] = (unsigned char)(state[12] ^ state[13] ^ mul2[state[14]] ^ mul3[state[15]]);
	tmp[15] = (unsigned char)(mul3[state[12]] ^ state[13] ^ state[14] ^ mul2[state[15]]);

	for (int i = 0; i< 16; i++) //copy tmp back into state
	{
		state[i] = tmp[i];
	}
	std::cout << "\nMixColumns" << std::endl;
	for (int i = 0; i < 16; i++)
	{
		ConvertToHex(state[i]);
		std::cout << " ";
	}
}

void InvMixColumns(unsigned char* state)
{
	/*
	16 bytes of cypher text is multiplied by special matrix. Look-up tables mul9, mul11, mul13 and mul4 are implemented for speed and convenience

	Plain Text:					Special Matrix:				Products XORd together:		res = Result of calculation.
	(1st 4 bytes with top row)	The same is done for all rows/cols

	|  C |  e |  e |  B |	.	| 14 | 11 | 13 |  9 |	=>	(C*14)+(y*11)+(p*13)+(h*9)  =>	|res|   |   |   |
	|  y |  r |  x |  l |   	|  9 | 14 | 11 | 13 |										|   |   |   |   |
	|  p |    |  t |  o |		| 13 |  9 | 14 | 11 |										|   |   |   |   |
	|  h |  T |    |  c |   	| 11 | 13 |  9 | 24 |										|   |   |   |   |
	*/
	unsigned char temp[16];

	temp[0] = (unsigned char)(mul14[state[0]] ^ mul11[state[1]] ^ mul13[state[2]] ^ mul9[state[3]]);
	temp[1] = (unsigned char)(mul9[state[0]] ^ mul14[state[1]] ^ mul11[state[2]] ^ mul13[state[3]]);
	temp[2] = (unsigned char)(mul13[state[0]] ^ mul9[state[1]] ^ mul14[state[2]] ^ mul11[state[3]]);
	temp[3] = (unsigned char)(mul11[state[0]] ^ mul13[state[1]] ^ mul9[state[2]] ^ mul14[state[3]]);

	temp[4] = (unsigned char)(mul14[state[4]] ^ mul11[state[5]] ^ mul13[state[6]] ^ mul9[state[7]]);
	temp[5] = (unsigned char)(mul9[state[4]] ^ mul14[state[5]] ^ mul11[state[6]] ^ mul13[state[7]]);
	temp[6] = (unsigned char)(mul13[state[4]] ^ mul9[state[5]] ^ mul14[state[6]] ^ mul11[state[7]]);
	temp[7] = (unsigned char)(mul11[state[4]] ^ mul13[state[5]] ^ mul9[state[6]] ^ mul14[state[7]]);

	temp[8] = (unsigned char)(mul14[state[8]] ^ mul11[state[9]] ^ mul13[state[10]] ^ mul9[state[11]]);
	temp[9] = (unsigned char)(mul9[state[8]] ^ mul14[state[9]] ^ mul11[state[10]] ^ mul13[state[11]]);
	temp[10] = (unsigned char)(mul13[state[8]] ^ mul9[state[9]] ^ mul14[state[10]] ^ mul11[state[11]]);
	temp[11] = (unsigned char)(mul11[state[8]] ^ mul13[state[9]] ^ mul9[state[10]] ^ mul14[state[11]]);

	temp[12] = (unsigned char)(mul14[state[12]] ^ mul11[state[13]] ^ mul13[state[14]] ^ mul9[state[15]]);
	temp[13] = (unsigned char)(mul9[state[12]] ^ mul14[state[13]] ^ mul11[state[14]] ^ mul13[state[15]]);
	temp[14] = (unsigned char)(mul13[state[12]] ^ mul9[state[13]] ^ mul14[state[14]] ^ mul11[state[15]]);
	temp[15] = (unsigned char)(mul11[state[12]] ^ mul13[state[13]] ^ mul9[state[14]] ^ mul14[state[15]]);


	for (int i = 0; i< 16; i++) //copy tmp back into state
	{
		state[i] = temp[i];
	}
	std::cout << "\nMixColumns" << std::endl;
	for (int i = 0; i < 16; i++)
	{
		ConvertToHex(state[i]);		//Print state in Hex
		std::cout << " ";
	}
}