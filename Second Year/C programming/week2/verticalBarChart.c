/**************************************************************
	Author: Frank Cruz Felix
	Week:3
	Excersise: 4
	Topic: verticalBarChart
***************************************************************/

#include <stdio.h> // Importing standard input/output library
#define LIMIT 10 // Defining LIMIT 10
void verticalBarChart(int *number);
void printStarts(int *number);// Declaring prototypes functions verticalBarChart, printStarts

int main(){
	int number[LIMIT];
	verticalBarChart(number);
	printStarts(number);
	return 0;
}//End main function
void verticalBarChart(int *number){
	int i, greatNumber;// declaring int variables i and greatNumber
	for(i=0; i< LIMIT;i++){
		printf("Enter number %i :\t",(i+1) );
		scanf("%i",&number[i]);// Storin g variable in my array number
		if(number[i] < 0){
			printf("Enter only positive numbers, please.\n");
			i--;
		}//End if statement
	}//End for loop
}//End verticalBarChart function
void printStarts(int *number){
	int i,j,k,z,largest;
	char s = '*';
	char sp = ' ';// Declaring and Initializing char variables s, sp, nl
	char nl = '\n';
	largest= number[0];
	for(k=1;k<LIMIT;k++){
		if(largest<number[k]){
			largest = number[k];
		}//End if statement
	}//End for loop
	printf("%c",nl);
	for(i=largest; i>=1;i--){
		for(j=0;j<LIMIT;j++){
			if(i<=number[j]){
				printf(" %c ",s);
			}//End if statement
			else{
				printf(" %c ",sp);		
			}//End else statement
		}//End for loop
		printf("%c",nl);
	}//End for loop
	for(z=0;z<LIMIT;z++){
		printf(" %i ",number[z]);
	}//End for loop
}//End printStarts function
