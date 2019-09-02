/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 10
	Excercise: 1
	Topic: Execl function
************************************************************************************************/
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

void runChild(void){
	execlp("ls","ls","-aF", "/", NULL);
}

void error(char *msg){
	fprintf(stderr,"%s: %s\n",msg,strerror(errno));
	exit(1);
}
int main(){
	pid_t pid;
	printf("\n--The begining of the program--\n");

	pid = fork();
	if(pid < 0) error("Can't fork() process");

	if(pid > 0)
		runChild();
		wait(NULL);

	return 0;
}
