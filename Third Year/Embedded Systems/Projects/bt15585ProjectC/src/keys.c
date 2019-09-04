/* -------------------------------------------------
Configuration steps
					1. isPressed function returns the selected button
          1.Enable pins as GPIO ports for volume,
            audio and audio toggle.
  ------------------------------------------------ */

#include <MKL25Z4.H>
#include <stdbool.h>

#include "../include/keys_defs.h"
#include "../include/LCD.h"
#include "../include/SysTick.h"

char digit[] = {'0','1','2','3','4','5','6','7','8','9'};//arrays of char digits
char position[] = {'0','0','0'};// array of position

/* ----------------------------------------------
     upFunction function:
			 1. Checks the value of the variable 
			 2. Increases/Resets the updown variable
			 3. refreshs the LCD 
 * --------------------------------------------- */
int upFunction(int updown){
     if(updown < 9){
         updown++;//increases value of updown by 1
     }
     else{
         updown = 0;//set value updown equal to zero
     }
	 refreshLCD(updown);
     return updown;
}//End upFunction fucntion

/* ----------------------------------------------
     downFunction function:
			 1. Checks the value of the variable 
			 2. Decreases/Sets 9 to updown variable
			 3. refreshs the LCD 
 * --------------------------------------------- */
int downFunction(int updown){
    if(updown > 0){
        updown--;//decreases value of updown by 1
    }//End iF statement
    else{
        updown = 9;// sets the value of updown to 9
    }//End Else statement
		refreshLCD(updown);
    return updown;
}//End downFuntion fuciton

/* ----------------------------------------------
     leftFunction function:
			 1. Checks the value of the variable 
			 2. Shifts the value
			 3. Decreases the value
			 4. Set to the LCD the new position
 * --------------------------------------------- */
void leftFunction(){

    if(shift>0){
        cursorShift(D_Left);
        shift = shift -1;
        setLCDAddress(1, shift) ;
    }//End if Statement
}//End leftFunction

/* ----------------------------------------------
     rightFunction function:
			 1. Checks the value of the variable 
			 2. Shifts the value
			 3. Increases the value
			 4. Set to the LCD the new position
 * --------------------------------------------- */
void rightFunction(){

 	if(shift < 3){
		cursorShift(D_Right);
		shift = shift +1;
		setLCDAddress(1, shift);
 	}//End if Statement
}//End rightFunction

/* ----------------------------------------------
     refreshLCD function:
			 1. Sets the LCD address 
			 2. Value stored in the position array
			 3. Writes to the LCD
			 4. Set the LCD address
 * --------------------------------------------- */
void refreshLCD(int updown){
	 setLCDAddress(1,shift);//set LCD address according to the shift position
	 position[shift]=digit[updown];
	 writeLCDChar(position[shift]);//Writes to the LCD
	 setLCDAddress(1,shift);//set LCD address according to the shift position
}
