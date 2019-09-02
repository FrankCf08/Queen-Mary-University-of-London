/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 3
	Excercise: 3
	Topic: Shapes of Triangle-shapes
	Date: 13/10/17	
************************************************************************************************/
#include <stdio.h>
#include "shapes.h"
extern char c;

void topTriangle(int size,char y){
	int i,j;
	for(i=0;i<size;i++){
		for(j=0;j<i;j++){
			printf("%c",y);// printing out "j" number of starts 
		}// End "j" for loop
		printf("\n");//Going to the next line
	}// End "i" for loop
}//ENd topTriangle function
void square(int size,char y){
	int j,z;
	for(j=0;j<size;j++){
		for(z=0;z<4;z++){
			printf("%c",y);	// printing out "z" number of starts 	
		}//End "z" for loop
		printf("\n");//Going to the next line
	}//End "j" for loop
}//End square function
void bottomTriangle(int size,char y){
	int z,w,u;
	for(z=0;z<4;z++){
		for(w=0;w<z;w++){
			printf(" ");// printing out "w" number of spaces 
		}//End "w" for loop
		size--;// Substracting the side of the triangle
		for(u=0;u<size;u++){
			printf("%c",y); // printing out "u" number of starts 
		}// End "u" for loop
		printf("\n");//Going to the next line
	}// End "z" for loop
}//ENd bottomTriangle
