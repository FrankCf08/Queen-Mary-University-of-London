
/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 9
	Excercise: 2
	Topic: Code for new user
************************************************************************************************/#include <stdio.h>
#include <unistd.h>//Neccesary for exec() function
#include <errno.h>//Neccesary for error value used
#include <stdlib.h>// Neccesary for exit()

void error(char *msg)
{
	fprintf(stderr, "%s: %s\n", msg, strerror(errno));
	exit(1);
}
int main(int argc, char *argv[]){
	char *my_env[]={"USER=ECS501U", NULL};//The last item must be NULL
	printf("\n... Before exec: USER = %s\n",getenv("USER"));
	if(execle("changeUser", "changeUser",NULL,my_env) == -1)
		error("Cannot run changeUser");

	return 0;
}
