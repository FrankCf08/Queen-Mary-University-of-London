/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 3
	Excercise: 1.1
	Topic: Guessing NUmber
	Date: 13/10/17	
************************************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define MAXNUMBER 10
void guessNumber();//declaring the function guessNumberl
void printStatement(int x, int rand);//declaring the funcion printStatement

int main(){
        //srand(time(NULL)); 
       	guessNumber();//Calling function guessNumber
	return 0;
}//End main

void guessNumber(){
	int i,random;
	random = rand()%MAXNUMBER;//Generating a random number
	printf("Guess what number the computer thought of ''between 0 and 10'':\n");
	scanf("%i",&i);//Scanning the number input 
	if(i>=0&&i<=10){
		printStatement(i, random);
	}//End If statement
	else{
		printf("Sorry wrong input!!\n");
	}//End ese statement
}//End guessNumber Function
void printStatement(int x, int rand){
	if(x!=rand){
		printf("Wrong guess, better luck next time\n!");
	}//End If statement
	else{
		printf("Well done!!\n");
	}//End else statement
}//End printStatement Function
