#ifndef GPIO_H
#define GPIO_H

// Create a bit mask (32 bits) with only bit x set
#define MASK(x) (1UL << (x))

// Freedom KL25Z LEDs pin numbers
#define RED_LED_POS (18)		// on port B
#define GREEN_LED_POS (19)	// on port B
#define BLUE_LED_POS (1)		// on port D

// Additional outputs for oscilloscope
#define OUT1_POS (0)		// on port B
#define OUT2_POS (2)		// on port B


// Switches is on port D, pin 6
#define BUTTON_POS (6)

// On / off times of flashes
#define RED_FLASH_COUNT (85) // 85 x 10ms = 850ms
#define GREEN_FLASH_COUNT (65) // 65 x 10ms = 650ms

// Symbols for constants
#define OFF 0 
#define ON 1 

#endif
