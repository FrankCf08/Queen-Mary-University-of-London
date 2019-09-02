/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 3
	Excercise: 1.2
	Topic: Guessing Number_better
	Date: 13/10/17	
************************************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#define MAXNUMBER 10// defining a Max number
void guessNumber();// declaring function guessNumber
void printStatement(int x, int rand);// declaring the function printStatement
void chooseNumber(int random);// declaring the function chooseNumber 
int getNumber();

int main(){
	guessNumber();
	return 0;
}//End main function 

void guessNumber(){
	int i,random;
	random = getNumber();//initializing random integer and calling getNumber function
	chooseNumber(random);//calling chooseNumber Function
}//End guessNumber function 
void chooseNumber(int random){
	int i;// declaring integer i
	printf("\nGuess what number the computer thought of ''between 0 and 10'':\n");
	scanf("%i",&i);//scanning the input
	if(i>=0&&i<=10){
		printStatement(i, random);// calling printStatement function
	}//End if statement
	else{
		printf("Sorry wrong input!!\n");
	}//End else statement
}//End chooseNumber function 
int getNumber(){
	int i,r;
	int num[MAXNUMBER];
	for(i=0;i<MAXNUMBER;i++){
		num[i]= rand()%MAXNUMBER;
	}//End for loop
	r = num[4];
	return r;
}//End getNumber function 
void printStatement(int x, int rand){
	if(x!=rand){
		if(x<rand){
			printf("The correct number is bigger\n");
			chooseNumber(rand);			
		}//End if nested statement
		else{
			printf("The correct number is smaller\n");
			chooseNumber(rand);
		}//End else nested statement
	}//End if statement
	else{
		printf("Well donde!\nThe random number was %i\n",rand);
	}//End else statement
}// End printStatement function
