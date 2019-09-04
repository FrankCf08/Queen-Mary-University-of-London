#include <MKL25Z4.H>
#include <stdbool.h>
#include "SysTick.h"
#include "gpio.h"


/* ------------------------------------------
       ECS642 Lab for week 2 2018
   Demonstration of simple digital input
   Use of RGB LED on Freedom board
  -------------------------------------------- */
        

/*----------------------------------------------------------------------------
  Turn LEDs on or off 
    onOff can be ON or OFF
*----------------------------------------------------------------------------*/
void setRedLED(int onOff) { // turns RED LED ON or OFF depending on the value of onOff
    if (onOff == ON) {
        PTB->PCOR = MASK(RED_LED_POS) ; // using PCOR to clear the pin for the RED LED (Active-low)       
    } 
    if (onOff == OFF) {
        PTB->PSOR =  MASK(RED_LED_POS) ; // using PSOR to set the pin for the RED LED (Active-low)
    }
    // no change otherwise
}

void setBlueLED(int onOff) {// turns BLUE LED ON  or OFF depending on the value of onOff
    if (onOff == ON) {
        PTD->PCOR = MASK(BLUE_LED_POS) ;    // using PCOR to clear the pin for the BLUE LED (Active-low)                 
    } 
    if (onOff == OFF) {
        PTD->PSOR = MASK(BLUE_LED_POS) ;  // using PSOR to set the pin for the BLUE LED (Active-low)
    }
    // no change otherwise
}

