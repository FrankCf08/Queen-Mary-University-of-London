/*----------------------------------------------------------------------------
    Code for Lab 6

    In this project the PIT and the TPM are used to create a tone. 
 *---------------------------------------------------------------------------*/

#include "cmsis_os2.h"
#include <MKL25Z4.H>
#include "../include/gpio.h"
#include "../include/pit.h"
#include "../include/tpmPwm.h"

#include "..\include\adc_defs.h"

osEventFlagsId_t evtFlags ; // event flags
osEventFlagsId_t evtFlagss;
   // Flag PRESS_EVT is set when the button is pressed

/*--------------------------------------------------------------
 *     Tone task - switch tone on and off
 *--------------------------------------------------------------*/
// Audio tone states
#define TONE_ON (1)
#define TONE_OFF (0)

#define ON 1
#define OFF 0


volatile float measured_voltage ;

void task2MeasureVoltage(void) {
		MeasureVoltage() ;
		measured_voltage = (VREF * sres) / ADCRANGE ;
}
void setrv(int onOff) {
    if (onOff == LED_ON) {
        PTD->PCOR = MASK(set_led_rv) ;              
    } 
    if (onOff == LED_OFF) {
        PTD->PSOR = MASK(set_led_rv) ;
    }
    // no change otherwise
}


 int enible  ;
 int counter ;
void 	check_me(){

			if(counter %2 == 0){
				enible = 0;
				setrv(LED_OFF);// you need to set the ton for on	
				//measured_voltage =0;
				}
				else{
				enible = 1;
				setrv(LED_ON); //you need to set the tone for off
				}
}


void tun_ON_OFF(){
	int i;
	const uint32_t array[] = {1000,3750,6000,8000,10000,4000,8000,1000,12624,11916,11247,10616,};//32 bit aray 
	//const uint32_t array[] = {20040,18915,17853,16851,15905,15013,14170,13375,12624,11916,11247,10616};//32 bit aray 
	
	
	for (i =0 ;i<5; i++)
	{
		
		setTimer(0, array[i]) ; // Frequency for MIDI 60 - middle C
		osDelay(500);
		startTimer(0);
	
	}
	stopTimer(0);
}
int audio = 20040 ;
int y  = 0;
void play_me(){
	float step[] ={0.2,0.5,0.8,1,1.3,1.6,1.9,2.3,2.6,2.9,3.2};
	int delay []={20,30,40,50,60,70,80,90,100,110,120};
	
	setTimer(0,audio) ; // Frequency for MIDI 60 - middle C
		startTimer(0);
		if(measured_voltage <= step[y]){
			stopTimer(0);
			osDelay(delay [y]);
			startTimer(0);
			osDelay(delay [y]);
		}
		if( y ==10)
		{
			y =0 ;
		}
		y =y+1;
	
}

int ON_OFF =0;
osThreadId_t t_tone;        /*  task id of task to flash led */
void toneTask (void *arg) {
	const uint32_t array[] = {20040,18915,17853,16851,15905,15013,14170,13375,12624,11916,11247,10616};//32 bit aray 
    int audioState = TONE_OFF ;
		
    while (1) {
					
			if(enible == 0){
			osEventFlagsWait (evtFlags, MASK(PRESS_EVT), osFlagsWaitAny, osWaitForever); //whait for the interrupt to be accured
			tun_ON_OFF();
			}
      
			check_me();
			
			if (enible ==1)
			{
				task2MeasureVoltage();
				play_me ();
			}

			
    }//end while
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
										counter++;
                    osEventFlagsSet(evtFlags, MASK(PRESS_EVT));
										osEventFlagsSet(evtFlagss, MASK(PRESS_EVT));
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
}



	


/*----------------------------------------------------------------------------
 *        Main: Initialize and start RTX Kernel
 *---------------------------------------------------------------------------*/
	
volatile uint8_t calibrationFailed ; // zero expected
int main (void) {
    configureGPIOinput() ;       // Initialise button
    configureGPIOoutput() ;      // Initialise output  
		Init_ADC() ; // Initialise ADC
    calibrationFailed = ADC_Cal(ADC0) ; // calibrate the ADC 
    while (calibrationFailed) ; // block progress if calibration failed
    Init_ADC() ; // Reinitialise ADC  
    configurePIT(0) ;            // Configure PIT channel 0
		//setTimer(0, 16851) ; // Frequency for MIDI 60 - middle C
		//startTimer(0);
    configureTPM0forPWM() ;
    setPWMDuty(128) ;     // 1% volume
                         // Max is 128; off is 0 
    SystemCoreClockUpdate() ;

    // Initialize CMSIS-RTOS
    osKernelInitialize();
    
    // Create event flags
    evtFlags = osEventFlagsNew(NULL);
		evtFlagss = osEventFlagsNew(NULL);

    // Create threads
    t_tone = osThreadNew(toneTask, NULL, NULL) ;
    t_button = osThreadNew(buttonTask, NULL, NULL) ; 

//		t_tone_on_off = osThreadNew(toneTask_lets_go, NULL, NULL) ;
		 
		
    
    
    osKernelStart();    // Start thread execution - DOES NOT RETURN
    for (;;) {}         // Only executed when an error occurs
}
