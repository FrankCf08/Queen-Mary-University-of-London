#include <MKL25Z4.H>
#include "../include/gpio_defs.h"
#include "../include/SysTick.h"
#include "../include/LCD.h"
#include "../include/adc_defs.h"
#include <stdbool.h>
#include <stdio.h>
#include <string.h>

#define BUTTONOPEN (0)
#define BUTTONCLOSED (1)
#define BUTTONBOUNCE (2)

/*----------------------------------------------------------------------------
  GPIO Input Configuration

  Initialse a Port D pin as an input, with no interrupt
  Bit number given by BUTTON_POS
 *----------------------------------------------------------------------------*/ 
 
void configureGPIOinput(void) {
	SIM->SCGC5 |=  SIM_SCGC5_PORTD_MASK; /* enable clock for port D */

	/* Select GPIO and enable pull-up resistors and no interrupts */
	PORTD->PCR[BUTTON1_POS] |= PORT_PCR_MUX(1) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_IRQC(0x0);
	PORTD->PCR[BUTTON2_POS] |= PORT_PCR_MUX(1) | PORT_PCR_PS_MASK | PORT_PCR_PE_MASK | PORT_PCR_IRQC(0x0);
	
	/* Set port D switch bit to inputs */
	PTD->PDDR &= ~(MASK(BUTTON1_POS) | MASK(BUTTON2_POS));
	
}
/*----------------------------------------------------------------------------
  isPressed: test the switch

  Operating the switch connects the input to ground. A non-zero value
  shows the switch is not pressed.
 *----------------------------------------------------------------------------*/

bool isPressed(int button) {
	uint32_t mask = button ? MASK(BUTTON1_POS) : MASK(BUTTON2_POS) ;
	if (PTD->PDIR & mask) {
			return false ;
	}
	return true ;
}

/*----------------------------------------------------------------------------
  task 1: Poll the input

   Detect changes in the switch state.
     isPressed and not closed --> new press; 
     ~isPressed and closed -> not closed
*----------------------------------------------------------------------------*/

int b_state[2] = {BUTTONOPEN, BUTTONOPEN} ;
int pressed[2] = {0, 0} ;  // signal
int bounceCounter[2] = {0, 0} ;

void pollInput(int b)  // 0 or 1
{
	if (bounceCounter[b] > 0) bounceCounter[b] -- ;
	
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
				bounceCounter[b] = 10 ;
			}
			break ;
		case BUTTONBOUNCE :
			if (isPressed(b)) {
				b_state[b] = BUTTONCLOSED ;
			}
			if (bounceCounter[b] == 0) {
				b_state[b] = BUTTONOPEN ;
			}
			break ;
	}
}
			
uint32_t res = 0 ;
void keypadVoltage() {
	int i ;
	for (i = 0; i < 16; i++) { 
		MeasureVoltage() ;
		res = res + sres ;
	}
	
	res = res >> 4 ; // take average		
	res = ( res * VREF) / ADCRANGE ;
}

char input[4] = {'0', '0', '0', '0'};

int currentPositionH = 0;
int currentPositionV = 0;

int num1 = 0;
int num2 = 0;
int num3 = 0;
int num4 = 0;

void refreshLCD(){
	setLCDAddress(1,0);
	
	for (int z = 0; z<4; z++){
		writeLCDChar(input[z]);
	}
	
	int loop = 4 - currentPositionH;
	for (int i = 0; i<loop; i++){
		cursorShift(D_Left);
	}
}

