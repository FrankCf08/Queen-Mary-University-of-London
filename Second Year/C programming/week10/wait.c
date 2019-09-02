/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 10
	Excercise: 3
	Topic: wait function
************************************************************************************************/
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

void runChild(void){
	printf("\nI am the child! My pid is %d\n\n",getpid());
}

void error(char *msg){
	fprintf(stderr,"%s: %s\n",msg,strerror(errno));
	exit(1);
}
int main(){
	pid_t pid;
	int pid_status;
	printf("\n--The beggining of the program--\n");

	pid = fork();
	if(pid < 0) error("Can't fork() process");

	if(pid != 0)
		runChild();
		wait(NULL);

	return 0;
}
