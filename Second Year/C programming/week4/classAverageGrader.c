/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 5
	Excercise: 1
	Topic: classAverageGrader
************************************************************************************************/
#include <stdio.h>// Importing standard input/output library
#define  SIZE 100
#define NUMSTD 2 // Declaring my MACRO terms 
#define MAXMARKS 3
struct Student{
	char name[SIZE];
	long int idnum;
	float marks[MAXMARKS];
};//my struct Students
static struct Student std[NUMSTD];
void creatingStudent();
void printDetails();// Declaring my prototypes functions

int main(){
	creatingStudent();// calling creatingStudent function
	printDetails();// calling printDetails function
	return 0;
}//End main

void creatingStudent(){
	int i,j;//Declaring my variables to use

	for(i=0;i<NUMSTD;i++){
		printf("\nEnter student %i name: ",i+1);
		scanf("%s", &std[i].name);
		printf("Enter student id number: ");
		scanf("%i",&std[i].idnum);
		for(j=0;j<MAXMARKS;j++){
			printf("Enter mark %i : ",j+1);
			scanf("%f",&std[i].marks[j]);
		}//End foor loop		
	}//End foor loop
}//End creatingStudent function

void printDetails(){
	int i,j;
	float sum =0;
	printf("\nList of Students:\nName\t\tID number\tmark1\tmark2\tmark3\tAverage\n");
	for(i=0;i<NUMSTD;i++){
		printf("%s\t\t%i\t",std[i].name,std[i].idnum);
		for(j=0;j<MAXMARKS;j++){
			sum = sum + std[i].marks[j];
			printf("\t%.2f",std[i].marks[j]);//Printing marks
		}//End for loop
		sum =sum/3;
		printf("\t%0.2f\n",sum);
		sum =0;
	}//End for loop
}//End printDetails Function



















