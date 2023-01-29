#include <wiringPi.h>
int main (void)
{
  wiringPiSetup () ;
  pinMode (0, OUTPUT) ;
  for (;;)
  {
    	digitalWrite (0, HIGH) ; delay (250) ;
    	digitalWrite (0,  LOW) ; delay (250) ;
	digitalWrite (1, HIGH) ; delay (250) ;
    	digitalWrite (1,  LOW) ; delay (250) ;
	digitalWrite (2, HIGH) ; delay (250) ;
	digitalWrite (2,  LOW) ; delay (250) ;
	digitalWrite (3, HIGH) ; delay (250) ;
	digitalWrite (3,  LOW) ; delay (250) ;
	digitalWrite (4, HIGH) ; delay (250) ;
	digitalWrite (4,  LOW) ; delay (250) ;
  }
  return 0 ;
}
