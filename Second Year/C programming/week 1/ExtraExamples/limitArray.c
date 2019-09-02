#include <stdio.h>
#define LIMIT 10

int main() {
	float marks[LIMIT],	average;
	float sum = 0.0;
	int i=0;
	do {
		printf("Enter the mark of the student or -1 to finish: ");
		scanf("%f", &marks[i]);
		if (marks[i] >= 0){
			sum = sum + marks[i];
		} 
		while (marks[i++] >= 0){
			average = sum/(i-1);
			printf("\nThe average is %.2f\n", average);
		}
	}
return 0;
}
