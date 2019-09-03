#ifndef LCD_H
#define LCD_H
#include <MKL25Z4.H>
#include <stdbool.h>



// types
typedef enum {D_OFF, C_OFF, C_ON, C_BLINK} LCDState ;
typedef enum {D_Left, D_Right} LCDDirection ;	
typedef enum {M_Inc, M_Dec, M_IncShift, M_DecShift} LCDMode ;
	
// prototypes
void initLCD(void) ;
void lcdMode(LCDMode) ;
void lcdCntrl(LCDState) ;
void lcdClear(bool) ;            // with / without delay
void lcdHome(bool) ;             // with / without delay
void writeLCDString(char *p) ;
void setLCDAddress(uint8_t l, uint8_t p) ;
void writeLCDChar(char) ;
void lcdShift(LCDDirection) ;
void cursorShift(LCDDirection) ;

#endif
