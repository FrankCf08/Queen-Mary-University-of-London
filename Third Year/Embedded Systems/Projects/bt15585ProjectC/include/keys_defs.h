#ifndef KEYS_DEFS_H
#define KEYS_DEFS_H

#include <MKL25Z4.H>
#include <stdint.h>

// External variables
extern int updown;            // raw value - single
extern int shift;

// Function prototypes
int upFunction(int updown) ;
int downFunction(int updown) ;
void leftFunction(void) ;
void rightFunction(void) ;
void refreshLCD(int updown);
#endif
