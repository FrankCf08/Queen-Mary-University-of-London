/*----------------------------------------------------------------------------
    Code for Lab 4

    In this project
        - the red light flashes on/off periodically 
		- pressing the button toggles the green light
	There are three tasks/threads
       t_button: polls the button and signals t_greenLED
       t_RedandGreenLED: flashes the red on and off, using a delay
       t_greenLED: toggles the green LED on receipt of the signal

 *---------------------------------------------------------------------------*/
 
#include "cmsis_os2.h"
#include <MKL25Z4.h>
#include <stdbool.h>
#include "gpio.h"

osEventFlagsId_t evtFlags ;     // event flags
int timerCounter();
/*--------------------------------------------------------------
 *   Thread t_RedandGreenLED
 *       Flash Red LED using a delay
 *--------------------------------------------------------------*/
osThreadId_t t_RedandGreenLED;        /* id of thread to flash red led */
// This attribute structure can change the default 
//   attributes (e.g. priority) of the thread. See documentation.
//   Not usually needed: this is to illustrate.
const osThreadAttr_t redgreenLED_attr = {
  .name = "Red LED",          // Name is used by debugger
  .priority = osPriorityHigh, // Set initial thread priority to high
                              //   defaults is osPriorityNormal
  .stack_size = 256       // Create the thread stack with a size of 256
                          //   this overrides the default set in RTX Config
};

void ledsThread (void *arg) {
    int ledState = RED_ON ;
		uint32_t flag;
    redLEDOnOff(LED_ON);
	
		//uint32_t tick;
		uint32_t t1_1=0;
	  uint32_t t1_2=0;
	  uint32_t timer_1= 3000;
		uint32_t timer_2= 3000;

    while (1) {
		//Question1
		/*			switch (ledState) {
						//switches red LED ON
            case RED_ON:
							  flag = osEventFlagsWait (evtFlags, MASK(PRESS_EVT), osFlagsWaitAny, 3000);
								if(flag != -2){ //If button pressed osFlagsErrorTimeout (-2)
									redLEDOnOff(LED_OFF);
									ledState = RED_OFF ;
								}
								else{//If timer finishes ...
									redLEDOnOff(LED_OFF);
									ledState = GREEN_ON ;
									greenLEDOnOff(LED_ON);
								}
                break ;
            case RED_OFF:
								osEventFlagsWait (evtFlags, MASK(PRESS_EVT), osFlagsWaitAny, osWaitForever);//It waits with the LED OFF until the button is pressed again
                redLEDOnOff(LED_ON);
                ledState = RED_ON ;
                break ;
						case GREEN_ON:
								flag = osEventFlagsWait (evtFlags, MASK(PRESS_EVT), osFlagsWaitAny, 3000);
								if(flag != -2){//If button pressed osFlagsErrorTimeout (-2)
								  greenLEDOnOff(LED_OFF);
									ledState = GREEN_OFF ;
								}
								else{//If timer finishes
									greenLEDOnOff(LED_OFF);
									ledState = RED_ON ;	
									redLEDOnOff(LED_ON);
								}
                break ;
            case GREEN_OFF:
								osEventFlagsWait (evtFlags, MASK(PRESS_EVT), osFlagsWaitAny, osWaitForever);//It waits with the LED OFF until the button is pressed again
                greenLEDOnOff(LED_ON);
                ledState = GREEN_ON ;
                break ; 
        }
			}*/
			
		switch (ledState) {
						//switches red LED ON
            case RED_ON:
							  flag = osEventFlagsWait (evtFlags, MASK(PRESS_EVT), osFlagsWaitAny,timer_1);
								if(flag != -2){ //If button pressed osFlagsErrorTimeout (-2)
									redLEDOnOff(LED_OFF);
									ledState = RED_OFF ;
									t1_1 = osKernelGetTickCount();
								}
								else{//If timer finishes ...
									redLEDOnOff(LED_OFF);
									ledState = GREEN_ON ;
									greenLEDOnOff(LED_ON);
								}
                break ;
            case RED_OFF:
								osEventFlagsWait (evtFlags, MASK(PRESS_EVT), osFlagsWaitAny, osWaitForever);//It waits with the LED OFF until the button is pressed again
								t1_2 = osKernelGetTickCount();
                redLEDOnOff(LED_ON);
								timer_1 = (t1_2 - t1_1);
                ledState = RED_ON ;
                break ;
						case GREEN_ON:
								flag = osEventFlagsWait (evtFlags, MASK(PRESS_EVT), osFlagsWaitAny, timer_2);
								if(flag != -2){//If button pressed osFlagsErrorTimeout (-2)
								  greenLEDOnOff(LED_OFF);
									ledState = GREEN_OFF ; // not pressed
									t1_1 = osKernelGetTickCount();

								}
								else{//If timer finishes
									greenLEDOnOff(LED_OFF);
									ledState = RED_ON ;	
									redLEDOnOff(LED_ON);
								}
                break ;
            case GREEN_OFF:
								osEventFlagsWait (evtFlags, MASK(PRESS_EVT), osFlagsWaitAny, osWaitForever);//It waits with the LED OFF until the button is pressed again
								t1_2 = osKernelGetTickCount();
                greenLEDOnOff(LED_ON);
								timer_2 = (t1_2 - t1_1);
                ledState = GREEN_ON ;
                break ; 
        }
			}

}

/*------------------------------------------------------------
 *  Thread t_button
 *      Poll the button
 *      Signal if button pressed
 *------------------------------------------------------------*/
osThreadId_t t_button;        /* id of thread to poll button */

void buttonThread (void *arg) {
    int state ; // current state of the button
    int bCounter ;
    state = BUTTONUP ;
	
	while (1) {
        osDelay(10);  // 10 ticks delay - 10ms
        switch (state) {
            case BUTTONUP:
                if (isPressed()) {
                    state = BUTTONDOWN ;
                    osEventFlagsSet(evtFlags, MASK(PRESS_EVT));
                }
                break ;
            case BUTTONDOWN:
                if (!isPressed()) {
                    state = BUTTONBOUNCE ;
                    bCounter = BOUNCE_COUNT ;
                }
                break ;
            case BUTTONBOUNCE:
                if (bCounter > 0) bCounter -- ;
                if (isPressed()) {
                    state = BUTTONDOWN ; }
                else if (bCounter == 0) {
                    state = BUTTONUP ;
                }
                break ;
        }
    }
}


/*----------------------------------------------------------------------------
 * Application main
 *   Initialise I/O
 *   Initialise kernel
 *   Create threads
 *   Start kernel
 *---------------------------------------------------------------------------*/
 
int main (void) { 
    // System Initialization
    SystemCoreClockUpdate();

    // Initialise peripherals
    configureGPIOoutput();
    configureGPIOinput();
 
    // Initialize CMSIS-RTOS
    osKernelInitialize();
    
    // Create event flags
    evtFlags = osEventFlagsNew(NULL);

    // Create threads
    t_RedandGreenLED = osThreadNew(ledsThread, NULL, &redgreenLED_attr); 
    t_button = osThreadNew(buttonThread, NULL, NULL); 
    //t_counter = osThreadNew (timerCounter, NULL,NULL)
    osKernelStart();    // Start thread execution - DOES NOT RETURN
    for (;;) {}         // Only executed when an error occurs
}
