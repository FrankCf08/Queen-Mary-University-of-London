#include <stdbool.h>

// Definitions for GPIO
#ifndef GPIO_DEFS_H
#define GPIO_DEFS_H

// MASKing
#define MASK(x) (1UL << (x))

// Button is on port D, pin 6
#define BUTTON_POS (6)
#define IREMITTER_POS (8) // IR emitter on Port B pin 8
#define PRESS_EVT (0) // signal number
#define SYSTEM_ARM (1)
#define SYSTEM_DISARM (2)
#define GET_VOLTAGE (3)
#define VOLTAGE_SET (4)

// Symbols for constants
#define OFF 0 
#define ON 1 

// LED states
#define LED_ON (1)
#define LED_OFF (0)

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
void setIRLED(int onOff) ;

#endif
