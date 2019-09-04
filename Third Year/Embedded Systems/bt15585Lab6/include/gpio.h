#include <stdbool.h>

// Definitions for GPIO
#ifndef GPIO_DEFS_H
#define GPIO_DEFS_H

// MASKing
#define MASK(x) (1UL << (x))

// Button is on port D, pin 6
#define BUTTON_POS (6)
// Button volumen is on port D, pin 7
#define BUTTON_VOL (7)

#define PRESS_EVT (0) // signal number
#define SECPRESS_EVT (1) //second signal number

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
void configureGPIOvolumeninput(void); //Initialise second button
void audioToggle(void) ;          // Toggle the output GPIO
bool isPressed(void) ;
bool isPressedSec(void);

#endif
