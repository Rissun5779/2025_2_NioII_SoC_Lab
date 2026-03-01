/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */
// INC
#include <unistd.h>
#include <io.h>
#include <stdint.h>
#include "system.h"
// Memory Map
#define  PIO_LED (*(volatile uint32_t*)PIO_LED_BASE)
// Variable
#define  LED_COUNT 10
#define  MS 		  1000
// Main
int main()
{
  uint32_t i;
  uint32_t a;

  while(1)
  {
    i = 1u<<(LED_COUNT-1);
    a = 0;

    while(a<LED_COUNT)
    {
    	PIO_LED = i;

    	/*uint32_t timer = (100*MS);
    	while(timer)timer--;*/
    	usleep(100*MS);

    	a++;
    	i>>=1;
    }

    usleep(500*MS);
    a = 0;
    i = 0x01;

    while(a<LED_COUNT)
    {
    	PIO_LED = i;

    	usleep(100*MS);

    	a++;
    	i<<=1;
    }
  }
  return 0;
}
