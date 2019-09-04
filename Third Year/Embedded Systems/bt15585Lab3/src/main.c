#include <MKL25Z4.H>
#include <stdbool.h>
#include "SysTick.h"
#include "gpio.h"


/* ------------------------------------------
       ECS642 Lab for week 3
    Interrupts and timing 
  -------------------------------------------- */
        

/*----------------------------------------------------------------------------
  GPIO Output Configuration 
*----------------------------------------------------------------------------*/
void configureOutput() {
     // Configuration steps
     //   1. Enable clock to GPIO ports
     //   2. Enable GPIO ports
     //   3. Set GPIO direction to output
     //   4. Ensure LEDs are off

     // Enable clock to ports B and D
     SIM->SCGC5 |= SIM_SCGC5_PORTB_MASK | SIM_SCGC5_PORTD_MASK;
        
     // Make 3 pins GPIO for on-board LEDs
     PORTB->PCR[RED_LED_POS] &= ~PORT_PCR_MUX_MASK;          
     PORTB->PCR[RED_LED_POS] |= PORT_PCR_MUX(1);          
     PORTB->PCR[GREEN_LED_POS] &= ~PORT_PCR_MUX_MASK;          
     PORTB->PCR[GREEN_LED_POS] |= PORT_PCR_MUX(1);          
     PORTD->PCR[BLUE_LED_POS] &= ~PORT_PCR_MUX_MASK;          
     PORTD->PCR[BLUE_LED_POS] |= PORT_PCR_MUX(1);          

     // Make 2 pins GPIO for oscilloscope
     PORTB->PCR[OUT1_POS] &= ~PORT_PCR_MUX_MASK;          
     PORTB->PCR[OUT1_POS] |= PORT_PCR_MUX(1);          
     PORTB->PCR[OUT2_POS] &= ~PORT_PCR_MUX_MASK;          
     PORTB->PCR[OUT2_POS] |= PORT_PCR_MUX(1);          
    
     // Set ports to outputs
     PTB->PDDR |= MASK(RED_LED_POS) | MASK(GREEN_LED_POS) | MASK(OUT1_POS) | MASK(OUT2_POS);
     PTD->PDDR |= MASK(BLUE_LED_POS);

     // Turn off LEDs
     PTB->PSOR = MASK(RED_LED_POS) | MASK(GREEN_LED_POS);
     PTD->PSOR = MASK(BLUE_LED_POS);
         
         // Set other outputs low
     PTB->PCOR = MASK(OUT1_POS) | MASK(OUT2_POS);
}


/*----------------------------------------------------------------------------
  GPIO Input Configuration

  Initialse a Port D pin as an input, with
    - a pullup resistor 
    - an interrupt on the falling edge
  Bit number given by BUTTON_POS - bit 6, corresponding to J2, pin 14
 *----------------------------------------------------------------------------*/
void configureInput(void) {
    SIM->SCGC5 |=  SIM_SCGC5_PORTD_MASK; /* enable clock for port D */

    /* Select GPIO and enable pull-up resistors and interrupts 
        on falling edges for pins connected to switches */
    PORTD->PCR[BUTTON_POS] &= ~PORT_PCR_MUX_MASK;          
    PORTD->PCR[BUTTON_POS] |= PORT_PCR_MUX(1) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_IRQC(0x0a);
        
    /* Set port D switch bit to inputs */
    PTD->PDDR &= ~MASK(BUTTON_POS);

    /* Enable Interrupts */
    NVIC_SetPriority(PORTD_IRQn, 128); // 0, 64, 128 or 192
    NVIC_ClearPendingIRQ(PORTD_IRQn);  // clear any pending interrupts
    NVIC_EnableIRQ(PORTD_IRQn);
}

/*----------------------------------------------------------------------------
  Turn LEDs on or off 
    onOff can be ON or OFF
*----------------------------------------------------------------------------*/
void setRedLED(int onOff) {
    if (onOff == ON) {
        PTB->PCOR = MASK(RED_LED_POS) ;               
    } 
    if (onOff == OFF) {
        PTB->PSOR =  MASK(RED_LED_POS) ;
    }
    // no change otherwise
}

