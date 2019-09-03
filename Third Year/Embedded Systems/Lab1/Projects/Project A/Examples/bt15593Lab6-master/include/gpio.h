#include <stdbool.h>

// Definitions for GPIO
#ifndef GPIO_DEFS_H
#define GPIO_DEFS_H

// MASKing
#define MASK(x) (1UL << (x))

// Button is on port D, pin 6
#define BUTTON_POS (6)
#define set_led_rv (7)
#define PRESS_EVT (0) // signal number
#define PRESS_EVTT (7)

// Button states
#define UP (0)
#define BOUNCE (1)
#define DOWN (2)
#define BOUNCEP (5)  // x delay give bounce time out





// GPIO output used for the frequency, port A pin 2
#define AUDIO_POS (2)


// Function prototypes
void configureGPIOinput(void) ;       // Initialise button
void configureGPIOoutput(void) ;      // Initialise output	
void audioToggle(void) ;          // Toggle the output GPIO
bool isPressed(void) ;
bool isPressedd(void) ;

#endif
