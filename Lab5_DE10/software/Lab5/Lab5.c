#include <stdio.h>
#include <stdint.h>
#include "system.h"
//#include <io.h>
#define WORD 4
// TIMER
#define TIMER_STATUS  (*(volatile uint16_t*)SYS_CLK_TIMER_BASE)
#define TIMER_CONTROL (*(volatile uint16_t*)(SYS_CLK_TIMER_BASE+1*WORD))
#define TIMER_PEROIDL (*(volatile uint16_t*)(SYS_CLK_TIMER_BASE+2*WORD))
#define TIMER_PEROIDH (*(volatile uint16_t*)(SYS_CLK_TIMER_BASE+3*WORD))
// PIO
#define LED_REG       (*(volatile uint8_t*)PIO_LED_BASE)
#define SW_REG        (*(volatile uint8_t*)PIO_SW_BASE)
#define MS 			  1000
/* * * * * * * * * * * * * * * * *
 *  Timer Reg Map
 *  ---------------------
 *  0 | status  | RW | 0 => timer out, 1 => run
 *  1 | control | RW | 0 => Interrupt Enable
 *  				   1 => Continuous
 *  				   2 => Start
 *  				   3 => Stop
 *  2 | PERIODL
 *  3 | PERIODH
 *  4 | SnapshotL
 *  5 | SnapshotH
 * * * * * * * * * * * * * * * * * */
#define Lab5
int main()
{
#if defined(Lab1)
  uint32_t FREQ = SYS_CLK_TIMER_FREQ;

  TIMER_PEROIDL = (uint16_t)( FREQ      & 0x0000FFFF);
  TIMER_PEROIDH = (uint16_t)((FREQ>>16) & 0x0000FFFF);
  // Timer start
  TIMER_CONTROL = 0x04;

  while(1){
	if(TIMER_STATUS & 0x01)
	{
		TIMER_STATUS = 0x00;
	   	printf("A second passed!\n");
	}
  }
#elif defined(Lab2)
  uint32_t FREQ = SYS_CLK_TIMER_FREQ;

  TIMER_PEROIDL = (uint16_t)( FREQ      & 0x0000FFFF);
  TIMER_PEROIDH = (uint16_t)((FREQ>>16) & 0x0000FFFF);
  // Timer start
  TIMER_CONTROL = 0x06;

  while(1){
	if(TIMER_STATUS & 0x01)
  	{
  	  TIMER_STATUS = 0x00;
  	  printf("A second passed!\n");
  	}
  }
#elif defined(Lab3)
  uint32_t FREQ = SYS_CLK_TIMER_FREQ;
  int  t = 0;

  TIMER_PEROIDL = (uint16_t)( FREQ      & 0x0000FFFF);
  TIMER_PEROIDH = (uint16_t)((FREQ>>16) & 0x0000FFFF);
  // Timer start
  TIMER_CONTROL = 0x06;

  while(1){
    if(TIMER_STATUS & 0x01)
  	{
      TIMER_STATUS = 0x00;
      printf("A second passed! (%d)\n", t);
      LED_REG = t;
      t++;
    }
  }
#elif defined(Lab4)
  int      		T1     = 250000;
  int      		T2     = 250000;
  unsigned char status = 0x01;

  TIMER_PEROIDL = (uint16_t)( T1      & 0x0000FFFF);
  TIMER_PEROIDH = (uint16_t)((T1>>16) & 0x0000FFFF);
  TIMER_CONTROL = 0x04;
  LED_REG 		= 0xFF;

  while(1)
  {
	  if(TIMER_STATUS & 0x01)
	  {
		TIMER_STATUS = 0x00;
		if(status == 0x01)
		{
			if(T1 == 0){
				T1 = 250000;
			}else{
				T1 = T1-500;
			}
			TIMER_PEROIDL = (uint16_t)( T2      & 0x0000FFFF);
			TIMER_PEROIDH = (uint16_t)((T2>>16) & 0x0000FFFF);
			TIMER_CONTROL = 0x04;

			LED_REG = 0x00;
			status = 0x20;
		}else if(status == 0x20)
		{
			if(T2 == 500000){
				T2 = 250000;
			}else{
				T2 = T2+500;
			}
			TIMER_PEROIDL = (uint16_t)( T1      & 0x0000FFFF);
			TIMER_PEROIDH = (uint16_t)((T1>>16) & 0x0000FFFF);
			TIMER_CONTROL = 0x04;

			LED_REG = 0xFF;
			status = 0x01;
		}
	  }
  }
#elif defined(Lab5)
  uint32_t FREQ = SYS_CLK_TIMER_FREQ;
  uint32_t FREQ_TMP = FREQ;

  while(1)
  {
	if(TIMER_STATUS & 0x01){
		TIMER_STATUS = 0x00;

		switch(SW_REG){
		  case 0x00:
			 FREQ_TMP = FREQ;
			 break;
		  case 0x01:
			 FREQ_TMP = FREQ/2;
			 break;
		  case 0x03:
			 FREQ_TMP = FREQ/4;
			 break;
		  case 0x07:
			 FREQ_TMP = FREQ/8;
			 break;
		  case 0x0F:
			 FREQ_TMP = FREQ/16;
			 break;
		  default:FREQ_TMP = FREQ;
		}

		TIMER_PEROIDL = (uint16_t)( FREQ_TMP      & 0x0000FFFF);
		TIMER_PEROIDH = (uint16_t)((FREQ_TMP>>16) & 0x0000FFFF);
		TIMER_CONTROL = 0x04;
		LED_REG ^= 0xFF;
	}
  }
#endif
  return 0;
}
