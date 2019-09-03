#include <stdbool.h>

// Definitions for GPIO
#ifndef GPIO_DEFS_H
#define GPIO_DEFS_H

// MASKing
#define MASK(x) (1UL << (x))

// Button is on port D, pin 6
#define BUTTON_POS (6)
#define BUTTON_POS2 (7)
#define PRESS_EVT (0) // signal number
#define PRESS_EVT2 (1) // signal number
#define BLUE_LED_POS (1)
// Button states
#define UP (0)
#define BOUNCE (1)
#define DOWN (2)
#define OUT (8)
#define BOUNCEP (5)  // x delay give bounce time out

// GPIO output used for the frequency, port A pin 2
#define AUDIO_POS (2)
#define LED_ON (11)
#define LED_OFF (10)

// Function prototypes
void configureGPIOinput(void) ;       // Initialise button
void configureGPIOoutput(void) ;      // Initialise output	
void audioToggle(void) ;          // Toggle the output GPIO
bool isPressed(void) ;
bool isPressed2(void) ;
void infraLEDOnOff(int);
void blueLEDOnOff(int);
void initial_sound_on(void);
void initial_sound_off(void);
void playtone(int);
#endif
