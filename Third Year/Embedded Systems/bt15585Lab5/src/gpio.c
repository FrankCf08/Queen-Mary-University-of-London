#include <MKL25Z4.H>
#include <stdbool.h>
#include <stdint.h>

#include "..\include\gpio_defs.h"

/* ------------------------------------------
   Initialise on board LEDs
        Configuration steps
          1. Enable pins as GPIO ports
          2. Set GPIO direction to output
          3. Ensure LEDs are off

   Red LED connected to Port B (PTB), bit 18 (RED_LED_POS)
   Green LED connected to Port B (PTB), bit 19 (GREEN_LED_POS)
   Blue LED connected to Port D (PTD), bit 1 (BLUE_LED_POS)
   Active-Low outputs: Write a 0 to turn on an LED
   ------------------------------------------ */
void init_LED(void) {
    SIM->SCGC5 |=  SIM_SCGC5_PORTB_MASK | SIM_SCGC5_PORTD_MASK; 
      /* enable clock for ports B & D */

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

  Initialse a Port D pin as an input, with no interrupt
  Bit number given by BUTTON_POS
 *----------------------------------------------------------------------------*/
// 
void init_ButtonGPIO(void) {
    SIM->SCGC5 |=  SIM_SCGC5_PORTD_MASK; /* enable clock for port D */

    /* Select GPIO and enable pull-up resistors and no interrupts */
    PORTD->PCR[BUTTON_POS] |= PORT_PCR_MUX(1) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | 
                                PORT_PCR_IRQC(0x0);
    
    /* Set port D switch bit to inputs */
    PTD->PDDR &= ~MASK(BUTTON_POS);
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
void blueLEDOnOff(int onOff) {
    if (onOff == LED_ON) {
        PTD->PCOR = MASK(BLUE_LED_POS) ;              
    } 
    if (onOff == LED_OFF) {
        PTD->PSOR = MASK(BLUE_LED_POS) ;
    }
    // no change otherwise
}
