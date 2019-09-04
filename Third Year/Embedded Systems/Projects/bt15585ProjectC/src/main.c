/* ------------------------------------------
  Frank Cruz
  Project C: LCD
  -------------------------------------------- */

#include <MKL25Z4.H>

#include "../include/gpio_defs.h"

#include "../include/adc_defs.h"
#include "../include/SysTick.h"
#include "../include/LCD.h"

#include "../include/keys_defs.h"

#include "../include/pit.h"

#include <stdbool.h>
#include <stdlib.h>

/********************************Global variables used for this project********************************/
char testNames[3][17] = {
     "Enter frequency",
     "AudioTone played ",
     "ERROR, TRY AGAIN",
 };
char statement[] = {"000"};
int b_state[4] = {BUTTONOPEN, BUTTONOPEN, BUTTONOPEN, BUTTONOPEN} ;
int pressed[4] = {0, 0, 0, 0} ;  // signal
int bounceCounter[4] = {0, 0, 0, 0} ; // bouncing counter
int b;
int shift = 0;
int updown1 = 0;
int updown2 = 0;
int updown3 = 0;
float fretopit = 0;
/******************************************************************************************************/
float frequency(){
	float pit;
  int num = updown1*100 + updown2*10 + updown3;
	if(num < 20){// if num =0; it will make my division be undefine and it will give an error
		pit = 250; // value given as it doesn't my sotware breaks and stops running
	}
	else{
		pit = 10485760/(num*2);//calculating PIT number
	}
  return pit;
}//End Frequency fucntion


void task3makeInteger(){
    //Line 1 : Enter Text
    fretopit = frequency();
    setLCDAddress(0, 0) ;//set LCD address
    if(fretopit>262 && fretopit < 262144){
        writeLCDString(testNames[1]) ;
    }
    else{
        writeLCDString(testNames[2]) ;
    }
    //Line 2 : Statement
		setLCDAddress(1, 0) ;//set LCD address
		startTimer(0); // Starting timer
		setTimer(0,fretopit);
		setLCDAddress(1,shift);//set LCD address according to the shift position
		lcdCntrl(C_ON);
}//End finalDiplay function


void task2StateLCD(void){

    if(pressed[b]){

        pressed[b] = 0; //singal to 0

        switch (b){
            case left_case://LEFT Button case
							leftFunction();//calling leftFunction
							break;
            case right_case://RIGHT Button case
							rightFunction();//calling rightFunction
							break;
            case up_case://UP Button case
                switch(shift){
                    case FIRST:
                        updown1 = upFunction(updown1);// Increase the less significant digit
                        break;
                    case SECOND:
                        updown2 = upFunction(updown2);// Increase digit
                        break;
                    case THIRD:
                        updown3 = upFunction(updown3);// Increase the most significant digit
                        break;
                }//End switch case statement
            break;

            case down_case://DOWN Button case
                switch(shift){
                    case FIRST:
                        updown1 = downFunction(updown1);// Decrease less significant digit
                        break;
                    case SECOND:
                        updown2 = downFunction(updown2);// Decrease digit
                        break;
                    case THIRD:
                        updown3 = downFunction(updown3);// Decrease the most significant digit
                        break;
                }//End switch case statement
            break;	
        }
    }
}
void task1ButtonPressed(int b) {

    if(bounceCounter[b] > 0 ) bounceCounter[b] --;
    measureKeypad();
    switch (b_state[b]) {
        case BUTTONOPEN :
            if (isPressed(b)) {
                pressed[b] = 1 ;  // create a 'pressed' event
                b_state[b] = BUTTONCLOSED ;
            }
            break ;
        case BUTTONCLOSED :
            if (!isPressed(b)) {
                b_state[b] = BUTTONBOUNCE ;
                bounceCounter[b] = 20 ;
            }
            break ;
        case BUTTONBOUNCE :
            if (isPressed(b)) {
                b_state[b] = BUTTONCLOSED ;
            }
            if (bounceCounter[b] == 0){
                b_state[b] = BUTTONOPEN ;
            }
            break ;
    }
}// End task1ButtonPressed statement

void initialState(void){
		uint8_t calibrationFailed ; // zero expected
		Init_SysTick(1000) ;
		initLCD() ;
		Init_ADC() ;
		calibrationFailed = ADC_Cal(ADC0) ; // calibrate the ADC
		while (calibrationFailed) ; // block progress if calibration failed
		Init_ADC() ;
		lcdClear(true) ;

		//Line 1 : Enter Text
		setLCDAddress(0, 0) ;
		writeLCDString(testNames[0]) ;
		//Line 2 : Statement
		setLCDAddress(1, 0) ;
		writeLCDString(statement) ;
		setLCDAddress(1,shift);//set LCD address according to the shift position
		lcdCntrl(C_ON);
}//End initailState function

void speaker(void){

    configureGPIOoutput() ;      // Initialise output
    configurePIT(0) ;            // Configure PIT channel 0
    setTimer(0, 20040) ; // Frequency for MIDI 60 - middle C

}//End speaker fucntion

/*----------------------------------------------------------------------------
  MAIN function

  Configure and then run tasks every 10ms

 *----------------------------------------------------------------------------*/

int main (void) {
		speaker();
		initialState();
    waitSysTickCounter(10) ; // initialise counter
    while (1) {
        task1ButtonPressed(b) ; //Check which button has been pressed
        task2StateLCD(); // Do the corresponding task according to the button
        if(shift == 3){
            task3makeInteger();//only do if position is on the 3rd place
        }
        waitSysTickCounter(10) ; // cycle every 10 ms
    }
}//End Main function