void setGreenLED(int onOff) {
    if (onOff == ON) {
        PTB->PCOR = MASK(GREEN_LED_POS) ;               
    } 
    if (onOff == OFF) {
        PTB->PSOR =  MASK(GREEN_LED_POS) ;
    }
    // no change otherwise
}
void setBlueLED(int onOff) {
    if (onOff == ON) {
        PTD->PCOR = MASK(BLUE_LED_POS) ;              
    } 
    if (onOff == OFF) {
        PTD->PSOR = MASK(BLUE_LED_POS) ;
    }
    // no change otherwise
}

/*----------------------------------------------------------------------------
 * Interrupt Handler
 *    - Clear the pending request
 *    - Test the bit for pin 6 to see if it generated the interrupt 
  ---------------------------------------------------------------------------- */
// Button signal
//   Set in the interupt handler
//   Cleared by the task in the main cycle
volatile unsigned buttonSignal=0;


void PORTD_IRQHandler(void) {  
    NVIC_ClearPendingIRQ(PORTD_IRQn);
    if ((PORTD->ISFR & MASK(BUTTON_POS))) {
        // Add code to respond to interupt here
        PTB->PTOR = MASK(OUT1_POS) ; // toggle the OUT1 GPIO
    }
    // Clear status flags 
    PORTD->ISFR = 0xffffffff; 
        // Ok to clear all since this handler is for all of Port D
}
//

/*----------------------------------------------------------------------------
  Task 1: flashRed

  Flash the red LED using RED_FLASH_COUNT
 *----------------------------------------------------------------------------*/
int redLedState = OFF ;  // This is the state
int redCounter = 0 ; // This count times the flashes

void task1FlashRed(void) {
    if (redCounter > 0) redCounter-- ;
    
    // Change state if counter zero 
    switch (redLedState) {
        case ON:
            if (redCounter ==0) {
              setRedLED(OFF) ;
              redLedState = OFF ;
                redCounter = RED_FLASH_COUNT ;
            }
            break ;
            
        case OFF:
            if (redCounter ==0) {
              setRedLED(ON) ;
              redLedState = ON ;
                redCounter = RED_FLASH_COUNT ;
            }
            break ;
    }
}

/*----------------------------------------------------------------------------
  Task 2: flashGreen

  Flash the green LED using GREED_FLASH_COUNT
 *----------------------------------------------------------------------------*/
int greenLedState = OFF ;  // This is the state
int greenCounter = 0 ; // This count times the flashes

void task2FlashGreen(void) {
    if (greenCounter > 0) greenCounter-- ;

    // Change state if counter zero 
    switch (greenLedState) {
        case ON:
            if (greenCounter ==0) {
              setGreenLED(OFF) ;
              greenLedState = OFF ;
                greenCounter = GREEN_FLASH_COUNT ;
            }
            break ;
            
        case OFF:
            if (greenCounter ==0) {
              setGreenLED(ON) ;
              greenLedState = ON ;
                greenCounter = GREEN_FLASH_COUNT ;
            }
            break ;
    }
}



/*----------------------------------------------------------------------------
  MAIN function
 *----------------------------------------------------------------------------*/
int main (void) {
    configureInput() ;  // configure the GPIO input for the button
    configureOutput() ;  // configure the GPIO outputs for the LED 
    Init_SysTick(1000) ; // initialse SysTick every 1ms
    waitSysTickCounter(10) ;
    while (1) {
	//			PTB->PSOR = MASK(OUT2_POS); // Set GPIO OUT2 output high (Question3)
        task1FlashRed() ; // flash 
        task2FlashGreen() ; // flash
	//			PTB->PCOR = MASK(OUT2_POS); // Set GPIO OUT2 output LOW
			
//PTB->PTOR = MASK(OUT2_POS) ; // toggle the OUT2 GPIO (Question3.1.2)
        waitSysTickCounter(10) ; // wait to end of cycle 
    }
}

