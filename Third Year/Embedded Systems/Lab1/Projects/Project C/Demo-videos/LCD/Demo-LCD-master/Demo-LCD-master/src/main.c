/* ------------------------------------------
       Simple Demo of LCD
             
   This test program uses two buttons    
     Button 1: cycles through a sequence of tests
     Button 2: shows some behaviour of interest  
     
   The test title is displayed on the top line.
   The behaviour is on the bottm line     
   A screen clear is done between each test.

     Test                     Behaviour on button press
     ---------------------------------------------
     1. Scroll text           Display text and scroll right then left
     2. Scroll cursor         Display text and scroll cursor
     3. Increment entry mode  Enter characters in increment mode
     4. Shift entry mode      Enter characters in shift entry mode
     5. Screen control        Cycle through screen off / on states
     
     Hardware
     --------
     Arduino LCD shield
     Button1 : PTD pin 6
     Button2 : PTD pin 7
     GND connection to pin on LCD shield
     
  -------------------------------------------- */

#include <MKL25Z4.H>
#include "../include/gpio_defs.h"
#include "../include/SysTick.h"
#include "../include/LCD.h"
#include <stdbool.h>

#define BUTTONOPEN (0)
#define BUTTONCLOSED (1)
#define BUTTONBOUNCE (2)

#define NO_MESS (0)
#define MESS_A (1)
#define MESS_B (2)
#define MESS_C (3)


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

void task1PollInput(int b)  // 0 or 1
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
                bounceCounter[b] = 20 ;
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

/*----------------------------------------------------------------------------
  task 2: Row names

*----------------------------------------------------------------------------*/
char rowNames[5][16] = {
     "Scroll text", 
     "Scroll cursor",
     "Increment entry",
     "Shift entry",
     "Screen control" } ;

char testString[] = "abcbdefghijklmno" ; 
char testChar ;

int testNum = -1 ;  // number of the test
bool testStarted = true ;
int button2presses = 0 ;
         
void task2ControlLCD(void) {
  // When button 1 pressed, clear screen for next test 
    if (pressed[0]) {
        pressed[0] = 0 ;  // Ack signal
        testStarted = false ;
        testNum = (testNum + 1) % 5 ;
        lcdHome(true) ;  // reset cursor and shift
        lcdMode(M_Inc) ; // reset entry mode
        lcdCntrl(C_BLINK) ; // reset cursor
        lcdClear(false) ;  // clear memory
        return ; // skip to next cycle in 10ms
    }
    
    // at start of test display test name
    if (!testStarted) {
        setLCDAddress(0,0) ;
        writeLCDString(rowNames[testNum]) ;
        testStarted = true ;
        button2presses = 0 ;
        pressed[1] = 0 ; // cancel any outstanding presses
    }
    
    // on button 2 do behaviour
    // button2presses goes from 0 to 10 in a cycle
    if (pressed[1]) {
        pressed[1] = 0 ; // acknowledge

        switch (testNum) {
            case 0: // Scroll text: Display text and scroll right then left
                if (button2presses == 0) {
                    setLCDAddress(1,0) ;
                    writeLCDString(testString) ;
                } else if (button2presses <= 5) {
                    lcdShift(D_Right) ;
                } else {
                    lcdShift(D_Left) ;
                }
                break ;
            case 1: // Scroll cursor: Display text and scroll cursor
                if (button2presses == 0) {
                    setLCDAddress(1,0) ;
                    writeLCDString(testString) ;
                    setLCDAddress(1,0) ;
                } else if (button2presses <= 5) {
                    cursorShift(D_Right) ;
                } else {
                    cursorShift(D_Left) ;
                }
                break ;
            case 2: // Increment entry mode: enter characters in increment mode
                if (button2presses == 0) {
                    setLCDAddress(1,0) ;
                    lcdMode(M_Inc) ;
                    testChar = 'A' ;
                } else {
                    writeLCDChar(testChar) ;
                    testChar++;
                }
                break ;
            case 3: // Shift entry mode: Enter characters in shift entry mode
                if (button2presses == 0) {
                    setLCDAddress(1,10) ;
                    lcdMode(M_IncShift) ;
                    testChar = 'A' ;
                } else {
                    writeLCDChar(testChar) ;
                    testChar++;
                }
                break ;
            case 4: // Screen control: Cycle through screen off / on states
                if (button2presses == 0) {
                    setLCDAddress(1,0) ;
                    writeLCDString("Off|noCr|Cr|Bnk") ;
                    setLCDAddress(1,0) ;
                } else if (button2presses == 1) {
                    lcdCntrl(D_OFF) ;
                } else if (button2presses == 2) {
                    lcdCntrl(C_OFF) ;
                } else if (button2presses == 3) {
                    lcdCntrl(C_ON) ;
                } else if (button2presses == 4) {
                    lcdCntrl(C_BLINK) ;
                    button2presses = 0 ;
                }
                break ;
        }
        button2presses = (button2presses + 1) % 11 ; 
    }
}




/*----------------------------------------------------------------------------
  MAIN function

  Configure and then run tasks every 10ms

 *----------------------------------------------------------------------------*/

int main (void) {
    configureGPIOinput() ;
    Init_SysTick(1000) ; 
    initLCD() ;
    waitSysTickCounter(10) ; // initialise counter
    
  // test 1
    while (1) {        
        task1PollInput(0) ;  // poll button 1
        task1PollInput(1) ;  // poll button 2
        task2ControlLCD() ;    
        waitSysTickCounter(10) ; // cycle every 10 ms
    }
}

