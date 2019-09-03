#include "cmsis_os2.h"
#include <MKL25Z4.H>
#include "../include/gpio.h"
#include "../include/adc_defs.h"
#include "../include/pit.h"
#include "../include/tpmPwm.h"

osEventFlagsId_t evtFlags ; // event flags
// Flag PRESS_EVT is set when the button is pressed

volatile float Vin;	// Scaled value for measured voltage
volatile uint8_t calibrationFailed ; // zero expected

// Audio tone states
#define SYS_ON (1)
#define SYS_OFF (0)

osThreadId_t t_enableSystem;        /*  task id of task to arm/disarm system */

void enableSystemTask (void *arg) {
	int systemState = SYS_ON;
	const uint32_t notes[] = {20040, 10020, 5010};
	int delay = 250;
	int i;
    while (1) {
        osEventFlagsWait (evtFlags, MASK(PRESS_EVT), osFlagsWaitAny, osWaitForever); // Wait for button press
        switch (systemState) {
            case SYS_ON:	// Arm system
				osEventFlagsSet(evtFlags, MASK(SYSTEM_ARM));
				startTimer(0) ;
				for(i=1;i<3;i++){ // Play startup tune
					setTimer(0, notes[i]);
					osDelay(delay); // Play note for x milliseconds; x = delay
				}
				stopTimer(0);
				systemState = SYS_OFF ;
                break ;
            case SYS_OFF:	// Disarm system
				osEventFlagsSet(evtFlags, MASK(SYSTEM_DISARM));
				startTimer(0) ;
				for(i=2;i>=0;i--){ // Play shutdown tune
					setTimer(0, notes[i]);
					osDelay(delay); // Play note for x milliseconds; x = delay
				}
				stopTimer(0);
                systemState = SYS_ON ;
                break ;
        }
    }
}

osThreadId_t t_voltageRead;        /*  task id of task to measure voltage from IR sensor */

// Get the voltage 
void voltageReadTask(void *arg) {
	while(1){
		osEventFlagsWait (evtFlags, MASK(GET_VOLTAGE), osFlagsWaitAny, osWaitForever);
		MeasureVoltage();	// Hexadecimal voltage reading
		Vin = 1000 * (VREF * sres) / ADCRANGE ; // Scaled voltage value
		osEventFlagsSet(evtFlags, MASK(VOLTAGE_SET));
	}
}

osThreadId_t t_distance;

void distanceTask(void *arg){
	float IR_Voff;
	float IR_Von;
	const uint32_t notes[] = {11916, 10616, 5958, 5308, 2979, 2654};
	const int ranges[] = {3230, 3200, 3190, 3170, 3140, 3100, 3000, 2850, 2600, 1900, 1000, 200};
	int delay = 100;
	float delay_mult[] = {10, 10, 5, 4.5, 4, 3.5, 3, 2.5, 2, 1.5, 1};
	int i, k, Vmax = 3280;
	int sysArmed = 0;
	uint32_t flagButton;
	float diff;
	osEventFlagsWait(evtFlags, MASK(SYSTEM_ARM), osFlagsWaitAny, osWaitForever); // wait for system to be armed
	sysArmed = 1;
	osDelay(1000);
	
	while(1){
		if(sysArmed==1){ // check if systems is disarmed
			flagButton = osEventFlagsWait(evtFlags, MASK(SYSTEM_DISARM), osFlagsWaitAny, 1);
			if(flagButton == osFlagsErrorTimeout){} // if disarm signal not received, do nothing
			else {
				while(1){
					osEventFlagsWait(evtFlags, MASK(SYSTEM_ARM), osFlagsWaitAny, osWaitForever); // wait for system to be armed
					sysArmed = 1;
					break; // leave loop if armed
				}
			}
		}
		
		// Get voltage reading when IR emitter is off
		setIRLED(LED_OFF); // turn off IR emitter
		osEventFlagsSet(evtFlags, MASK(GET_VOLTAGE)); // get a voltage reading
		osEventFlagsWait(evtFlags, MASK(VOLTAGE_SET), osFlagsWaitAny, osWaitForever); // wait for voltage to be read
		IR_Voff = Vin; // get value for voltage when IR emitter is off
		
		osDelay(10); // wait for IR LED to stabilise
		
		// Get voltage reading when IR emitter is on
		setIRLED(LED_ON); // turn on IR emitter
		osEventFlagsSet(evtFlags, MASK(GET_VOLTAGE)); // get a voltage reading
		osEventFlagsWait(evtFlags, MASK(VOLTAGE_SET), osFlagsWaitAny, osWaitForever); // wait for voltage to be read
		IR_Von = Vin; //get value for voltage when IR emitter is on
		setIRLED(LED_OFF);
		
		diff = IR_Voff - IR_Von;
		for(k=0;k<=11;k++){ // check range and play sound
			if(k==0){ // max range
				if(diff > -100 && diff <= (Vmax - ranges[k])){
					startTimer(0) ;
					setTimer(0, notes[0]);
					osDelay(delay_mult[k]*delay); // Play note for x milliseconds; x = delay
					stopTimer(0);
					osDelay(delay_mult[k]*delay); // Play note for x milliseconds; x = delay
				}
			}
			else if(k >= 1 && k<= 5){ // less than max range
				if((diff > (Vmax - ranges[k])) && diff <= (Vmax - ranges[k+1])){
					startTimer(0) ;
					setTimer(0, notes[2]);
					osDelay(delay_mult[k]*delay); // Play note for x milliseconds; x = delay
					stopTimer(0);
					osDelay(delay_mult[k]*delay); // Play note for x milliseconds; x = delay
				}
			}
			else if(k >= 6 && k<= 10){ // less than max range
				if((diff > (Vmax - ranges[k])) && diff <= (Vmax - ranges[k+1])){
					startTimer(0) ;
					setTimer(0, notes[4]);
					osDelay(delay_mult[k]*delay); // Play note for x milliseconds; x = delay
					stopTimer(0);
					osDelay(delay_mult[k]*delay); // Play note for x milliseconds; x = delay
				}
			}
			else if(k == 11){
				if((diff > (Vmax - ranges[k]))){
					startTimer(0) ;
					setTimer(0, notes[5]);
					while(1) {osDelay(100);}
				}
			}
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
int main (void) {
    configureGPIOinput() ;       // Initialise button
    configureGPIOoutput() ;      // Initialise output    
    configurePIT(0) ;            // Configure PIT channel 0
	Init_ADC() ; // Initialise ADC
    setTimer(0, 20040) ; // Frequency for MIDI 60 - middle C
    configureTPM0forPWM() ;
    setPWMDuty(32) ;     // 64 is 50% volume, Max is 128, off is 0 
    SystemCoreClockUpdate() ;
	setIRLED(LED_OFF);

    // Initialize CMSIS-RTOS
    osKernelInitialize();
    
    // Create event flags
    evtFlags = osEventFlagsNew(NULL);

    // Create threads
    t_enableSystem = osThreadNew(enableSystemTask, NULL, NULL) ;
    t_button = osThreadNew(buttonTask, NULL, NULL) ;
    t_voltageRead = osThreadNew(voltageReadTask, NULL, NULL) ;
	t_distance = osThreadNew(distanceTask, NULL, NULL) ;
    
    
    osKernelStart();    // Start thread execution - DOES NOT RETURN
    for (;;) {}         // Only executed when an error occurs
}
