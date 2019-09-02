/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 3
	Excercise: 3
	Topic: Shapes of Triangle-main
	Date: 13/10/17	
************************************************************************************************/
#include <stdio.h>
#include "shapes.h"// including library from my protopyes functions
char c = '*';//declaring as a global variable c

int main(){
	int size = 5;
	topTriangle(size,c);// calling toptriangle function
	square(size,c);// calling square fucntion
	bottomTriangle(size,c);//Calling bottomTriangle function
	return 0;
}//End main function
