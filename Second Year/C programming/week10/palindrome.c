/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 10
	Excercise: 2
	Topic: Palindrome
************************************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <string.h>
#include <errno.h>//for error
#include <signal.h>//Signal function

int score = 0;

void error(char *msg){
	fprintf(stderr,"%s: %s\n",msg,strerror(errno));
	exit(0);
}
void end_game(int sig){
	printf("\nFinal score: %i\n",score);
	exit(1);
}

int catch_signal(int sig,void(*handler)(int)){
	struct sigaction action;
	action.sa_handler = handler;
	sigemptyset(&action.sa_mask);
	action.sa_flags = 0;
	return sigaction(sig,&action,NULL);
}

void times_up(int sig){
	puts("\nTIME'S UP!");
	raise(SIGINT);
}

void testPalindrome(int len){
	char s[len];
	int i,j;
	printf("Enter a word of length %d:\n",len);
	fflush(stdin);
	gets(s);
	for (i=0,j=len-1;i<j;i++,j--){
		if (s[i]!=s[j]){
			printf("\nNot a Palindrome\n");
			raise(SIGINT);
			break;
		}
		else
			printf("\nPalindrome\n");
		}
}

int main(){
	catch_signal(SIGALRM,times_up);
	catch_signal(SIGALRM,end_game);

	return 0;
}
