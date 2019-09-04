/* -------------------------------------------------
Configuration steps
					1. isPressed function returns the selected button
          1.Enable pins as GPIO ports for volume,
            audio and audio toggle.
  ------------------------------------------------ */

#include <MKL25Z4.H>
#include <stdbool.h>
#include "../include/gpio_defs.h"

#include "../include/LCD.h"

#include "../include/adc_defs.h"

/* ----------------------------------------------
     isPressed function: This function compares
     the value from the res variable and returns
     the corresponding button pres
 * --------------------------------------------- */

bool isPressed(int button) {

    //Left button pressed
    if(res > 40000 && res <45000){
        b = 0;
        return true;
    }// End if statement
     // Right button pressed
    if(res >0 && res<1000){
        b = 1;
        return true;
    }// End if statement
    //Up button pressed
    if(res >10000 && res < 13000){
        b = 2;
        return true;
    }// End if statement
    //Down button pressed
    if(res >24000 && res < 29000){
       b = 3;
       return true;
    }// End if statement
    return false;
}

/* ----------------------------------------
     Configure GPIO output for Audio
       1. Enable clock to GPIO port
       2. Enable GPIO port
       3. Set GPIO direction to output
       4. Ensure output low
 * ---------------------------------------- */

void configureGPIOoutput(void) {
    // Enable clock to port A
    SIM->SCGC5 |= SIM_SCGC5_PORTD_MASK;

    // Make pin GPIO
    PORTD->PCR[AUDIO_POS] &= ~PORT_PCR_MUX_MASK;
    PORTD->PCR[AUDIO_POS] |= PORT_PCR_MUX(1);

    // Set ports to outputs
    PTD->PDDR |= MASK(AUDIO_POS);

    // Turn off output
    PTD->PCOR = MASK(AUDIO_POS);
} ;

/* ----------------------------------------
     Toggle the Audio Output
 * ---------------------------------------- */
void audioToggle(void) {
    PTD->PTOR = MASK(AUDIO_POS) ;
}
