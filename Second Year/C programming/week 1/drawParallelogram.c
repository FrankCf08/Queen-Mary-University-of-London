/**************************************************************
	Author: Frank Cruz Felix
	Week:1
	Excersise: 4
	Topic: drawParallelogram
	Date : 28/09/2017
***************************************************************/

#include <stdio.h>

void drawParallelogram(char x,char y);// declaring the fucntion drawParallelogram

int main(){
	char s = '*';// declaring and initializing char s
	char sp = ' ';// declaring and initializing char sp
	drawParallelogram(s,sp);//Calling the function drawParallelogram
	return 0;
}//End main
void drawParallelogram(char x, char y){
	int triangleSide = 5;// declaring and initializing triangleSide
	int squareSide = triangleSide-1; // declaring and initializing squareSide
	int i,j,z,w,u,t;// declaring integer to use
	for(i=0;i<triangleSide;i++){
		for(j=0;j<i;j++){
			printf("%c",x);// printing out "j" number of starts 
		}// End "j" for loop
		printf("\n");//Going to the next line
	}// End "i" for loop
	for(j=0;j<squareSide;j++){
		for(z=0;z<4;z++){
			printf("%c",x);	// printing out "z" number of starts 	
		}//End "z" for loop
		printf("\n");//Going to the next line
	}//End "j" for loop
	for(z=0;z<4;z++){
		for(w=0;w<z;w++){
			printf("%c",y);// printing out "w" number of spaces 
		}//End "w" for loop
		triangleSide--;// Substracting the side of the triangle
		for(u=0;u<triangleSide;u++){
			printf("%c",x); // printing out "u" number of starts 
		}// End "u" for loop
		printf("\n");//Going to the next line
	}// End "z" for loop
}//End drawParallelogram function
