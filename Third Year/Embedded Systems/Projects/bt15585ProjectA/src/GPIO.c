#include <MKL25Z4.H>
#include <stdbool.h>
#include "../include/gpio.h"
#include "../include/adc_defs.h"

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
    // Enable clock to port A
    SIM->SCGC5 |= SIM_SCGC5_PORTA_MASK;
    
    // Make pin GPIO
    PORTA->PCR[AUDIO_POS] &= ~PORT_PCR_MUX_MASK;          
    PORTA->PCR[AUDIO_POS] |= PORT_PCR_MUX(1);          
    
    // Set ports to outputs
    PTA->PDDR |= MASK(AUDIO_POS);

    // Turn off output
    PTA->PCOR = MASK(AUDIO_POS);
} ;

/* ----------------------------------------
     Configure GPIO output for infraRed
       1. Enable clock to GPIO port
       2. Enable GPIO port
       3. Set GPIO direction to output
       4. Ensure output low
 * ---------------------------------------- */
void configureGPIOinfraRed(){
	//Enable clock to port D
	SIM->SCGC5 |= SIM_SCGC5_PORTD_MASK;
	
	PORTD->PCR[INFRARED_LED] &= ~PORT_PCR_MUX_MASK;          
  PORTD->PCR[INFRARED_LED] |= PORT_PCR_MUX(1);  
	
	// Set ports to outputs
  PTD->PDDR |= MASK(INFRARED_LED);
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

/* ----------------------------------------
     Toggle the Audio Output 
 * ---------------------------------------- */
void audioToggle(void) {
    PTA->PTOR = MASK(AUDIO_POS) ;
}
/* ----------------------------------------
	infraRedLED function: switches on/off the 
	infra red depending the case.
* ---------------------------------------- */

void infraRedLED(int onOff){
	if (onOff == LED_ON){
		PTD->PCOR = MASK(INFRARED_LED);
	}else{
		PTD->PSOR = MASK(INFRARED_LED);
	}
}

/* ----------------------------------------
	Voltage Range function: Compares reading
	voltage and returns a fix volt number
* ---------------------------------------- */
void voltageRange(void){
	if (voltage>3.2702){
		volt = 0;
	}
	if(voltage >3.1549 && voltage < 3.27){
		volt = 1;
	}
	if(voltage>3.1407 && voltage<3.1548){
		volt = 2;
	}
	if(voltage >3.1304 && voltage < 3.1406){
		volt = 3;
	}
	if (voltage>3.1102 && voltage<3.1303){
		volt = 4;
	}
	if(voltage >3.0904 && voltage < 3.1101){
		volt = 5;
	}
	if(voltage>3.0887 && voltage<3.0903){
		volt = 6;
	}
	if(voltage >3.0687 && voltage < 3.0886){
		volt = 7;
	}
	if (voltage>2.9087 && voltage<3.0686){
		volt = 8;
	}
	if(voltage >2.7140 && voltage < 2.9086){
		volt = 9;
	}
	if(voltage>2.1899 && voltage<2.7139){
		volt = 10;
	}
	if(voltage >0.20 && voltage < 2.1898){
		volt = 11;
	}
}//End voltageRange function
