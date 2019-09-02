/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 5
	Excercise: 4
	Topic: test_stringInsert
************************************************************************************************/
#include <stdio.h>// Importing standard input/output library
#include<string.h>// Importing string library
#define SIZE 50

struct Array{
	char new [SIZE];
};// Creating an struct call Array
static struct Array a;//Making my struct static

void stringInsert(char str[SIZE], char c, int position);// Declaring my prototype function

int main(){
	char a[SIZE];
	char c;//Declaring the array char a, char c and int i
	int p;
	stringInsert(a,c,p);// passing all variables as arguments	
	return 0;
}//End main

void stringInsert(char str[SIZE], char c, int position){
	int i;
	int l;
	printf("Type the word and press Enter:\n");
	fgets(a.new,sizeof(a.new), stdin);
	l= strlen(a.new);//using strlen to get the lenght of thee word input
	printf("Type in the position of the character to be inserted:\n");
	scanf("%i",&position);//getting position
	position = position -1;
	getchar();
	printf("Type in the character to be added:\n");
	scanf("%c",&c);//char to be inserted
	strcpy(str,a.new);
	for(i=l;i>0;i--){
		if(i > position){
			a.new[i] = a.new[i-1];	
		}//End if statement
		else if(i == position){
			a.new[i] = c;		
		}//End else if statement
	}//End for loop function
	printf("Original word = %s" , str);
	printf("Modified word = %s\n" , a.new);	
}//End stringInser function

