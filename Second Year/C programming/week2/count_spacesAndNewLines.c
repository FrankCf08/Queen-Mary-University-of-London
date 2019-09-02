/**************************************************************
	Author: Frank Cruz Felix
	Week:3
	Excersise: 1
	Topic: count_spacesAndNewLines
***************************************************************/

#include <stdio.h> // Importing standard input/output library

void readingLinesandSpaces(); // Declaring prototype functions
void countPrinting(int x, int y);

int main(){
	readingLinesandSpaces();// calling function
	return 0 ;
}//End main
void readingLinesandSpaces(){
	char c;
	int x =0,y =0;
	printf("Enter text:\n");//Getting text
	c = getchar();
	while((c=getchar()) != EOF){
		if(c==' '|| c == '\t'){
			x++;
		}//End if statement
		else if(c=='\n'){
			y++;
		}//End else fi statement
	}//End while statement
	countPrinting(x,y);
}//End readingLinesandSpaces
void countPrinting(int x, int y){
	printf("\nNumber of spaces = %i\nNumber of lines = %i\n",x,y);	
}//End countPrinting

