#include <stdio.h>
#include <stdlib.h>
int main(){
	#include<assert.h>
	int *newPtr;
	newPtr = (int*) malloc(1000*sizeof(int));
	assert(newPtr != NULL);
	/* If we got to here, then it worked! */
}
