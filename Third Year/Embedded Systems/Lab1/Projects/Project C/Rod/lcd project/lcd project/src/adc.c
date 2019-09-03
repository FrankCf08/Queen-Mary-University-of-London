#include <MKL25Z4.H>
#include "..\include\adc_defs.h"

/* ================================
   This file provides the following functions
	    Init_ADC  - intialises the ADC
      MeasureVoltage - measure single-end voltage
			               - result in variable sres (unsigned)
      MeasureVoltageDiff - measure differential voltage
    			               - result in variable dres (signed)
			ADC_Cal   - calibration the ADC
			
	 The variables sres and dres are also declared and
	   are external in the header file 
   ================================ */

/* ------------------------------------
   Initialise ADC 
	 Use S/W trigger, single conversion, no average and 
	 no comparison. 16 bit resolution, with a long sample time.
	 
	 Note: there is no initialisation of the PCR as
	  the ADC function are the default. 
   ------------------------------------- */
void Init_ADC(void) {
	
  // Enable clock to ADC
	SIM->SCGC6 |= (1UL << SIM_SCGC6_ADC0_SHIFT) ;

	// Set the ADC0_CFG1 to 0x9C, which is 1001 1100
	//   1 --> low power conversion
	//   00 --> ADIV is 1, no divide
	//   1 --> ADLSMP is long sample time
	//   11 --> MODE is 16 bit conversion
	//   01 --> ADIClK is bus clock / 2
	ADC0->CFG1 = 0x9C ;
	
	// Set the ADC0_SC2 register to 0
	//   0 --> DATRG - s/w trigger
	//   0 --> ACFE - compare disable
	//   0 --> ACFGT - n/a when compare disabled
	//   0 --> ACREN - n/a when compare disabled
	//   0 --> DMAEN - DMA is disabled
	//   00 -> REFSEL - defaults V_REFH and V_REFL selected
	ADC0->SC2 = 0 ;
	
}

/* --------------------------------------------
    Variabled to hold result
		The clock to the port MUST BE ENABLED: this is not done here.
      Declare volatile to ensure changes seen in debugger
   -------------------------------------------- */
volatile uint16_t sres ;            // raw value - single 
volatile int16_t dres ;            // raw value - differential


/* ---------------------------------------
     Take one measurement of the ADC input
        Single ended on ADC0_S8 (PTB0) 

     The pin is determined by the ADC_CHANNEL macro.
     The clock to the port MUST BE ENABLED: this is not done here.
   --------------------------------------- */
void MeasureVoltage(void) {
	
	 // Write to ADC0_SC1A 
	 //   0 --> AIEN Conversion interrupt diabled
	 //   0 --> DIFF single end conversion 
	 //   01000 --> ADCH, selecting AD8 
   //ADC0->SC1[0] = ADC_CHANNEL ; // writing to this clears the COCO flag 
	 
	 ADC_SC1_REG(ADC0,0) =       // Write to ADC0_SC1A 
   	  //   0 --> AIEN Conversion interrupt diabled
    	ADC_SC1_AIEN(0) |
	    //   0 --> DIFF single end conversion 
     	ADC_SC1_DIFF(0) |
	    // 01000 --> ADCH, selecting AD8 
    	ADC_SC1_ADCH(ADC_CHANNEL) ;
	 // writing to this clears the COCO flag 

	 // test the conversion complete flag, which is 1 when completed
   while (!(ADC0->SC1[0] & ADC_SC1_COCO_MASK))
       ; // empty loop
	
   // Read results from ADC0_RA as an unsigned integer	
   sres = ADC0->R[0] ; // reading this clears the COCO flag  
}

/* ---------------------------------------
     Take one measurement of the ADC input
        Differential on ADC0_DP0 (PTE20) and ADC0_PM0 (PTE21) 

     The pin pair is determined by the ADC_CHANNEL_DIFF macro.
     The clock to the port MUST BE ENABLED: this is not done here.
   --------------------------------------- */
