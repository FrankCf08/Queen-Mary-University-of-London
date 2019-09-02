/**************************************************************
	Author: Frank Cruz Felix
	Week:3
	Excersise: 2
	Topic: count_capLetters
***************************************************************/

#include <stdio.h> // Importing standard input/output library

void readingLinesandSpaces(); // Declaring prototypes functions
void countPrinting(int x, int y, int z);


int main(){
	readingLinesandSpaces();
	return 0 ;
}//End main
void readingLinesandSpaces(){
	char c;// declaring char variable c
	printf("Enter text:\n");
	int x =0,y=0,z=0;// Declaring int variables x, y
	while((c=getchar()) != EOF){
		if(c >= 'A' && c <= 'Z'){
			x++;
		}//End if statement
		else if(c==' '|| c == '\t'){
			y++;
		}//End else if statement
		else if(c=='\n'){
			z++;
		}//End else if statement
	}//End while loop
	countPrinting(x,y,z);
}//End readingLinesandSpaces function
void countPrinting(int x, int y, int z){
	printf("\nNumber of capital letters are = %i\n",x);//Printing statements
	printf("Number of spaces = %i\nNumber of lines = %i\n",y,z);		
}//End countPrinting function
