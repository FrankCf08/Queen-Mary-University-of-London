#include <stdbool.h>
#include <stdint.h>
#include "../include/adc_defs.h"

#ifndef GPIO_DEFS_H
#define GPIO_DEFS_H

// MASKing
#define MASK(x) (1UL << (x))

// Freedom KL25Z LEDs

#define BUTTONOPEN (0)
#define BUTTONCLOSED (1)
#define BUTTONBOUNCE (2)

#define left_case (0)
#define right_case (1)
#define up_case (2)
#define down_case (3)

#define FIRST (0)
#define SECOND (1)
#define THIRD (2)

extern int b; // raw value - single

// GPIO output used for the frequency, port D pin 6
#define AUDIO_POS (6)

// Function prototypes
void configureGPIOoutput(void) ;      // Initialise output
void audioToggle(void) ;          // Toggle the output GPIO
bool isPressed(int button);

#endif
