#include <stdio.h>
int main() {
	char letters[6];
	int index=0;
	printf("\nEnter a word with at most 5 letters:\n");
	while (((letters[index] = getchar()) != '\n') && (index++ < 4));
		letters[index]='\0';
	/* Printing the valid part of the array. */
	for (index=0; letters[index] != '\0'; index++)
	printf("letters[%d] = %c\n", index, letters[index]);
return 0;
}
