#include <stdio.h>
#include "system.h"
#include <unistd.h>
#include <stdint.h>
#include <io.h>

#define WORD         4
#define UART_RX      (*(volatile uint32_t*)UART_0_BASE)
#define UART_TX      (*(volatile uint32_t*)(UART_0_BASE+1*WORD))
#define UART_STATUS  (*(volatile uint32_t*)(UART_0_BASE+2*WORD))
#define UART2_RX     (*(volatile uint32_t*)UART_1_BASE)
#define UART2_TX     (*(volatile uint32_t*)(UART_1_BASE+1*WORD))
#define UART2_STATUS (*(volatile uint32_t*)(UART_1_BASE+2*WORD))
#define MS           1000

int main(void)
{
  int rxdata = 0;
  int status;
  int k      = 0;
  int t      = 0;

  while(1)
  {
	 UART_TX = t++;
     usleep(100*MS);
     status = UART2_STATUS;
     printf(" status=0x%x %d\n", status, k++);
     if(status & 0x080)
     {
    	 if(status & 0x0100)
    	 {
    		 printf("error rxdata ..!\n");
    		 UART2_STATUS = 0x00;
    	 }else{
    		 rxdata = UART2_RX;
    		 printf("Your charcter rxd is:\t%x $d\n", rxdata, k);
    		 UART2_RX = 0x00;
    	 }
     }
  }
  return 0;
}
