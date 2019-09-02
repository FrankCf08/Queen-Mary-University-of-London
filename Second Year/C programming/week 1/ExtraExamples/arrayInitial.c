#include <stdio.h>
int main () {
	int s[10], i;
	for (i=0; i <= 9; i++) {
		s[i] = 2 + (2*i);
	}
	printf("%s%13s\n", "Element", "Value");
	for (i=0; i <= 9; i++) {
		printf("%5d%12d\n", i, s[i]);
	}
	return 0;
}
