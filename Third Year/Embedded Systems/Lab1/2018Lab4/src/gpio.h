// Header file for GPIO in Lab 4
//   Definitions for pin usage
//   Function prototypes

#ifndef GPIO_DEFS_H
#define GPIO_DEFS_H

#include <stdbool.h>


#define MASK(x) (1UL << (x))

// Freedom KL25Z LEDs
#define RED_LED_POS (18)    // on port B
#define GREEN_LED_POS (19)	// on port B
#define BLUE_LED_POS (1)	// on port D

// Button is on port D, pin 6
#define BUTTON_POS (6)

#define BUTTONUP (0)
#define BUTTONDOWN (1)
#define BUTTONBOUNCE (2)

#define PRESS_EVT (0) // signal number
#define BOUNCE_COUNT (4)

//States for on and off
#define LED_ON (1)
#define LED_OFF (0)

// LED states
#define RED_ON (2)
#define RED_OFF (3)
#define GREEN_ON (4)
#define GREEN_OFF (5)

// Function prototypes
void configureGPIOoutput(void) ;
void configureGPIOinput(void) ;
void redLEDOnOff (int onOff) ;
void greenLEDOnOff (int onOff) ;
bool isPressed(void) ;

#endif


