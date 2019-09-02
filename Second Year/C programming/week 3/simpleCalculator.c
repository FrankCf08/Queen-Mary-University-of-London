/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 3
	Excercise: 2
	Topic: Simple calculator
	Date: 13/10/17	
************************************************************************************************/
#include <stdio.h> 
#include <stdlib.h>
#define SUM(x,y)(x+y)
#define SUB(x,y)(x-y)
#define MULTX(x,y)(x*y)  //declaring the MACROS to be use in the program
#define DIV(x,y)(x/y)
#define VALUES 2

void getValues();//declaring getValues function

int main(){
	getValues();
	return 0;
}//End main function

void getValues(){
	int i,j;
	char op;
	printf("Enter operation (eg 2+3 , 2*3 , ....) :\t");
	scanf("%i%c%i", &i , &op , &j);
	if(op == '+'){
		printf("The SUM of %d and %d is %d\n", i,j,SUM(i,j));
	}//End if statement
	else if(op == '-'){
		printf("The SUBTRACTION of %d and %d is %d\n", i,j,SUB(i,j));
	}//End else if statement
	else if(op == '*'){
		printf("The MULTIPLICATION of %d and %d is %d\n", i,j,MULTX(i,j));
	}//End else if statement
	else if(op == '/'){
		printf("The DIVISION of %d and %d is %.2f\n", i,j,DIV(i,(float)j));
	}//End else if statement
	else{
		printf("That's a wrong input.\n");
		getValues();// calling the same function - recursion
	}//End if statement
}//End getValues function
