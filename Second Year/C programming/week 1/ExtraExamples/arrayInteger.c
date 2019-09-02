#include <stdlib.h>
#include <stdio.h>
#define MAXVALUE 20
#define NUMVALUES 10

int main() {
	int a[NUMVALUES];
	int i,j;
	for (i=0; i < NUMVALUES; i++){
		a[i]=rand()%MAXVALUE;
	}
	for (i=0; i < NUMVALUES; i++) {
		for (j=0; j < a[i]; j++)
			printf("*");
		printf(" (%d)\n", a[i]);
	}
return 0;
}