void setExtLED(int onOff){ // Turns EXTERNAL LED ON or OFF depending on the value of onOff
		if (onOff == ON){
				PTD->PSOR = MASK(EXTERNAL_POS) ; // using PSOR to set the external position bit high (Active-high)
		}
		if (onOff == OFF){
				PTD->PCOR = MASK(EXTERNAL_POS) ;// using PCOR to clear the external position bit (Active-high)
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

/*----------------------------------------------------------------------------
  checkButton

This function checks whether the button has been pressed
*----------------------------------------------------------------------------*/
int buttonState ; // current state of the button
bool pressed ; // signal if button pressed

void initButton() {
    buttonState = BUTTONUP ;
    pressed = false ; 
}

void checkButton() {
    switch (buttonState) {
        case BUTTONUP:
            if (isPressed()) {
                buttonState = BUTTONDOWN ;
                pressed = true ; 
            }
            break ;
        case BUTTONDOWN:
            if (!isPressed()) {
                buttonState = BUTTONUP ;
            }
            break ;
    }                               
}

/*----------------------------------------------------------------------------
  nextFlash 

This function evaluates whether the system should change state. 
The system stays in each state for a number of cycles, counted by 
the 'count' variable. It changes state of the button is pressed.
*----------------------------------------------------------------------------*/
int state ; 
int count ;

void initFlash() { // Initial function which turns on RED LED at the beginning
    count = PERIOD ;
    state = REDON ;
    setRedLED(ON) ;// set RED LED on
    setBlueLED(OFF) ; // set BLUE LED off
		setExtLED(OFF); // set EXTERNAL LED off
}

void nextFlash() {
   if (count > 0) count -- ;
       switch (state) {
           case REDON:
	             if (count == 0) {   // The time transition has priority
                   setRedLED(OFF) ; // set RED LED off
                   state = REDOFF ;
                   count = PERIOD ;
	             } else if (pressed) { // The button transition can occur on next cycle 
                   pressed = false ;
                   setRedLED(OFF) ; // set RED LED off
                   setBlueLED(ON) ; // set BLUE LED on
                   state = BLUEON ;
               }
               break ;

           case REDOFF:
               if (count == 0) {    // The time transition has priority
                   setRedLED(ON) ;  // set RED LED on
                   state = REDON ;
                   count = PERIOD ;
               } else if (pressed) { // The button transition can occur on next cycle
                   pressed = false ;
                   state = BLUEOFF ;
               }
               break ;
                        
           case BLUEON:
               if (count == 0) {   // The time transition has priority. 
                   setBlueLED(OFF) ; // set BLUE LED off
                   state = BLUEOFF ;
                   count = PERIOD ;
               } else if (pressed) {
                   pressed = false ;
                   setBlueLED(OFF) ; // set BLUE LED off
                   setExtLED(ON) ; // set EXTERNAL LED on
                   state = EXTON ;
               }
               break ;

           case BLUEOFF: 
               if (count == 0) {
                   setBlueLED(ON) ; // set BLUE LED on
                   state = BLUEON ;
                   count = PERIOD ;
               } else if (pressed) {
                   pressed = false ;
                   state = EXTOFF ;
               }
               break ;
					// new cases EXTON and EXTOFF, which allows to switch ON and OFF the EXTERNAL LED		 
					case EXTON:
	             if (count == 0) {   // The time transition has priority
                   setExtLED(OFF) ; // set EXTERNAL LED off
                   state = EXTOFF ;
                   count = PERIOD ;
	             } else if (pressed) { // The button transition can occur on next cycle 
                   pressed = false ; // variable set to false after
                   setExtLED(OFF) ; // set EXTERNAL LED off
                   setRedLED(ON) ;// set RED LEF on
                   state = REDON ;
               }
               break ;

           case EXTOFF:
               if (count == 0) { // the time transition has priority
                   setExtLED(ON) ; // set EXTERNAL LED on
                   state = EXTON ;
                   count = PERIOD ;
               } else if (pressed) {
                   pressed = false ;
                   state = REDOFF ;
               }
               break ;
                        
        }
}

/*----------------------------------------------------------------------------
  Configuration 
     The configuration of the GPIO port is explained in week 2
     Enabling the clocks will be covered in week 3.
     Configuring the PORTx peripheral, which controls the use of each pin, will
       be covered in week 3
*----------------------------------------------------------------------------*/
void configureOutput() {
     // Configuration steps
     //   1. Enable clock to GPIO ports
     //   2. Enable GPIO ports
     //   3. Set GPIO direction to output
     //   4. Ensure LEDs are off

     // Enable clock to ports B and D
     SIM->SCGC5 |= SIM_SCGC5_PORTB_MASK | SIM_SCGC5_PORTD_MASK;
        
     // Make 3 pins GPIO
     PORTB->PCR[RED_LED_POS] &= ~PORT_PCR_MUX_MASK;          
     PORTB->PCR[RED_LED_POS] |= PORT_PCR_MUX(1);          
     PORTB->PCR[GREEN_LED_POS] &= ~PORT_PCR_MUX_MASK;          
     PORTB->PCR[GREEN_LED_POS] |= PORT_PCR_MUX(1);          
     PORTD->PCR[BLUE_LED_POS] &= ~PORT_PCR_MUX_MASK;	
     PORTD->PCR[BLUE_LED_POS] |= PORT_PCR_MUX(1);   
     // these lines make another pin of PortD a GPIO
     PORTD->PCR[EXTERNAL_POS] &= ~PORT_PCR_MUX_MASK;	
     PORTD->PCR[EXTERNAL_POS] |= PORT_PCR_MUX(1);   

     // Set ports to outputs
     PTB->PDDR |= MASK(RED_LED_POS) | MASK(GREEN_LED_POS);
     PTD->PDDR |= MASK(BLUE_LED_POS) | MASK(EXTERNAL_POS);

     // Turn off LEDs
     PTB->PSOR = MASK(RED_LED_POS) | MASK(GREEN_LED_POS);
     PTD->PSOR = MASK(BLUE_LED_POS);
		 PTD->PCOR = MASK(EXTERNAL_POS);

}

/*----------------------------------------------------------------------------
  GPIO Input Configuration

  Initialse a GPIO port D pin as an input (GPIO data direction register)
  Bit number given by BUTTON_POS
  Configure PORTD (not covered until week 3) so that the pin has no interrupt
     and a pull up resistor is enabled.
 *----------------------------------------------------------------------------*/
// 
void configureInput(void) {
    SIM->SCGC5 |=  SIM_SCGC5_PORTD_MASK; /* enable clock for port D */

    /* Select GPIO and enable pull-up resistors and no interrupts */
    PORTD->PCR[BUTTON_POS] |= PORT_PCR_MUX(1) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | 
	           PORT_PCR_IRQC(0x0);
        
    /* Set port D switch bit to be an input */
    PTD->PDDR &= ~MASK(BUTTON_POS);

}

/*----------------------------------------------------------------------------
  MAIN function
 *----------------------------------------------------------------------------*/
int main (void) {
    configureInput() ;  // configure the GPIO input for the button
    configureOutput() ;  // configure the GPIO outputs for the LED 
    initButton() ;
    initFlash() ;
    Init_SysTick(1000) ; // initialse SysTick every 1ms
    waitSysTickCounter(10) ; // cycle every 10ms
    while (1) {
        checkButton() ; // check button
        nextFlash() ; // flash LEDs 
        waitSysTickCounter(10) ; // wait to end of cycle
    }
}

