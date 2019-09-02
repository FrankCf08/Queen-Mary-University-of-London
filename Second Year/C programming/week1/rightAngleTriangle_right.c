/**************************************************************
	Author: Frank Cruz Felix
	Week:1
	Excersise: 3
	Topic: Right angle triangle_ Right
	Date : 28/09/2017
***************************************************************/

#include <stdio.h> // Importing standard input/output library

void drawTriangle(char x, char y);// declaring the function used

int main(){ // declaring function main
	char s = '*';// declaring and initializing char s
	char sp = ' ';// declaring and initializing char sp
	drawTriangle(s,sp);// calling for function drawtriangle
	return 0;
}//End main

void drawTriangle(char x, char y){
	int i,j,z;// declaring integers i,j,z
	int k=5; // declaring and initializing integer k
	for(i=0;i<4;i++){
		printf("\n");// going to the next line
		for(j=0;j<i;j++){
			printf("%c",y);//printing some space 
		}// End "j" for loop
		k--;// substacting the number of start to use
		for(z=0;z<k;z++){
			printf("%c",x);// printing out the number of starts in the row
		}// End "z" for loop
	}// End "i" for loop
}// End drawTriangle
