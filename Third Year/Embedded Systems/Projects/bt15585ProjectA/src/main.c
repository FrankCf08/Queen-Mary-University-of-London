/*----------------------------------------------------------------------------
	Project A
	Author: Frank Cruz
 *---------------------------------------------------------------------------*/

#include "cmsis_os2.h"
#include <MKL25Z4.H>
#include "../include/gpio.h"
#include "../include/pit.h"
#include "../include/tpmPwm.h"
#include "../include/adc_defs.h"

osEventFlagsId_t evtFlags ; // event button flags

osThreadId_t t_tone;        /*  task id of task to for reverse alarm to be On/Off */
/*--------------------------------------------------------------
 *     Array containing the Initial sound values
 *--------------------------------------------------------------*/
const uint32_t array[] = {7953,6687,6312,10020,6312,7953,5958,5308,5308,5623,6312};
const uint32_t volume[] = {24,28,32,36,40,42,50,64,76,81,100,128};
/*--------------------------------------------------------------
 *     Array containing the delay values
 *--------------------------------------------------------------*/
int delays [] = {400,300,275,250,215,185,160,145,75,50,40,20};

int counter;//counts how many times the button has been pressed
int enable;//Enable infraRed
int volt;//value of voltage measured
int pc;//pressed counter variable
/*--------------------------------------------------------------
*     ReverseAlarmOn function:
				1. Wait for button event pressed
				2. Play sound taking values from the array
 *--------------------------------------------------------------*/
void reverseAlarmOnOff(){
		osEventFlagsWait (evtFlags, MASK(PRESS_EVT), osFlagsWaitAny, osWaitForever);
		for(int i=0;i<10;i++){
			setTimer(0,array[i]);//Play initial/end sound
			osDelay(120);
			startTimer(0); // Starting timer
		}//End for loop
		stopTimer(0);
}//End ReveralarmOn

/*--------------------------------------------------------------
*     startBeeps function:
				1. Set timer
				2. Starts timer
				3. Read voltages
				4. Creates delay
				5. Starts timer
				6. Creates delay
 *--------------------------------------------------------------*/
void startBeeps(){
		setPWMDuty(volume[volt]);
		setTimer(0,array[0]);
		startTimer(0);
		voltageRange();
		stopTimer(0);
		osDelay(delays[volt]);
		startTimer(0);
		osDelay(delays[volt]);
}
/*--------------------------------------------------------------
*     pressCounter function:
				If modules of counter is 0, then infraRed Off,
				otherwise On.
 *--------------------------------------------------------------*/
int pressCounter(int count){
	if((counter%2) == 0){
		infraRedLED(LED_OFF);
		return 0;
	}
	infraRedLED(LED_ON);
	return 1;
}

/*------------------------------------------------------------
 *     Tone function - It creates the event when button is 
			 is pressed and switches the infraRed ON or OFF.
 *------------------------------------------------------------*/
void toneTask (void *arg) {
    while (1) {
			pc = pressCounter(counter);
			if(pc == 0){
				reverseAlarmOnOff();
			}
			if(pc == 1){
				readingVoltage();
				startBeeps();
			}
		}
}

/*------------------------------------------------------------
 *     Button task - poll button and send signal when pressed
 *------------------------------------------------------------*/

osThreadId_t t_button;      /* task id of task to read button */

void buttonTask (void *arg) {
    int bState = UP ;
    int bCounter = 0 ;

    while (1) {
        osDelay(10) ;
        if (bCounter) bCounter-- ;
        switch (bState) {
            case UP:
                if (isPressed()) {
                    osEventFlagsSet(evtFlags, MASK(PRESS_EVT));
                    bState = DOWN ;
										counter ++;
                }
                break ;
            case DOWN:
                if (!isPressed()) {
                    bCounter = BOUNCEP ;
                    bState = BOUNCE ;
                }
                break ;
            case BOUNCE:
                if (isPressed()) {
                  bCounter = BOUNCEP ;
                    bState = DOWN ;
                } else {
                    if (!bCounter) {
                        bState = UP ;
                    }
                }
                break ;
        }
    }
}//end Button Task

volatile uint8_t calibrationFailed ; // zero expected

/*----------------------------------------------------------------------------
 *        Main: Initialize and start RTX Kernel
 *---------------------------------------------------------------------------*/
int main (void) {
	
		Init_ADC() ; // Initialise ADC
    calibrationFailed = ADC_Cal(ADC0) ; // calibrate the ADC 
    while (calibrationFailed) ; // block progress if calibration failed
    Init_ADC() ; // Reinitialise ADC
	
		configureGPIOinput() ;       // Initialise button
    configureGPIOoutput() ;      // Initialise output
		configureGPIOinfraRed();	 // Initialise infrared
    configurePIT(0) ;            // Configure PIT channel 0
    setTimer(0, 20040) ; // Frequency for MIDI 60 - middle C
    configureTPM0forPWM() ;
    setPWMDuty(24) ;      // Max is 128; off is 0
		infraRedLED(LED_OFF);			//Initial indraRed state Off
    SystemCoreClockUpdate() ;

    // Initialize CMSIS-RTOS
    osKernelInitialize();
    // Create event flags
    evtFlags = osEventFlagsNew(NULL);
    // Create threads
    t_tone = osThreadNew(toneTask, NULL, NULL) ;// Tone thread
    t_button = osThreadNew(buttonTask, NULL, NULL) ;// Button Thread



    osKernelStart();    // Start thread execution - DOES NOT RETURN
    for (;;) {}         // Only executed when an error occurs
}//End main
