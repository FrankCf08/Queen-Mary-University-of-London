/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 6
	Excercise: 2
	Topic: Create File
************************************************************************************************/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define MAX 30

struct stateValues{
	char name[MAX];
	int account;
	double balance;
};
static struct stateValues values[MAX];

void createFile(FILE *fp);
int options(FILE *fp);
void printList(FILE *fp, int num);
void createList(FILE *fp, int i);
void writeList(FILE *fp, int i);

int main(){
	FILE *fp = NULL;
	createFile(fp);
	return 0;
}//End main

void createFile(FILE *fp){

	char filename[MAX];

	printf("Enter the name of the file to create: \n");
	scanf("%s",filename);// scanning the name of my file

	fp = fopen(filename,"w");//fp , creating a new file for reading and writing

	if(fp == NULL){// if fp is equal to NULL
		printf("\nFile not found\n");//printing only this statement and end of the program
	}//End if statement
	else{
		int num = options(fp);// calling function options
		if((fp = fopen(filename,"r")) == NULL){
			printf("\nSorry, File couldn't be opened for reading");
		}//End if statement
		else{
			printf("The list %s is the following one: \n", filename);
			printList(fp, num);
			fclose(fp);
		}
	}// End else statement
}// End createFile function

int options(FILE *fp){
	int ans,i=0;
	do{
		printf("\nOptions:\n1)Add Customer\n2)Exit\nAnswer:");//printing list options
		scanf("%i", &ans);// scanning value input
		if(ans == 1){// if ans equalas 1
			createList(fp,i);// calling function createList
			i++;// increase counter
		}
		else if(ans == 2){//if ans equals 2 break do/while looop
			break;
		}
		else{
			printf("Wrong input");// otherwise, return to the do statement
		}
	}while(ans!= 2);

	writeList(fp,i);

	return i;//returning the counter
}//End options function
void createList(FILE *fp, int i){
	printf("\nCustomer %i:\nEnter name:\n",i+1);//Asking for the customer name
	while(getchar()!= '\n');// getting the spaces
	fgets(values[i].name,sizeof(values),stdin);// saving values of name in my struct
	printf("Enter acount number :");//asking for account number
	scanf("%i", &values[i].account);//saving values of the acc in my struct
	printf("Enter Balance:  £");// asking for the balance
	scanf("%lf", &values[i].balance);//saving values of balance
}
void writeList(FILE *fp, int i){
	int j;
	for(j=0;j<i;j++){
		fwrite(&values[j],sizeof(values),1,fp);//it'll write all information on my file
	}//End for loop
	fclose(fp);
}//End writeList
void printList(FILE *fp, int num){
	struct stateValues b;
	fread(&b, sizeof(values),1,fp);
	while(!feof(fp)){
		printf("\nName of customer is : %s", b.name);
		printf("Account number is: %i ", b.account);
		printf("\nBalance is: £%.2f \n", b.balance);
		printf("\n");
		fread(&b, sizeof(values),1,fp);
	}
}
