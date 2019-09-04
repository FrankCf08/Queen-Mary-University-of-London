/*----------------------------------------------------------------------------
    Code for Lab 6

    In this project the PIT and the TPM are used to create a tone. 
 *---------------------------------------------------------------------------*/

#include "cmsis_os2.h"
#include <MKL25Z4.H>
#include "../include/gpio.h"
#include "../include/pit.h"
#include "../include/tpmPwm.h"

osEventFlagsId_t evtFlags ; // event flags
   // Flag PRESS_EVT is set when the button is pressed
// Audio tone states
osThreadId_t t_tone;        /*  task id of task to flash led */
/*--------------------------------------------------------------
 *     Array containing the frequency values
 *--------------------------------------------------------------*/
const uint32_t array[] = {20040, 18915, 17853, 16851, 15905, 15013, 14170, 13375, 12624, 11916, 11247, 10616};

void toneTask (void *arg) {
    int audioState;
		int length = 11; //
		int i = 0;

    while (1) {
        osEventFlagsWait (evtFlags, MASK(PRESS_EVT), osFlagsWaitAny, osWaitForever);
        startTimer(0); // Starting timer
				audioState = array[i];// Getting first value from the array
		
				if(i < length){
					setTimer(0, audioState) ; // Frequency
					i++;
				}
				else{
					i=0;
					setTimer(0, audioState);
				}
		}
}


osThreadId_t t_volume;

void volumeTask(void *arg){
	
	int	min =1; //minimum volume which 0 means 0%, but It has been set up to 1
	int max =128;
	while(1){
		osEventFlagsWait (evtFlags, MASK(SECPRESS_EVT), osFlagsWaitAny, osWaitForever);
		setPWMDuty(min);// determines the volume 
		if(min<=max){
			setPWMDuty(min); // Set new volume 
			min = min*2;// increase volume by 2
		}
		else{
			min=1;// set new start
			setPWMDuty(min);// set new volume
		}
	}
}//End volumeTask

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


/*------------------------------------------------------------
 *     Second Button task - poll button and send signal when pressed
 *------------------------------------------------------------*/

osThreadId_t t_secondButton;      /* task id of task to read button */

void secondButtonTask (void *arg) {
    int bState = UP ;
    int bCounter = 0 ;
    
    while (1) {
        osDelay(10) ;
        if (bCounter) bCounter-- ;
        switch (bState) {
            case UP:
                if (isPressedSec()) {
                    osEventFlagsSet(evtFlags, MASK(SECPRESS_EVT));
                    bState = DOWN ;
                }
                break ;
            case DOWN:
                if (!isPressedSec()) {
                    bCounter = BOUNCEP ;
                    bState = BOUNCE ;
                }
                break ;
            case BOUNCE:
                if (isPressedSec()) {
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
}//End secondButtonTask


/*----------------------------------------------------------------------------
 *        Main: Initialize and start RTX Kernel
 *---------------------------------------------------------------------------*/
int main (void) {
    configureGPIOinput() ;       // Initialise button
		configureGPIOvolumeninput(); // Initialise Second button
    configureGPIOoutput() ;      // Initialise output    
    configurePIT(0) ;            // Configure PIT channel 0
    setTimer(0, 20040) ; // Frequency for MIDI 60 - middle C
    configureTPM0forPWM() ;
    setPWMDuty(64) ;     // 50% volume
                         // Max is 128; off is 0 
    SystemCoreClockUpdate() ;

    // Initialize CMSIS-RTOS
    osKernelInitialize();
    
    // Create event flags
    evtFlags = osEventFlagsNew(NULL);

    // Create threads
    t_tone = osThreadNew(toneTask, NULL, NULL) ;// Tone thread
		t_volume = osThreadNew(volumeTask, NULL, NULL);// Volume Thread
    t_button = osThreadNew(buttonTask, NULL, NULL) ;// Button Thread
		t_secondButton = osThreadNew(secondButtonTask, NULL, NULL) ; //Second button Thread

    
    
    osKernelStart();    // Start thread execution - DOES NOT RETURN
    for (;;) {}         // Only executed when an error occurs
}//End main