void writeToLCD(){
	if (12000<sres && sres<13000 ) {
		if (currentPositionH == 0) {
			if (num1>0 && num1<50){
			input[0] = '1';
		} else if (num1>50 && num1<100){
			input[0] = '2';
		}else if (num1>100 && num1<150){
			input[0] = '3';
		}else if (num1>150 && num1<200){
			input[0] = '4';
		}else if (num1>200 && num1<250){
			input[0] = '5';
		}else if (num1>250 && num1<300){
			input[0] = '6';
		}else if (num1>300 && num1<350){
			input[0] = '7';
		}else if (num1>350 && num1<400){
			input[0] = '8';
		}else if (num1>400 && num1<450){
			input[0] = '9';
		}else if (num1>450 && num1<500){
			input[0] = '0';
			num1 = 0;
		}
			num1 = num1 + 1;
		} 
		
		if (currentPositionH == 1){
			if (num2==1){
			input[1] = '1';
		} else if (num2==2){
			input[1] = '2';
		}else if (num2==3){
			input[1] = '3';
		}else if (num2==4){
			input[1] = '4';
		}else if (num2==5){
			input[1] = '5';
		}else if (num2==6){
			input[1] = '6';
		}else if (num2==7){
			input[1] = '7';
		}else if (num2==8){
			input[1] = '8';
		}else if (num2==9){
			input[1] = '9';
			num2 = 0;
		}
		waitSysTickCounter(300);
		num2 = num2 + 1;
		}

		if (currentPositionH == 2){
			if (num3==1){
			input[2] = '1';
		} else if (num3==2){
			input[2] = '2';
		}else if (num3==3){
			input[2] = '3';
		}else if (num3==4){
			input[2] = '4';
		}else if (num3==5){
			input[2] = '5';
		}else if (num3==6){
			input[2] = '6';
		}else if (num3==7){
			input[2] = '7';
		}else if (num3==8){
			input[2] = '8';
		}else if (num3==9){
			input[2] = '9';
			num3 = 0;
		}
		waitSysTickCounter(300);
		num3 = num3 + 1;
		}
		
		if (currentPositionH == 3){
			if (num4==1){
			input[3] = '1';
		} else if (num4==2){
			input[3] = '2';
		}else if (num4==3){
			input[3] = '3';
		}else if (num4==4){
			input[3] = '4';
		}else if (num4==5){
			input[3] = '5';
		}else if (num4==6){
			input[3] = '6';
		}else if (num4==7){
			input[3] = '7';
		}else if (num4==8){
			input[3] = '8';
		}else if (num4==9){
			input[3] = '9';
			num4 = 0;
		}
		waitSysTickCounter(30);
		num4 = num4 + 1;
		}
		refreshLCD();
	} else if (44000<sres && sres<45000 && currentPositionH > 0) {
		//left
		cursorShift(D_Left);
		currentPositionH = currentPositionH - 1;
		waitSysTickCounter(300);
	} else if (0<sres && sres<1000 && currentPositionH < 3) {
		//right
		cursorShift(D_Right);
		currentPositionH = currentPositionH + 1;
		waitSysTickCounter(300);
	} else if  (28000<sres && sres<29000){
		if (currentPositionH == 0) {
			num1 = num1 - 1;
			waitSysTickCounter(300);
			if (num1>0 && num1<50){
			input[0] = '1';
			num1 = 420;
		} else if (num1>50 && num1<100){
			input[0] = '2';
		}else if (num1>100 && num1<150){
			input[0] = '3';
		}else if (num1>150 && num1<200){
			input[0] = '4';
		}else if (num1>200 && num1<250){
			input[0] = '5';
		}else if (num1>250 && num1<300){
			input[0] = '6';
		}else if (num1>300 && num1<350){
			input[0] = '7';
		}else if (num1>350 && num1<400){
			input[0] = '8';
		}else if (num1>400 && num1<450){
			input[0] = '9';
		}else if (num1>450 && num1<500){
			input[0] = '0';
		}
		} 
		
		if (currentPositionH == 1){
			num2 = num2 - 1;
			waitSysTickCounter(300);
			if (num2==1){
			input[1] = '1';
			num2 = 10;
		} else if (num2==2){
			input[1] = '2';
		}else if (num2==3){
			input[1] = '3';
		}else if (num2==4){
			input[1] = '4';
		}else if (num2==5){
			input[1] = '5';
		}else if (num2==6){
			input[1] = '6';
		}else if (num2==7){
			input[1] = '7';
		}else if (num2==8){
			input[1] = '8';
		}else if (num2==9){
			input[1] = '9';
		}
		}

		if (currentPositionH == 2){
			num3 = num3 - 1;
			waitSysTickCounter(300);
			if (num3==1){
			input[2] = '1';
				num3 = 10;
		} else if (num3==2){
			input[2] = '2';
		}else if (num3==3){
			input[2] = '3';
		}else if (num3==4){
			input[2] = '4';
		}else if (num3==5){
			input[2] = '5';
		}else if (num3==6){
			input[2] = '6';
		}else if (num3==7){
			input[2] = '7';
		}else if (num3==8){
			input[2] = '8';
		}else if (num3==9){
			input[2] = '9';
		}
		}
		
		if (currentPositionH == 3){
			num4 = num4 - 1;
			waitSysTickCounter(300);
			
			if (num4==1){
			input[3] = '1';
			num4 = 10;
		} else if (num4==2){
			input[3] = '2';
		}else if (num4==3){
			input[3] = '3';
		}else if (num4==4){
			input[3] = '4';
		}else if (num4==5){
			input[3] = '5';
		}else if (num4==6){
			input[3] = '6';
		}else if (num4==7){
			input[3] = '7';
		}else if (num4==8){
			input[3] = '8';
		}else if (num4==9){
			input[3] = '9';
		}
		}
		refreshLCD();
	} 	
}


void startLCD () {
	writeLCDString("Enter a Number:");
	setLCDAddress(1,0);
	writeLCDString("0000");
	setLCDAddress(1,0);
}



void finalLCD() {
	lcdClear(true);
	writeLCDString("Your number was:");
	setLCDAddress(1,0);
	writeLCDString(input);
	setLCDAddress(1,0);
	for (int i=0; i<20; i++){
		cursorShift(D_Right);
	}
}



/*----------------------------------------------------------------------------
  MAIN function

  Configure and then run tasks every 10ms

 *----------------------------------------------------------------------------*/

int main (void) {
	uint8_t calibrationFailed ; // zero expected
	configureGPIOinput() ;
	Init_SysTick(1000) ; 
	initLCD() ;
	startLCD();
	Init_ADC() ;
	calibrationFailed = ADC_Cal(ADC0) ; // calibrate the ADC 
	while (calibrationFailed) 
		; // block progress if calibration failed
  Init_ADC() ;
  waitSysTickCounter(10) ; // initialise counter
	
	int test = 1;
  // test 1
	while (test == 1) {		
		pollInput(0) ;  // poll button 1
		keypadVoltage();
		writeToLCD();
	  waitSysTickCounter(1) ; // cycle every 10 ms
		if (pressed[0]){
			pressed[0] = 0;
			test = 0;
			finalLCD();
	}
}
}

