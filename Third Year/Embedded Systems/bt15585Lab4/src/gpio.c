/*----------------------------------------------------------------------------
    Code for Lab 4

    Configuration code for GPIO
    Functions to turn LEDs on and off
    Function to test switch position
 *---------------------------------------------------------------------------*/
 
#include <MKL25Z4.h>
#include <stdbool.h>
#include "gpio.h"


/* ----------------------------------------
	 Configure GPIO output for on-board LEDs 
	   1. Enable clock to GPIO ports
	   2. Enable GPIO ports
	   3. Set GPIO direction to output
	   4. Ensure LEDs are off
 * ---------------------------------------- */
void configureGPIOoutput(void) {

	// Enable clock to ports B and D
	SIM->SCGC5 |= SIM_SCGC5_PORTB_MASK | SIM_SCGC5_PORTD_MASK;
	
	// Make 3 pins GPIO
	PORTB->PCR[RED_LED_POS] &= ~PORT_PCR_MUX_MASK;          
	PORTB->PCR[RED_LED_POS] |= PORT_PCR_MUX(1);          
	PORTB->PCR[GREEN_LED_POS] &= ~PORT_PCR_MUX_MASK;          
	PORTB->PCR[GREEN_LED_POS] |= PORT_PCR_MUX(1);          
	PORTD->PCR[BLUE_LED_POS] &= ~PORT_PCR_MUX_MASK;          
	PORTD->PCR[BLUE_LED_POS] |= PORT_PCR_MUX(1);          
	
	// Set ports to outputs
	PTB->PDDR |= MASK(RED_LED_POS) | MASK(GREEN_LED_POS);
	PTD->PDDR |= MASK(BLUE_LED_POS);

	// Turn off LEDs
	PTB->PSOR = MASK(RED_LED_POS) | MASK(GREEN_LED_POS);
	PTD->PSOR = MASK(BLUE_LED_POS);
}

/*----------------------------------------------------------------------------
  GPIO Input Configuration

  Initialse a Port D pin as an input, with
    - a pullup resistor 
		- an interrupt on the falling edge
  Bit number given by BUTTON_POS - bit 6, corresponding to J2, pin 14
 *----------------------------------------------------------------------------*/
void configureGPIOinput(void) {
	SIM->SCGC5 |=  SIM_SCGC5_PORTD_MASK; /* enable clock for port D */

	/* Select GPIO and enable pull-up resistors and no interrupt */
	PORTD->PCR[BUTTON_POS] |= PORT_PCR_MUX(1) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | 
                              PORT_PCR_IRQC(0x0);
		
	/* Set port D switch bit to inputs */
	PTD->PDDR &= ~MASK(BUTTON_POS);

}

/*----------------------------------------------------------------------------
  Function that turns Red LED on or off
 *----------------------------------------------------------------------------*/
void redLEDOnOff (int onOff) {
	if (onOff == LED_ON) {
		PTB->PCOR = MASK(RED_LED_POS) ;
	} else {
		PTB->PSOR = MASK(RED_LED_POS) ;
	}
}

/*----------------------------------------------------------------------------
  Function that turns Green LED on or off
 *----------------------------------------------------------------------------*/
void greenLEDOnOff (int onOff) {
	if (onOff == LED_ON) {
		PTB->PCOR = MASK(GREEN_LED_POS) ;
	} else {
		PTB->PSOR = MASK(GREEN_LED_POS) ;
	}
}

/*----------------------------------------------------------------------------
  Function that turns Blue LED on or off
 *----------------------------------------------------------------------------*/
void blueLEDOnOff (int onOff) {	
	if (onOff == LED_ON) {
		PTD->PCOR = MASK(BLUE_LED_POS) ;
	} else {
		PTD->PSOR = MASK(BLUE_LED_POS) ;
	}
}

/*----------------------------------------------------------------------------
  isPressed: test the switch

  Operating the switch connects the input to ground. A non-zero value
  shows the switch is not pressed.
 *----------------------------------------------------------------------------*/
bool isPressed(void) {
    if (PTD->PDIR & MASK(BUTTON_POS)) {
        return false ;
    }
    return true ;
}

