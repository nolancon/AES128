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
#include "xbasic_types.h"
#include "xparameters.h"

u32 *baseaddr_p = (u32 *)XPAR_ENCRYPTOR_0_S00_AXI_BASEADDR;

int main()
{
	init_platform();

	xil_printf("Encryption Test\n\r");

	// Write key inputs to registers 0 - 3
	*(baseaddr_p+0) = 0x04030201;
	*(baseaddr_p+1) = 0x08070605;
	*(baseaddr_p+2) = 0x0C0B0A09;
	*(baseaddr_p+3) = 0x100F0E0D;

	xil_printf("Key:\t\t0x%08x%08x%08x%08x \n\r", *(baseaddr_p+3),*(baseaddr_p+2),*(baseaddr_p+1),*(baseaddr_p+0));

	// Write plain text inputs to register 4 - 7
	//Test Plain Text: "Conor Nolan GMIT" -> 0x54494D47206E616C6F4E20726F6E6F43

	*(baseaddr_p+4) = 0x6F6E6F43;
	*(baseaddr_p+5) = 0x6F4E2072;
	*(baseaddr_p+6) = 0x206E616C;
	*(baseaddr_p+7) = 0x54494D47;

 	xil_printf("Plain Text:\t0x%08x%08x%08x%08x \n\r", *(baseaddr_p+7),*(baseaddr_p+6),*(baseaddr_p+5),*(baseaddr_p+4));

	// Read cipher text output from register 8 - 11
	xil_printf("Cipher Text:\t0x%08x%08x%08x%08x \n\r", *(baseaddr_p+11),*(baseaddr_p+10),*(baseaddr_p+9),*(baseaddr_p+8));


	xil_printf("End of test\n\n\r");

	return 0;
}
