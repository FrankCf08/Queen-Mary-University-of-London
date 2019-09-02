/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 5
	Excercise: 3
	Topic: test_stringDelete
************************************************************************************************/
#include <stdio.h>// Importing standard input/output library
#include <string.h>//Importing string library
#define SIZE 20//Declaring MACROS SIZE, CHECK, INDEX

struct Word{
	char c[SIZE];
	int num;
	char d[SIZE];
};//Declaring my struct Word

static struct Word w;//Declaring my struct static to be in my whole program
int getWordNum();
void stringDelete(int x);//Declaring my prototypes functions

int main(){
	int len;
	len = getWordNum();//Initializing len by getting a value in the function getWordNum
	stringDelete(len);//Calling stringDelete function
	return 0;
}//End main function
int getWordNum(){
	int l;
	printf("\nType the word and press Enter: \t");
	fgets(w.c, sizeof(w.c), stdin);//storing my input value in the array w.c
	l= strlen(w.c);
	printf("Type in the position of the character to be deleted: \t");
	scanf("%i",&w.num);
	return l;
}//End getWordNum
void stringDelete(int x){
	int i;
	strcpy(w.d,w.c);//Copying w.c array into w.d array
	w.num = w.num - 1;
	for(i=0;i<x;i++){
		if(i < w.num){
			w.d[i] = w.d[i];
		}//End if statement
		else{
			w.d[i] = w.d[i+1];
		}//End else statement
	}//End for loop
	printf("Original word = %s" , w.c);
	printf("Modified word = %s\n" , w.d);
}//End stringDelete function



















/*	int i,j;
	w.num = w.num - 1;
	for(i = 0; i< w.num;i++){
		w.d[i] = w.c[i];
	}
	for(j = w.num ;j< x;j++){
		w.d[j] = w.c[j+1];
	}
	printf("Original word = %s" , w.c);
	printf("Modified word = %s\n" , w.d);
}*/
