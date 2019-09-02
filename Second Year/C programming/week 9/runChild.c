// The fork() is one of the those system calls, which is called once, but returns twice!
// After fork() both the parent and the child are executing the same program.
/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 9
	Excercise: 3
	Topic: fork
************************************************************************************************/
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
void runChild (void){
	printf("\n I am the child! My pid is %d\n",getpid());
}

void error(char *msg)
{
	fprintf(stderr, "%s: %s\n", msg, strerror(errno));
	exit (1);
}

int main(){
	pid_t pid;
	printf("--The beginning of the program--\n");
	pid =fork();
	if(pid == -1) error ("Cannot fork() process");

	if(pid == 0)// child process
		runChild();

	if (pid > 0){// parent process
		sleep(5);// make it delay 5 sec.
		printf("\nParent: I am still alive\nParent PID: %d\nChild PID : %d\n", getpid(),pid);
	}
	return 0;
}
