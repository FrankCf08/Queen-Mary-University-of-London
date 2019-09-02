/**************************************************************
	Author: Frank Cruz Felix
	Week:1
	Excersise: 3
	Topic: Right angle triangle_ Right
	Date : 28/09/2017
***************************************************************/

#include <stdio.h> // Importing standard input/output library

void drawTriangle(char, char);// declaring the function used

int main(){ // declaring function main
	char a = '*'; 
	char sp = ' ';
	drawTriangle(a,sp);// calling for function drawtriangle
	return 0;
}//End main

void drawTriangle(char x, char y){
	int i,j,z;// declaring integers i,j,z
	int k=5; // declaring and initializing integer k
	for(i=0;i<6;i++){
		for(j=0;j<k;j++){
			printf("%c",y);// printing out char y
		}//End "j" for loop
		k--;
		for(z=0;z<i;z++){
			printf("%c",x);// printing out char x
		}//End "z" for loop
		printf("\n");// going to the next line
	}// End "i" for loop
}// End drawTriangle
