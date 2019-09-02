/**************************************************************
	Author: Frank Cruz Felix
	Week:1
	Excersise: 1
	Topic: drawsquare
	Date : 28/09/2017
***************************************************************/
#include <stdio.h> // Importing standard input/output library

int main(){
	int i,j;// declaring chars i and j
	printf("\n");
	for(i=0;i< 4;i++){
		printf("\n");//Printing a line after a loop is completed
		for(j=0; j<4;j++){
			printf("*");//Printing character '*' one after the other till loop completed
		}// End "j" for loop
	}// End "i" for loop
	return 0;
}//End main
