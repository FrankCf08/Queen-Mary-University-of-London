#include <stdio.h>
int main() {
	int count = 0;
	printf("\nEnter a sentence:\n");
	while(getchar() != '\n') {
		count ++;
	}
	printf("\nThe number of characters is %d\n", count);
	return 0;
}
