#include <stdio.h>
#include <ctype.h>
 
int main()
{
	int XQURE_TABLE [] = {0,1,4,9,16,25,36,49,64,81};// declaring and initializing 
	int A = 255;// declaring an Initializing A; A =255
	int input; // declaring input 
	while (1) {
		printf("Enter input:\t");
		input = getchar();//getting number
		input-='0';// it only takes the first int digit
		while (getchar() != '\n');// It omits the enter
		if (input >=0 && input <= 9){// checking if the input is and integer between 0 and 9
			A = XQURE_TABLE[input];// Getting the value from the array
			printf("Squared number is : %i\n",A);// print value if it found
		}//Enf if statement
		else{
			printf("Error, try again..\n");// printing error if it is not in there
		}// End else statement	
	}//End of while loop
  return 0;
}// End main function
