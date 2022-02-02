/* mipslabwork.c

   This file written 2015 by F Lundevall
   Updated 2017-04-21 by F Lundevall

   This file should be changed by Erik Jonsson!
   Updated 2022-01-26

   This file modified 2017-04-31 by Ture Teknolog 

   For copyright and licensing, see file COPYING */

#include <stdint.h>   /* Declarations of uint_32 and the like */
#include <pic32mx.h>  /* Declarations of system-specific addresses etc */
#include "mipslab.h"  /* Declatations for these labs */

int mytime = 0x5957;

char textstring[] = "text, more text, and even more text!";



/* Interrupt Service Routine */
void user_isr( void )
{
  return;
}

/* Lab-specific initialization goes here */
void labinit( void )
{
  return;
}

#pragma region executionOrder
/* This function is called repetitively from the main program */

/*
void labwork( void )
{
  delay( 1000 );
  time2string( textstring, mytime ); //$s0 = addr, $a1 = value
  display_string( 3, textstring );
  display_update();
  tick( &mytime );
  //display_image(96, icon);
}
#pragma endregion

*/