#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <wiringPi.h>

// Our lamps:
//	(These are wiringPi pin numbers)

#define	RED		0
#define	YELLOW		1
#define	GREEN		2
#define	RED_MAN		3
#define	GREEN_MAN	4

// The input button

#define	BUTTON		40


/*
 * setup:
 *	Program the GPIO correctly and initialise the lamps
 ***********************************************************************
 */

void setup (void)
{
  int i ;

  if (geteuid () != 0)
  {
    fprintf (stderr, "tuxx: Need to be root to run (sudo?)\n") ;
    exit (0) ;
  }

  if (wiringPiSetup () == -1)
    exit (1) ;

  printf ("Setup ... ") ; fflush (stdout) ;
  for (i = 0 ; i < 5 ; ++i)
  {
    pinMode (i, OUTPUT) ;
    digitalWrite (i, 0) ;
  }
  digitalWrite (GREEN, 1) ;
  digitalWrite (RED_MAN, 1) ;
  pinMode (BUTTON, INPUT) ;

  printf ("OK\n") ;
}

/*
 * waitButton:
 *	Wait for the button to be pressed. Because we have the GPIO
 *	pin pulled high, we wait for it to go low to indicate a push.
 ***********************************************************************
 */

void waitButton (void)
{
  printf ("Waiting for button ... ") ; fflush (stdout) ;
  while (digitalRead (BUTTON) == HIGH)
    delay (100) ;
  printf ("Got it\n") ;
}

/*
 * stopTraffic:
 *	Cycle the traffic lights from Green to Red
 ***********************************************************************
 */

void stopTraffic ()
{
  printf ("Stopping traffic ... ") ; fflush (stdout) ;
  digitalWrite (GREEN,  0) ;
  digitalWrite (YELLOW, 1) ;
  delay (2000) ;
  digitalWrite (YELLOW, 0) ;
  digitalWrite (RED,    1) ;
  delay (2000) ;
  printf ("Stopped\n") ;
}

/*
 * startTraffic:
 *	Back to the Red Man and Green traffic light
 ***********************************************************************
 */

void startTraffic ()
{
  printf ("Starting traffic ... ") ; fflush (stdout) ;

  digitalWrite (GREEN_MAN, 0) ;
  digitalWrite (RED_MAN,   1) ;
  delay (500) ;
  digitalWrite (YELLOW, 0) ;
  digitalWrite (GREEN,  1) ;

  printf ("Going\n") ;
}

/*
 ***********************************************************************
 * The main program
 *	Call our setup routing once, then sit in a loop, waiting for
 *	the button to be pressed then executing the sequence.
 ***********************************************************************
 */

int main (void)
{
  setup () ;
  for (;;)
  {
    waitButton   () ;
    stopTraffic  () ;
//   walk         () ;
//    graceTime    () ;
    startTraffic () ;
  }
}
