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

u8 *baseaddr_p = (u8 *)XPAR_ENCRYPTOR_0_S00_AXI_BASEADDR;

//const char *y = (const char*)baseaddr_p;

int main()
{
	init_platform();

	xil_printf("AES128 Encryption Demo\n\r");

	//Key
	*(baseaddr_p+0) = 0x01;
	*(baseaddr_p+1) = 0x02;
	*(baseaddr_p+2) = 0x03;
	*(baseaddr_p+3) = 0x04;
	*(baseaddr_p+4) = 0x05;
	*(baseaddr_p+5) = 0x06;
	*(baseaddr_p+6) = 0x07;
	*(baseaddr_p+7) = 0x08;
	*(baseaddr_p+8) = 0x09;
	*(baseaddr_p+9) = 0x0A;
	*(baseaddr_p+10) = 0x0B;
	*(baseaddr_p+11) = 0x0C;
	*(baseaddr_p+12) = 0x0D;
	*(baseaddr_p+13) = 0x0E;
	*(baseaddr_p+14) = 0x0F;
	*(baseaddr_p+15) = 0x10;

	/*********************************************************************************************************/

	setvbuf(stdin, NULL, _IONBF, 0);
	int count = 0;
	for (;;)
	{
		for(int i = 16; i < 32; i++)
		{
			*(baseaddr_p+i) = getchar();	//assign getchar() value to plain text address space
			count ++;
			if (*(baseaddr_p+i) != EOF)
			{
				xil_printf("%c", *(baseaddr_p+i));	//print getchar() value
			}
			if(count % 16 == 0)						//after every 16 bytes entered, display encryption results
			{
				xil_printf("\n\r");
				xil_printf("Plain Text (ascii): ");
				for(int i = 16; i < 32; i++)
				{
					xil_printf("%c",*(baseaddr_p+i));
				}
				xil_printf("\n\r");

				xil_printf("Plain Text (hex): ");
				for(int i = 16; i < 32; i++)
				{
					xil_printf("%02x ",*(baseaddr_p+i));
				}
				xil_printf("\n\r");

				xil_printf("Cipher Text (ascii): ");
				for(int i = 32; i < 48; i++)
				{
					xil_printf("%c",*(baseaddr_p+i));
				}
				xil_printf("\n\r");

				xil_printf("Cipher Text (hex): ");
				for(int i = 32; i < 48; i++)
				{
					xil_printf("%02x ",*(baseaddr_p+i));
				}
				xil_printf("\n\r");

				xil_printf("End of test\n\n\r");
			}
		}
	}
	/*********************************************************************************************************/



	return 0;
}
