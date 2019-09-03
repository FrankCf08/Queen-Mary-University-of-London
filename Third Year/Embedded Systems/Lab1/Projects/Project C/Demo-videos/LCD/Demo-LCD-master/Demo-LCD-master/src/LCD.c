
/* =======================================
   LCD Shield Interface Library
            
     Version 1, November 2015
     Updated, November 2018     
            
     See documentation
   ======================================= */
#include <MKL25Z4.H>
#include "../include/LCD.h"
#include <stdbool.h>

// defines for GPIO pins
#define LCD_EN (5)        // on port D
#define LCD_RS (13)       // on port A
#define LCD_DB7 (9)       // on port C
#define LCD_DB6 (8)       // on port C
#define LCD_DB5 (5)       // on port A
#define LCD_DB4 (4)       // on port A

#define MASK(x) (1UL << (x))
//#define RS_MASK (0x8000)        // top bit in uint16_t

/* ----------------------------------------
      Low Level Functions
   ---------------------------------------- */
// Delay function used for timing HORRIBLE
void Delay(unsigned int time_del) {
    // delay is *about* 50 microseconds * time_del
    volatile int t;
    while (time_del--) {
        for (t=240; t>0; t--) ;
    }
}

// syn 1 byte in two stages 
void synByte(bool rs, uint8_t data) {
    if (rs) {
        PTA->PSOR = MASK(LCD_RS) ; } else { PTA->PCOR = MASK(LCD_RS) ; }
    // enable
    PTD->PSOR = MASK(LCD_EN) ;
    
    // first nibble
    if (data & MASK(7)) {
        PTC->PSOR = MASK(LCD_DB7); } else { PTC->PCOR = MASK(LCD_DB7) ; }
    if (data & MASK(6)) {
        PTC->PSOR = MASK(LCD_DB6); } else { PTC->PCOR = MASK(LCD_DB6) ; }
    if (data & MASK(5)) {
        PTA->PSOR = MASK(LCD_DB5); } else {    PTA->PCOR = MASK(LCD_DB5) ; }
    if (data & MASK(4)) {
        PTA->PSOR = MASK(LCD_DB4); } else { PTA->PCOR = MASK(LCD_DB4) ; }
    // delay for a 7 x 20ns = 140ns
    __nop() ; __nop() ; __nop() ; __nop() ; __nop() ; __nop() ; __nop() ;
    
  // disable
    PTD->PCOR = MASK(LCD_EN) ;

    // delay for 13 x 20ns = 260ns 
        __nop() ; __nop() ; __nop() ; __nop() ; __nop() ; __nop() ; __nop() ;
        __nop() ; __nop() ; __nop() ; __nop() ; __nop() ; __nop() ; 

    // enable
    PTD->PSOR = MASK(LCD_EN) ;
    
    // second nibble
    if (data & MASK(3)) {
        PTC->PSOR = MASK(LCD_DB7); } else { PTC->PCOR = MASK(LCD_DB7) ; }
    if (data & MASK(2)) {
        PTC->PSOR = MASK(LCD_DB6); } else { PTC->PCOR = MASK(LCD_DB6) ; }
    if (data & MASK(1)) {
        PTA->PSOR = MASK(LCD_DB5); } else {    PTA->PCOR = MASK(LCD_DB5) ; }
    if (data & MASK(0)) {
        PTA->PSOR = MASK(LCD_DB4); } else {    PTA->PCOR = MASK(LCD_DB4) ; }
    // delay for a 7 x 20ns = 140ns
    __nop() ; __nop() ; __nop() ; __nop() ; __nop() ; __nop() ; __nop() ;
    
  // disable
    PTD->PCOR = MASK(LCD_EN) ;

    // no delay at the end as must wait for instruction to complete
}


// Transmit niddle: only used in initialisation
void initNibble(void) {
    
    // RS = 0
    PTA->PCOR = MASK(LCD_RS) ;
    // enable
    PTD->PSOR = MASK(LCD_EN) ;
    
    // data is 0011
    PTC->PCOR = MASK(LCD_DB7) | MASK(LCD_DB6) ;
    PTA->PSOR = MASK(LCD_DB5) | MASK(LCD_DB4) ;
    
    // delay for a 7 x 20ns = 140ns
    __nop() ; __nop() ; __nop() ; __nop() ; __nop() ; __nop() ; __nop() ;
    
  // disable
    PTD->PCOR = MASK(LCD_EN) ;

    // no delay at the end as must wait for instruction to complete
}

/* ----------------------------------------
      Initialisation
   There are two varieties of initialisation
     - following power on to the LCD
     - initialisation of KL25Z to drive the LCD
   We cannot tell whether the LCD has been power cycled
   but we cannot assume that the memory is empty. So initialisation
   includs a clear screen.
   ---------------------------------------- */
