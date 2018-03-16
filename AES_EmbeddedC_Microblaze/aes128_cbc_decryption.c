/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_types.h"
#include "xparameters.h"

void updateBlockChain();


u8 *baseaddr_p = (u8 *)XPAR_AES128_CBC_DECRYPTOR_IP_0_S00_AXI_BASEADDR;


//const char *y = (const char*)baseaddr_p;

int main()
{
	init_platform();


	//Initialisation Vector
	*(baseaddr_p+0) = 0x10;
	*(baseaddr_p+1) = 0x0F;
	*(baseaddr_p+2) = 0x0E;
	*(baseaddr_p+3) = 0x0D;
	*(baseaddr_p+4) = 0x0C;
	*(baseaddr_p+5) = 0x0B;
	*(baseaddr_p+6) = 0x0A;
	*(baseaddr_p+7) = 0x09;
	*(baseaddr_p+8) = 0x08;
	*(baseaddr_p+9) = 0x07;
	*(baseaddr_p+10) = 0x06;
	*(baseaddr_p+11) = 0x05;
	*(baseaddr_p+12) = 0x04;
	*(baseaddr_p+13) = 0x03;
	*(baseaddr_p+14) = 0x02;
	*(baseaddr_p+15) = 0x01;

	//Key
	*(baseaddr_p+16) = 0x01;
	*(baseaddr_p+17) = 0x02;
	*(baseaddr_p+18) = 0x03;
	*(baseaddr_p+19) = 0x04;
	*(baseaddr_p+20) = 0x05;
	*(baseaddr_p+21) = 0x06;
	*(baseaddr_p+22) = 0x07;
	*(baseaddr_p+23) = 0x08;
	*(baseaddr_p+24) = 0x09;
	*(baseaddr_p+25) = 0x0A;
	*(baseaddr_p+26) = 0x0B;
	*(baseaddr_p+27) = 0x0C;
	*(baseaddr_p+28) = 0x0D;
	*(baseaddr_p+29) = 0x0E;
	*(baseaddr_p+30) = 0x0F;
	*(baseaddr_p+31) = 0x10;

/*******************************************************************************************/
	xil_printf("\n\rAES128-CBC Decryption Demo\n\r");

	setvbuf(stdin, NULL, _IONBF, 0);
	int block = 1;
	for (;;)
	{
		xil_printf("\n\rBlock Cipher %i", block);
		block++;
		xil_printf("\n\rInitialisation Vector (hex):  ");
		for(int i = 0; i < 16; i++)
		{
			xil_printf("%02x ",*(baseaddr_p+i));
		}
		xil_printf("\n\r");

		xil_printf("Key (hex):                    ");
		for(int i = 16; i < 32; i++)
		{
			xil_printf("%02x ",*(baseaddr_p+i));
		}
		xil_printf("\n\r");

		xil_printf("Enter Cipher Text (hex):     \n\r");	//print getchar() value

		for(int i = 32; i < 48; i++)
		{
			scanf("%hhx",&(*(baseaddr_p+i)));
		}

		xil_printf("Cipher Text (ascii):          ");
		for(int i = 32; i < 48; i++)
		{
			xil_printf("%c",*(baseaddr_p+i));
		}
		xil_printf("\n\r");

		xil_printf("Cipher Text (hex):            ");
		for(int i = 32; i < 48; i++)
		{
			xil_printf("%02x ",*(baseaddr_p+i));
		}
		xil_printf("\n\r");

		xil_printf("Decrypted Plain Text (ascii): ");
		for(int i = 48; i < 64; i++)
		{
			xil_printf("%c",*(baseaddr_p+i));
		}
		xil_printf("\n\r");

		xil_printf("Decrypted Plain (hex):        ");
		for(int i = 48; i < 64; i++)
		{
			xil_printf("%02x ",*(baseaddr_p+i));
		}
		xil_printf("\n\r");

		xil_printf("End of test\n\n\r");
		updateBlockChain();
	}

	return 0;
}


void updateBlockChain()
{
	u8 vec1,vec2,vec3, vec4,vec5,vec6,vec7,vec8, vec9,vec10,vec11,vec12,vec13,vec14, vec15,vec16;

	vec1 = *(baseaddr_p+32);
	vec2 = *(baseaddr_p+33);
	vec3 = *(baseaddr_p+34);
	vec4 = *(baseaddr_p+35);
	vec5 = *(baseaddr_p+36);
	vec6 = *(baseaddr_p+37);
	vec7 = *(baseaddr_p+38);
	vec8 = *(baseaddr_p+39);
	vec9 = *(baseaddr_p+40);
	vec10 = *(baseaddr_p+41);
	vec11 = *(baseaddr_p+42);
	vec12 = *(baseaddr_p+43);
	vec13 = *(baseaddr_p+44);
	vec14 = *(baseaddr_p+45);
	vec15 = *(baseaddr_p+46);
	vec16 = *(baseaddr_p+47);

	*(baseaddr_p) = vec1;
	*(baseaddr_p+1) = vec2;
	*(baseaddr_p+2) = vec3;
	*(baseaddr_p+3) = vec4;
	*(baseaddr_p+4) = vec5;
	*(baseaddr_p+5) = vec6;
	*(baseaddr_p+6) = vec7;
	*(baseaddr_p+7) = vec8;
	*(baseaddr_p+8) = vec9;
	*(baseaddr_p+9) = vec10;
	*(baseaddr_p+10) = vec11;
	*(baseaddr_p+11) = vec12;
	*(baseaddr_p+12) = vec13;
	*(baseaddr_p+13) = vec14;
	*(baseaddr_p+14) = vec15;
	*(baseaddr_p+15) = vec16;
}
