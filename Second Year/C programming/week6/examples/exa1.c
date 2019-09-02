#include <stdio.h>
#include <stdlib.h>
int main(){
	int *newPtr;
	newPtr = (int*) malloc(1000*sizeof(int));
	if (newPtr != NULL) {
		printf("It worked! Can do stuff with newPtr\n");
	}
	else {
		printf("Allocation failed. :-(\n");
	}
	return 0;
}
