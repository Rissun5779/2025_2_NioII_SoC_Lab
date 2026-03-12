#include <stdio.h>

#define Lab3
int main()
{
  #if defined(Lab1)
  int a;
  int b;
  int c;
  
  a = 3;
  b = 7;
  c = a&b;
  
  printf("c = %d", c);
  #elif defined(Lab2)
  int x;
  int y;
  int z;
  
  x = 5;
  y = x++;
  z = ++x;
  
  printf("x = %d\n", x);
  printf("y = %d\n", y);
  printf("z = %d\n", z);
  #elif defined(Lab3)
  int sum = 0;
  int i;
  
  for(i=1;i<11;++i){
    sum += i; 
  }
  
  printf("sum(1..10) = %d\n", sum);
  #endif
  return 0;
}
