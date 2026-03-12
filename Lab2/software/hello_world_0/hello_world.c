#include <stdio.h>
#include <io.h>
#include <unistd.h>
//#include <stdint.h>
#include "system.h"

#define Lab3
#define MS 1000
#define LED_REG (*(volatile alt_u32*)PIO_LED_BASE)

int main()
{
  #if defined(Lab1)
  int i, a;
  
  while(1){
     for(a=0, i=0x80;a<8;a++, i=i>>1){
        LED_REG = i;
        usleep(100*MS);  
     }
  }
  #elif defined(Lab2)
  int i = 0xFF;
  LED_REG = 0x0;
   
  while(1){
    LED_REG ^= i;
    usleep(200*MS);
  }
  #elif defined(Lab3)
  char led = 0;
  
  while(1){
    LED_REG = led++;
    usleep(1000*MS);
  }
  #endif
  return 0;
}
