/* system.h
 *
 * Machine generated for a CPU named "CORE" as defined in:
 * d:\2025_2\2025_2_NioII_SoC_Lab\Lab2\software\hello_world_0_syslib\..\..\Nios2.ptf
 *
 * Generated: 2026-03-12 16:47:22.026
 *
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/*

DO NOT MODIFY THIS FILE

   Changing this file will have subtle consequences
   which will almost certainly lead to a nonfunctioning
   system. If you do modify this file, be aware that your
   changes will be overwritten and lost when this file
   is generated again.

DO NOT MODIFY THIS FILE

*/

/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2003 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
*                                                                             *
******************************************************************************/

/*
 * system configuration
 *
 */

#define ALT_SYSTEM_NAME "Nios2"
#define ALT_CPU_NAME "CORE"
#define ALT_CPU_ARCHITECTURE "altera_nios2"
#define ALT_DEVICE_FAMILY "CYCLONEIII"
#define ALT_STDIN "/dev/JTAG_DEBUG"
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN_BASE 0x00021010
#define ALT_STDIN_DEV JTAG_DEBUG
#define ALT_STDIN_PRESENT
#define ALT_STDOUT "/dev/JTAG_DEBUG"
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT_BASE 0x00021010
#define ALT_STDOUT_DEV JTAG_DEBUG
#define ALT_STDOUT_PRESENT
#define ALT_STDERR "/dev/JTAG_DEBUG"
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDERR_BASE 0x00021010
#define ALT_STDERR_DEV JTAG_DEBUG
#define ALT_STDERR_PRESENT
#define ALT_CPU_FREQ 50000000
#define ALT_IRQ_BASE NULL
#define ALT_LEGACY_INTERRUPT_API_PRESENT

/*
 * processor configuration
 *
 */

#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_BIG_ENDIAN 0
#define NIOS2_INTERRUPT_CONTROLLER_ID 0

#define NIOS2_ICACHE_SIZE 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_FLUSHDA_SUPPORTED

#define NIOS2_EXCEPTION_ADDR 0x00010020
#define NIOS2_RESET_ADDR 0x00010000
#define NIOS2_BREAK_ADDR 0x00020820

#define NIOS2_HAS_DEBUG_STUB

#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0

/*
 * A define for each class of peripheral
 *
 */

#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_PIO

/*
 * RAM configuration
 *
 */

#define RAM_NAME "/dev/RAM"
#define RAM_TYPE "altera_avalon_onchip_memory2"
#define RAM_BASE 0x00010000
#define RAM_SPAN 40960
#define RAM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define RAM_RAM_BLOCK_TYPE "AUTO"
#define RAM_INIT_CONTENTS_FILE "RAM"
#define RAM_NON_DEFAULT_INIT_FILE_ENABLED 0
#define RAM_GUI_RAM_BLOCK_TYPE "Automatic"
#define RAM_WRITEABLE 1
#define RAM_DUAL_PORT 0
#define RAM_SIZE_VALUE 40960
#define RAM_SIZE_MULTIPLE 1
#define RAM_USE_SHALLOW_MEM_BLOCKS 0
#define RAM_INIT_MEM_CONTENT 1
#define RAM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define RAM_INSTANCE_ID "NONE"
#define RAM_READ_DURING_WRITE_MODE "DONT_CARE"
#define RAM_IGNORE_AUTO_BLOCK_TYPE_ASSIGNMENT 1
#define RAM_CONTENTS_INFO "QUARTUS_PROJECT_DIR/RAM.hex 1773304104"
#define ALT_MODULE_CLASS_RAM altera_avalon_onchip_memory2

/*
 * JTAG_DEBUG configuration
 *
 */

#define JTAG_DEBUG_NAME "/dev/JTAG_DEBUG"
#define JTAG_DEBUG_TYPE "altera_avalon_jtag_uart"
#define JTAG_DEBUG_BASE 0x00021010
#define JTAG_DEBUG_SPAN 8
#define JTAG_DEBUG_IRQ 0
#define JTAG_DEBUG_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_DEBUG_WRITE_DEPTH 64
#define JTAG_DEBUG_READ_DEPTH 64
#define JTAG_DEBUG_WRITE_THRESHOLD 8
#define JTAG_DEBUG_READ_THRESHOLD 8
#define JTAG_DEBUG_READ_CHAR_STREAM ""
#define JTAG_DEBUG_SHOWASCII 1
#define JTAG_DEBUG_RELATIVEPATH 0
#define JTAG_DEBUG_READ_LE 0
#define JTAG_DEBUG_WRITE_LE 0
#define JTAG_DEBUG_ALTERA_SHOW_UNRELEASED_JTAG_UART_FEATURES 0
#define ALT_MODULE_CLASS_JTAG_DEBUG altera_avalon_jtag_uart

/*
 * PIO_LED configuration
 *
 */

#define PIO_LED_NAME "/dev/PIO_LED"
#define PIO_LED_TYPE "altera_avalon_pio"
#define PIO_LED_BASE 0x00021000
#define PIO_LED_SPAN 16
#define PIO_LED_DO_TEST_BENCH_WIRING 0
#define PIO_LED_DRIVEN_SIM_VALUE 0
#define PIO_LED_HAS_TRI 0
#define PIO_LED_HAS_OUT 1
#define PIO_LED_HAS_IN 0
#define PIO_LED_CAPTURE 0
#define PIO_LED_DATA_WIDTH 8
#define PIO_LED_RESET_VALUE 0
#define PIO_LED_EDGE_TYPE "NONE"
#define PIO_LED_IRQ_TYPE "NONE"
#define PIO_LED_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_LED_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PIO_LED_FREQ 50000000
#define ALT_MODULE_CLASS_PIO_LED altera_avalon_pio

/*
 * system library configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none

/*
 * Devices associated with code sections.
 *
 */

#define ALT_TEXT_DEVICE       RAM
#define ALT_RODATA_DEVICE     RAM
#define ALT_RWDATA_DEVICE     RAM
#define ALT_EXCEPTIONS_DEVICE RAM
#define ALT_RESET_DEVICE      RAM

/*
 * The text section is initialised so no bootloader will be required.
 * Set a variable to tell crt0.S to provide code at the reset address and
 * to initialise rwdata if appropriate.
 */

#define ALT_NO_BOOTLOADER


#endif /* __SYSTEM_H_ */