void initLCD(void) {
    // Configure the GPIOs
    
    // Enable clock to ports A & B 
    SIM->SCGC5 |= SIM_SCGC5_PORTA_MASK | SIM_SCGC5_PORTC_MASK | SIM_SCGC5_PORTD_MASK ;
    
    // Make the pin GPIO
    PORTD->PCR[LCD_EN] &= ~PORT_PCR_MUX_MASK;          
    PORTD->PCR[LCD_EN] |= PORT_PCR_MUX(1);          
    PORTA->PCR[LCD_RS] &= ~PORT_PCR_MUX_MASK;          
    PORTA->PCR[LCD_RS] |= PORT_PCR_MUX(1);          
    PORTC->PCR[LCD_DB7] &= ~PORT_PCR_MUX_MASK;          
    PORTC->PCR[LCD_DB7] |= PORT_PCR_MUX(1);          
    PORTC->PCR[LCD_DB6] &= ~PORT_PCR_MUX_MASK;          
    PORTC->PCR[LCD_DB6] |= PORT_PCR_MUX(1);          
    PORTA->PCR[LCD_DB5] &= ~PORT_PCR_MUX_MASK;          
    PORTA->PCR[LCD_DB5] |= PORT_PCR_MUX(1);          
    PORTA->PCR[LCD_DB4] &= ~PORT_PCR_MUX_MASK;          
    PORTA->PCR[LCD_DB4] |= PORT_PCR_MUX(1);          
    
    // Set ports to outputs
    PTA->PDDR |= MASK(LCD_RS) | MASK(LCD_DB5) | MASK(LCD_DB4) ;
    PTC->PDDR |= MASK(LCD_DB7) | MASK(LCD_DB6);
    PTD->PDDR |= MASK(LCD_EN) ;

    // Turn everything off
    PTA->PCOR = MASK(LCD_RS) | MASK(LCD_DB5) | MASK(LCD_DB4) ;
    PTC->PCOR = MASK(LCD_DB7) | MASK(LCD_DB6);
    PTD->PCOR = MASK(LCD_EN) ;

    // Initialise the LCD display
    Delay(300) ;  // wait for 15ms
    initNibble() ;
    Delay(90) ;  // wait for 4.5 ms
    initNibble() ;
    Delay(100) ;
    synByte(false, 0x32) ;
    Delay(2) ;
    
    // configure display
    synByte(false, 0x28) ;  // set function
    Delay(2) ;
    synByte(false, 0x01) ;  // clear
    Delay(30) ; // wait for 1.5 ms
    synByte(false, 0x06) ;  // set mode: inc address, no shift
    Delay(2) ;
    synByte(false, 0x0F) ;  // cursor blink
    Delay(2) ;    
}    ;

/* ----------------------------------------
      User functions
   ---------------------------------------- */

void lcdMode(LCDMode m) {
    switch (m) {
        case M_Inc:
            synByte(false, 0x06) ;  // 0110
            break ;
        case M_Dec:
            synByte(false, 0x04) ;  // 0100
            break ;
        case M_IncShift:
            synByte(false, 0x07) ;  // 0111
            break ;
        case M_DecShift:
            synByte(false, 0x05) ;  // 0101
            break ;
    }
    Delay(1) ;        
}

void lcdCntrl(LCDState s) {
    switch (s) {
        case D_OFF:
            synByte(false, 0x08) ;  // everything off
            break ;
        case C_OFF:
            synByte(false, 0x0C) ;  // display only on
            break ;
        case C_ON:
            synByte(false, 0x0E) ;  // cursor on, blink off
            break ;
        case C_BLINK:
            synByte(false, 0x0F) ;  // cursor blink
            break ;
    }
    Delay(1) ;        
} 

void lcdClear(bool delay) {
    synByte(false, 0x01) ;  // clear
    if (delay) Delay(30) ; // wait for 1.5 ms
} ;

void lcdHome(bool delay) {
    synByte(false, 0x02) ;  // home
    if (delay) Delay(30) ; // wait for 1.5 ms
} ;

/* -----------------
   String is written on one line: 
      Max length 40 characters, as DDRAM has 40 chars for each line
      Behaviour when writing over end of DDRAM line not documented
   -----------------  */
void writeLCDString(char *p) {
    int i = 0 ;
    while (*p) {
        writeLCDChar(*p) ;
        p++ ;
        Delay(1) ;
        i++ ; if (i>39) break; // stop anyway after 40 chars
    } 
} 

/* ---------------------------------
    line is 0 or 1
    position is 0 to 39

    line 0 starts at address 0x00
    line 1 starts at address 0x40
   --------------------------------- */
void setLCDAddress(uint8_t l, uint8_t p) {
    // limit range
    if (l>1) l = 1 ;
    if (p>39) p = 39 ;
    
    // which line
    if (l) {
        // line 1
        synByte(false, 0xC0 | p ) ;  
    } else {
        // line 0
        synByte(false, 0x80 | p ) ;  
    }        
    Delay(1) ;        
} 

void writeLCDChar(char c) {
    synByte(true, c) ;
    Delay(1) ;
} 

void lcdShift(LCDDirection d) {
    switch (d) {
        case D_Left:
          synByte(false, 0x18) ;  
            break ;
        case D_Right:
          synByte(false, 0x1C) ;  
            break ;
    }
    Delay(1) ;
}

void cursorShift(LCDDirection d) {
    switch (d) {
        case D_Left:
          synByte(false, 0x10) ;  
            break ;
        case D_Right:
          synByte(false, 0x14) ;  
            break ;
    }
    Delay(1) ;
}

