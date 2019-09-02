/**************************************************************
	Author: Frank Cruz Felix
	Week:1
	Excersise: 2
	Topic: Right angle triangle_left
	Date : 28/09/2017
***************************************************************/

#include <stdio.h> // Importing standard input/output library

void drawTriangle(char x);// declaring the method used

int main(){ // declaring function main
	char a = '*'; 
	drawTriangle(a);// calling for function drawtriangle
	return 0;
}//End main

void drawTriangle(char x){
	int i,j;// declaring integer variables i,j
	for(i=0;i<5;i++){
		for(j=0;j<i;j++){
			printf("%c",x);// printing out char x	
		}// End "j" for loop
		printf("\n");// going to the next line
	}// End "i" for loop
}//End main
