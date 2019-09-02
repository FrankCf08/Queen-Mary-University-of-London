/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 6
	Excercise: 1
	Topic: Read File
************************************************************************************************/
#include <stdio.h>
#define MAX 80
void readFile();//prototype function

int main(){
	readFile();//calling function readFle
	return 0;
}//End main

void readFile(){

	FILE*fpt,*newfpt;//Declaring FILEs pointer

	int nums;
	char city[MAX];
	fpt = fopen("cities.txt","r");//Opening file "exam.txt" and "r" reads it from it

	if(fpt == NULL){
		printf("File not found\n");
	}//End if statement
	else{
		newfpt = fopen("citiesLessThan100.txt","w");// creates and writes on this file
		fprintf(newfpt,"MILES\tCITIES\n\n");//printing this statement on my file
		do{
			fscanf(fpt,"%i %s\n", &nums, city);// scaning all my values
			if(nums >=100){//comparing if num is greater than 100
				fprintf(newfpt,"%d\t%s\n",nums,city);// printing on my new file
			}//End if statement
		}while(!feof(fpt));//do until statement is reached
		fclose(newfpt);	//closing file newfpt
	}//End else statement
	fclose(fpt);//close file fpt
}//End readFile
