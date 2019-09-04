/*  -------------------------------------------
    Lab 5: Demonstration of simple ADC. 2018 Version 1
		

    The system uses code from 
       adc.c   - provides 4 functions for using the ADC
       SysTick.c  - provides 2 functions for using SysTick
       gpio.c - provide code to initialise and use GPIO button and LED
------------------------------------------- */
#include <MKL25Z4.H>
#include <stdbool.h>
#include <stdint.h>

#include "..\include\gpio_defs.h"
#include "..\include\adc_defs.h"
#include "..\include\SysTick.h"

int timeOn, timeOff, ledState, blueCounter = 200;
float Vmin, Vmax;

/*  -----------------------------------------
     Task 1: MeasureVoltage
       res - raw result
       Vin - scaled
    -----------------------------------------   */

// declare volatile to ensure changes seen in debugger
volatile float measured_voltage ;  // scaled value
volatile float bottom, top; //scaled value
void Init_MeasureState(void) {
    ledState = LED_ON ;
		Vmin = 0.7049;// Vmin measured equals to 0.000749
		Vmax = 3017.15;//Vmax voltage measured equals to 3.01715
	  blueLEDOnOff(LED_ON);
}

void task1MeasureVoltage(void) {
		MeasureVoltage() ;    // updates sres variable
		// scale to an actual voltage, assuming VREF accurate
    measured_voltage = 1000*(VREF * sres) / ADCRANGE;
		top = measured_voltage - Vmin;
		bottom = Vmax - Vmin;
		if(measured_voltage <= Vmin){// If Voltage measured(Vin) is less or equals to Vmin, then timeOn = 200 ms
			timeOn = 200;
		}
		else if(measured_voltage >= Vmax){// If voltage measured (Vin) is greater or equals to Vmax, then timeOn = 3800 ms
			timeOn = 3800;
		}  
		else{
			//timeOn = (((measured_voltage - Vmin)/Vmax - Vmin)*3600) +200;// Formula that calculates the timeOn when potentiameter is graduated
			timeOn = ((top/bottom)*3600) + 200;// Formula that calculates the timeOn when potentiameter is graduated
		}
		timeOff = 4000 - timeOn;// Total time  = 4 secs = timeOff + timeOn = 4000 ms
}

///*  -----------------------------------------
//     Task 2: FlashLedOnOff
//			Taking the value of the on-time
//			it updates the value of the counter
//    -----------------------------------------   */

void task2FlashLed(void) {
    if (blueCounter > 0) blueCounter-- ; // check if counter is zero, otherwise substract 1
    // Change state if counter zero 
    switch (ledState) {
        case LED_ON:
            if (blueCounter ==0) {
							blueLEDOnOff(LED_OFF);              
              ledState = LED_OFF;
              blueCounter = timeOff/10 ;//timeOff is divided by 10 to have milliseconds
            }
         break ;
            
        case LED_OFF:
            if (blueCounter ==0) {
							blueLEDOnOff(LED_ON);              
              ledState = LED_ON ;
              blueCounter = timeOn/10 ;//timeOn is divided by 10 to have milliseconds
            }
         break ;
    }
}// End task2FlashLed

/*----------------------------------------------------------------------------
  MAIN function
 *----------------------------------------------------------------------------*/
volatile uint8_t calibrationFailed ; // zero expected
int main (void) {
    // Enable clock to ports B, D and E
    SIM->SCGC5 |= SIM_SCGC5_PORTB_MASK | SIM_SCGC5_PORTD_MASK | SIM_SCGC5_PORTE_MASK ;

    Init_ADC() ; // Initialise ADC
		init_LED(); //Initialise LED
    calibrationFailed = ADC_Cal(ADC0) ; // calibrate the ADC 
    while (calibrationFailed) ; // block progress if calibration failed
    Init_ADC() ; // Reinitialise ADC
    Init_MeasureState() ;  // Initialise measure state 
    Init_SysTick(1000) ; // initialse SysTick every 1ms
    waitSysTickCounter(10) ;

    while (1) {        
        task1MeasureVoltage() ;
				task2FlashLed();
        // delay
				waitSysTickCounter(10) ;  // cycle every 10 ms
    }
}
