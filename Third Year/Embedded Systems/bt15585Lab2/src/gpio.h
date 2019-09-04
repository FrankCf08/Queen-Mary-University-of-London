#ifndef GPIO_H
#define GPIO_H

// Create a bit mask (32 bits) with only bit x set
#define MASK(x) (1UL << (x))

// Freedom KL25Z LEDs pin numbers
#define RED_LED_POS (18)		// on port B
#define GREEN_LED_POS (19)	// on port B
#define BLUE_LED_POS (1)		// on port D
#define EXTERNAL_POS (5) // on Port D

// Switches is on port D, pin 6
#define BUTTON_POS (6)

// Symbols for constants
#define OFF 0 
#define ON 1 
#define PERIOD 100 // time in 10ms units


// States
#define REDON 1 
#define REDOFF 2 
#define BLUEON 3
#define BLUEOFF 4
#define EXTON 5
#define EXTOFF 6

#define BUTTONUP 1 
#define BUTTONDOWN 2 

#endif
