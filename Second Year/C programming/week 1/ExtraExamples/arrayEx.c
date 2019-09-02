#include <stdio.h>
int main() {
	char letters[5];
	int index;
	printf("\nEnter a word with 5 letters:\n");
	for (index=0; index < 5; index++) {
		letters[index] = getchar();
	}
/* Printing all the elements of the array. */
	printf("\nArray elements:\n");
	for (index=0; index < 5; index++) {
		printf("letters[%d] = %c\n", index, letters[index]);
	}
	return 0;
}