void MeasureVoltageDiff(void) {
	
	 ADC_SC1_REG(ADC0,0) =       // Write to ADC0_SC1A 
   	  //   0 --> AIEN Conversion interrupt diabled
    	ADC_SC1_AIEN(0) |
	    //   1 --> DIFF differential conversion 
     	ADC_SC1_DIFF(1) |
	    // 01000 --> ADCH, selecting DAD0 
    	ADC_SC1_ADCH(ADC_DIFF_CHANNEL) ;
	 // writing to this clears the COCO flag 
	 
	 // test the conversion complete flag, which is 1 when completed
   while (!(ADC0->SC1[0] & ADC_SC1_COCO_MASK))
       ; // empty loop
	
   // Read results from ADC0_RA as an unsigned integer	
   dres = ADC0->R[0] ; // reading this clears the COCO flag  
}

/******************************************************************************
Function AUTO CAL ROUTINE   
Parameters		ADC module pointer points to adc0 or adc1 register map 
                         base address.
Returns			Zero indicates success.
Notes         		Calibrates the ADC16. Required to meet specifications 
                        after reset and before a conversion is initiated.
Taken from
https://github.com/bingdo/FRDM-KL25Z-WIZ550io/blob/master/system/src/kl25-sc/adc16.c
******************************************************************************/
uint8_t ADC_Cal(ADC_MemMapPtr adcmap)
{
  unsigned short cal_var;
  
  ADC_SC2_REG(adcmap) &=  ~ADC_SC2_ADTRG_MASK ; // Enable Software Conversion Trigger for Calibration Process    - ADC0_SC2 = ADC0_SC2 | ADC_SC2_ADTRGW(0);   
  ADC_SC3_REG(adcmap) &= ( ~ADC_SC3_ADCO_MASK & ~ADC_SC3_AVGS_MASK ); // set single conversion, clear avgs bitfield for next writing
  ADC_SC3_REG(adcmap) |= ( ADC_SC3_AVGE_MASK | ADC_SC3_AVGS(0x3u) );  // Turn averaging ON and set at max value ( 32 )
  
  
  ADC_SC3_REG(adcmap) |= ADC_SC3_CAL_MASK ;      // Start CAL
  while ( (ADC_SC1_REG(adcmap,0) & ADC_SC1_COCO_MASK ) == 0 ); // Wait calibration end
  	
  if ((ADC_SC3_REG(adcmap)& ADC_SC3_CALF_MASK) == 1 )
  {  
   return(1);    // Check for Calibration fail error and return 
  }
  // Calculate plus-side calibration
  cal_var = 0x00;
  
  cal_var =  ADC_CLP0_REG(adcmap); 
  cal_var += ADC_CLP1_REG(adcmap);
  cal_var += ADC_CLP2_REG(adcmap);
  cal_var += ADC_CLP3_REG(adcmap);
  cal_var += ADC_CLP4_REG(adcmap);
  cal_var += ADC_CLPS_REG(adcmap);

  cal_var = cal_var/2;
  cal_var |= 0x8000; // Set MSB

  ADC_PG_REG(adcmap) = ADC_PG_PG(cal_var);
 

  // Calculate minus-side calibration
  cal_var = 0x00;

  cal_var =  ADC_CLM0_REG(adcmap); 
  cal_var += ADC_CLM1_REG(adcmap);
  cal_var += ADC_CLM2_REG(adcmap);
  cal_var += ADC_CLM3_REG(adcmap);
  cal_var += ADC_CLM4_REG(adcmap);
  cal_var += ADC_CLMS_REG(adcmap);

  cal_var = cal_var/2;

  cal_var |= 0x8000; // Set MSB

  ADC_MG_REG(adcmap) = ADC_MG_MG(cal_var); 
  
  ADC_SC3_REG(adcmap) &= ~ADC_SC3_CAL_MASK ; /* Clear CAL bit */

  return(0);
}
