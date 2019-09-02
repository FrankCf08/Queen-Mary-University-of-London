/* This is the code of changeUser.c */
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
	printf("\n... After exec: USER = %s\n",getenv("USER"));
	return 0;
}
