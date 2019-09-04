#include <MKL25Z4.H>
#include "../include/TPMPWM.h"

/*----------------------------------------------------------------------------
  Configure TPM0 for PWM

  Controlled by the following macro definitions:
       TPM_CHAN the channel on TPM0; note this determines the pin
       PWM_PORT the port, such as PORTA, PORTB etc
       PWM_PIN  the pin, within the port
       ALT_TPM  the alternative number for muxiplexing the pin
    These values must be consistent with the KL25Z pinout
    
    The following values are fixed (i.e. no macros)
       Clock frequency - CPU clock
       Pre-scaling - divide by 4
       Count modulo - 127
         
    Note that there are many other useful configurations of the TPM
    not covered here.
 *----------------------------------------------------------------------------*/ 
void configureTPM0forPWM() {
    
    // Enable clock to TPM0
    SIM->SCGC6 |= SIM_SCGC6_TPM0_MASK;
    // Choose TPM clock – FLLCLK (i.e.20.9 MHz) (section 12.2.3, p195)
    SIM->SOPT2 |= SIM_SOPT2_TPMSRC(1) ; // | SIM_SOPT2_PLLFLLSEL_MASK ;
    // Default value NOT ok for PLLFLLSEL

    // Set the Pin Control Register 
    // Set Pin on PWM_PORT as TPM o/p
    PWM_PORT->PCR[PWM_PIN] &= ~PORT_PCR_MUX_MASK;          
    PWM_PORT->PCR[PWM_PIN] |= PORT_PCR_MUX(ALT_TPM);

    // Count modulo 2^7 - 1 = 127. Note: 128 is used for 100% duty cycle
    TPM0->MOD = TPM_MOD_MOD(127) ;

    // Disable the TPM0
    TPM0->SC = TPM_SC_CMOD(0) ;
    while ((TPM0->SC & TPM_SC_CMOD(3))) ;
    
    // Prescale by 4 with 010
    TPM0->SC |= TPM_SC_PS(0x2) ;
    
    // Configure channel TPM_CHAN
    //   Edge pulse: MSB:A = 1:0
    //   True pulse high: ELSB:A = 1:0
    TPM0->CONTROLS[TPM_CHAN].CnSC = 0x28 ; 
    
    // Set the channel variable - off
    TPM0->CONTROLS[TPM_CHAN].CnV = TPM_CnV_VAL(0) ;
    
    // Set countr to continue when debugging
    TPM0->CONF |= TPM_CONF_DBGMODE(0x3) ;
    
    // Enable using internal clock 
    TPM0->SC |= TPM_SC_CMOD(0x01) ;
    while (!(TPM0->SC & TPM_SC_CMOD(3))) ;
}

/*----------------------------------------------------------------------------
  Set PWM duty cycle
    
    Set the duty cycle. 
    duty value       duty %
       0               0%
     128             100%
 *----------------------------------------------------------------------------*/ 
void setPWMDuty(unsigned int duty) {
    if (duty > PWM_DUTY_MAX) duty = PWM_DUTY_MAX ;
    
    // Set the channel variable
    TPM0->CONTROLS[TPM_CHAN].CnV = TPM_CnV_VAL(duty) ;
}
