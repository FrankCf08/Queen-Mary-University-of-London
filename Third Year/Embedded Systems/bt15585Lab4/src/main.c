/*----------------------------------------------------------------------------
    Code for Lab 4

    In this project
        - the red and green light flashes on/off periodically 
	There are two tasks/threads
       t_button: polls the button and a signal to set the led off and stay in that state untill it is pressed again.
       t_RedandGreenLED: flashes the red and green on and off periodically, 

 *---------------------------------------------------------------------------*/
 
#include "cmsis_os2.h"
#include <MKL25Z4.h>
#include <stdbool.h>
#include "gpio.h"

osEventFlagsId_t evtFlags ;     // event flags
int timerCounter();
/*--------------------------------------------------------------
 *   Thread t_RedandGreenLED
 *       Flash Red and Green LED with a delay of 3s
 *--------------------------------------------------------------*/
osThreadId_t t_RedandGreenLED;        /* id of thread to flash red and green leds */
// This attribute structure can change the default 
//   attributes (e.g. priority) of the thread. See documentation.
//   Not usually needed: this is to illustrate.
const osThreadAttr_t redgreenLED_attr = {
  .name = "Red and Green LED",          // Name is used by debugger
  .priority = osPriorityHigh, // Set initial thread priority to high
                              //   defaults is osPriorityNormal
  .stack_size = 256       // Create the thread stack with a size of 256
                          //   this overrides the default set in RTX Config
};

// Thread Function 
void ledsThread (void *arg) {
    int ledState = RED_ON ;// Initial state
		uint32_t flag; // variable which stores the value of the osEventFlagWait
    redLEDOnOff(LED_ON); // Switching RED LED on	

    while (1) {
		//Viva 1
					switch (ledState) {
						//switches red LED ON
            case RED_ON:
							  flag = osEventFlagsWait (evtFlags, MASK(PRESS_EVT), osFlagsWaitAny, 3000);
								if(flag != -2){ //If button pressed osFlagsErrorTimeout (-2)
									redLEDOnOff(LED_OFF); // set RED LED on
									ledState = RED_OFF ;// new state
								}
								else{//If timer finishes ...
									redLEDOnOff(LED_OFF);// set RED LED off
									ledState = GREEN_ON ; // new state
									greenLEDOnOff(LED_ON); // set GREEN LED on
								}
                break ;
            case RED_OFF:
								osEventFlagsWait (evtFlags, MASK(PRESS_EVT), osFlagsWaitAny, osWaitForever);//It waits until the button is pressed again
                redLEDOnOff(LED_ON);// set RED LED on
                ledState = RED_ON ;// new state
                break ;
						case GREEN_ON:
								flag = osEventFlagsWait (evtFlags, MASK(PRESS_EVT), osFlagsWaitAny, 3000);
								if(flag != -2){//If button pressed osFlagsErrorTimeout (-2)
								  greenLEDOnOff(LED_OFF);//set GREEN LED on
									ledState = GREEN_OFF ;// new state
								}
								else{//If timer finishes
									greenLEDOnOff(LED_OFF);// set GREEN LED off
									ledState = RED_ON ;	// new state
									redLEDOnOff(LED_ON);// set RED LED on
								}
                break ;
            case GREEN_OFF:
								osEventFlagsWait (evtFlags, MASK(PRESS_EVT), osFlagsWaitAny, osWaitForever);//It waits with the LED OFF until the button is pressed again
                greenLEDOnOff(LED_ON);// set GREEN LED on
                ledState = GREEN_ON ;//new state
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
    t_RedandGreenLED = osThreadNew(ledsThread, NULL, &redgreenLED_attr); // creates t_RedandGreenLED thread
    t_button = osThreadNew(buttonThread, NULL, NULL); 
    osKernelStart();    // Start thread execution - DOES NOT RETURN
    for (;;) {}         // Only executed when an error occurs
}
