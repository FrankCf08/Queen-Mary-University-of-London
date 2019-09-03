#ifndef GPIO_DEFS_H
#define GPIO_DEFS_H

#define MASK(x) (1UL << (x))

// Freedom KL25Z LEDs
#define RED_LED_POS (18)      // on port B
#define GREEN_LED_POS (19)    // on port B
#define BLUE_LED_POS (1)      // on port D

// Switches is on port D, pins 6, 7
#define BUTTON1_POS (6)
#define BUTTON2_POS (7)


#endif
