/**************************************************************
	Author: Frank Cruz Felix
	Week:3
	Excersise: 3
	Topic: palindromeChecher
***************************************************************/

#include <stdio.h> // Importing standard input/output library
#define LIMIT 5 // Setting define Limit int
void palindromeWord();

int main(){
	palindromeWord();// calling palindromeWord function
	return 0;
}//End main
void palindromeWord(){
	char c [LIMIT];// 
	int j; // declaring variables char c, int j and char d
	char d;
	printf("Enter word:\n");
	d = getchar();// getting the workd
	if((d==EOF) || (d==' ') || (d == '\n')){
		printf("That's not a word\n");	
	}//end if statement
	else{
		c[0] = d;
		for(j=1;j<5;j++){
			c[j]= getchar();
		}//end for
		if((c[0] == c[4])&& (c[1] == c[3])){
			printf("It's palindrome\n");
		}//end nested if
		else{
			printf("It's NOT palindrome\n");
		}//end nested else
	}//end else
}//End palindromeWord
