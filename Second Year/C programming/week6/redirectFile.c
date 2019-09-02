/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 6
	Excercise: 3
	Topic: Redirect File
************************************************************************************************/
#include <stdio.h>
#define MAX 80
void readFile();//prototype function

int main(){
	readFile();//calling function readFle
	return 0;
}//End main

void readFile(){

	int nums;
	char city[MAX];

	printf("MILES\tCITIES\n\n");//printing this statement on my file
	do{
		scanf("%i %s", &nums, city);// scaning all my values
		if(nums >=100){//comparing if num is greater than 100
			printf("%d\t%s\n",nums,city);// printing on my new file
		}//End if statement
	}while(getchar() != EOF);//do until statement is reached

}//End readFile




//gcc -Wall -g redirectFile.c -o redirectFile && ./redirectFile < cities.txt > newText.txt
