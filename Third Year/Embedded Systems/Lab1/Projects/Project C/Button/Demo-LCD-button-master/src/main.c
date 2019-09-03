/* ------------------------------------------
       Demo of LCD-SHIELD buttons //READS CURRENT
             
     This test program uses one external (GPIO) button. Each time the button is 
     pressed it measures the voltage on ADC channel 8 (PTB0). This
     is the pin used for the LCD-SHIELD buttons. The result is displayed on the LCD. 
     
     HOLD THE LCD-SHIELD BUTTON DOWN and then press the external button.
     
     Hardware
     --------
     Arduino LCD shield
     Button1 : PTD pin 6
     LCD is driven using standard pins for shield
     Analog input is on PTB0 (Arduino AD0)
     GND connection to pin on LCD shield
  -------------------------------------------- */

#include <MKL25Z4.H>
#include "../include/gpio_defs.h"
#include "../include/SysTick.h"
#include "../include/LCD.h"
#include "../include/adc_defs.h"
#include <stdbool.h>

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
    uint32_t mask = button ? MASK(BUTTON2_POS) : MASK(BUTTON1_POS) ;
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
int b_state = BUTTONOPEN ;
int pressed = 0 ; // signal
int bounceCounter = 0 ;
volatile float num;

void task1PollInput()  
{
    if (bounceCounter > 0) bounceCounter -- ;
    
    switch (b_state) {
        case BUTTONOPEN :
            if (isPressed(0)) {
                pressed = 1 ;  // create a 'pressed' event
                b_state = BUTTONCLOSED ;
            }
            break ;
        case BUTTONCLOSED :
            if (!isPressed(0)) {
                b_state = BUTTONBOUNCE ;
                bounceCounter = 20 ;
            }
            break ;
        case BUTTONBOUNCE :
            if (isPressed(0)) {
                b_state = BUTTONCLOSED ;
            }
            if (bounceCounter == 0) {
                b_state = BUTTONOPEN ;
            }
            break ;
    }
}


/*----------------------------------------------------------------------------
    When button pressed, display voltage on AD0

    If the keypad button is held down, this shows the voltage
    for each keypad button.
 *----------------------------------------------------------------------------*/
// Return the character representing the least significant
// 4 bits of the parameter
char hexChar(unsigned int h) {
    h = h & 0xF ;
    if (h < 10) return h + 0x30 ;
    else return h + 0x37 ; // 10 -> 65
}

// Return the character representing the digit
// If the number is > 9, gives a '?'
char decChar(unsigned int h) {
    if (h > 9) return 0x3F ;
    return h + 0x30 ;
}
    
void displayHex(char *s, uint16_t v) {
    //char s[] = "0000" ;
    int i = 3 ;
    while (v > 0) {
        s[i] = hexChar(v) ;
        i-- ;
        v = v >> 4 ;
    }
    setLCDAddress(1, 1) ;
    //writeLCDString(s) ;
} 

void displayFixed(char *s, unsigned int v, 
                             unsigned int before, unsigned int after) {
    unsigned int vBy10 ;
    // b=1 a=2  indices are 3, 2, skip, 0
    // b=3 a=0  indices are    skip,2,1,0,
    // skip is at [b]                                                         
    int i = after > 0 ? before + after : before - 1 ;    
    while (i >= 0) {
        vBy10 = v / 10 ;
        s[i] = decChar(v - (vBy10*10)) ;
        i-- ;
        if (i==before) i-- ;
        v = vBy10 ;
    }
    s[before] = '.' ;
}

void task2MeasureKeypad() {
    char mess[] = "RAW:0000 V:XXXXX" ;    // buffer for message
    int i ;
    uint32_t res = 0 ;
    if (pressed) {
        pressed = 0 ; // acknowledge event
        
        // take 16 voltage readings
        for (i = 0; i < 16; i++) { 
          // measure the voltage
            MeasureVoltage() ;
            res = res + sres ;
        }
        
        res = res >> 4 ; // take average
        displayHex(&mess[4], (uint16_t) res) ;//Move
        
        res = (1000 * res * VREF) / ADCRANGE ;
        num = res;//to make this value visible
        displayFixed(&mess[11], res, 1, 3) ;
        setLCDAddress(0, 0) ;
      writeLCDString(mess) ;
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
    Init_ADC() ;
    calibrationFailed = ADC_Cal(ADC0) ; // calibrate the ADC 
    while (calibrationFailed) ; // block progress if calibration failed
    Init_ADC() ;
    lcdClear(true) ;
    waitSysTickCounter(10) ; // initialise counter
    
  // test 1
    while (1) {        
        task1PollInput() ;       // poll button 1
        task2MeasureKeypad() ;   // Measure ADC input and display
        waitSysTickCounter(10) ; // cycle every 10 ms
    }
}

