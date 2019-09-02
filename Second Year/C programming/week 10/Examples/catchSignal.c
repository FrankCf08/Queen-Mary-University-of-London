#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
void dieclean(int sig)
{
	puts ("Goodbye cruel world....\n");
	exit(1);
}
int catch_signal(int sig, void (*handler)(int))
{
	struct sigaction action;
	action.sa_handler = handler;
	sigemptyset(&action.sa_mask);
	action.sa_flags = 0;
	return sigaction (sig, &action, NULL);
}

int main()
{
	char name[30];
	if (catch_signal(SIGINT, dieclean) == -1)
	{
	fprintf(stderr, "Can't map the handler");
	exit(2);
	}
	printf("Enter your name: ");
	fgets(name, 30, stdin);
	printf("Hello %s\n", name);
	return 0;
}
