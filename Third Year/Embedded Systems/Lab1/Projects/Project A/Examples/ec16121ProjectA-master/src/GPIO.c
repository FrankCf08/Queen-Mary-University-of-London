#include <MKL25Z4.H>
#include <stdbool.h>
#include "../include/gpio.h"

/*----------------------------------------------------------------------------
  GPIO Input Configuration

  Initialse a Port D pin as an input, with no interrupt
  Bit number given by BUTTON_POS
 *----------------------------------------------------------------------------*/
void configureGPIOinput(void) {
    SIM->SCGC5 |=  SIM_SCGC5_PORTD_MASK; /* enable clock for port D */

    /* Select GPIO and enable pull-up resistors and no interrupts */
    PORTD->PCR[BUTTON_POS] |= PORT_PCR_MUX(1) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_IRQC(0x0);
    
    /* Set port D switch bit to inputs */
    PTD->PDDR &= ~MASK(BUTTON_POS);
}

/* ----------------------------------------
     Configure GPIO output for Audio
       1. Enable clock to GPIO port
       2. Enable GPIO port
       3. Set GPIO direction to output
       4. Ensure output low
 * ---------------------------------------- */
void configureGPIOoutput(void) {
    // Enable clock to port A and B
    SIM->SCGC5 |= SIM_SCGC5_PORTA_MASK;
    SIM->SCGC5 |= SIM_SCGC5_PORTB_MASK;
    
    // Make pin GPIO
    PORTA->PCR[AUDIO_POS] &= ~PORT_PCR_MUX_MASK;
    PORTA->PCR[AUDIO_POS] |= PORT_PCR_MUX(1);

	PORTB->PCR[IREMITTER_POS] &= ~PORT_PCR_MUX_MASK;
    PORTB->PCR[IREMITTER_POS] |= PORT_PCR_MUX(1);
	
    
    // Set ports to outputs
    PTA->PDDR |= MASK(AUDIO_POS);
    PTB->PDDR |= MASK(IREMITTER_POS);

    // Turn off output
    PTA->PCOR = MASK(AUDIO_POS);
} ;

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

/* ----------------------------------------
     Toggle the Audio Output 
 * ---------------------------------------- */
void audioToggle(void) {
    PTA->PTOR = MASK(AUDIO_POS) ;
}

void setIRLED(int onOff) { // active high LED
	if (onOff == ON) {
		PTB->PCOR = MASK(IREMITTER_POS) ;  //set bit turns LED on
    } 
    if (onOff == OFF) {
		PTB->PSOR = MASK(IREMITTER_POS) ;  //clear bit turns LED off
    }
    // no change otherwise
}
