#include <stdio.h>
void swapIntStars(int **p1, int **p2); /* function to swap two
int* pointers */
int main() {
	int array1[] = {0,1,0,0,0}, array2[] = {1,0,0,0,0};
	int i, *a, *b;
	a = array1;
	b = array2;
	for (i=0;i<5;i++)
	 printf("a[%i]=%d, b[%i]=%d\n",i, a[i], i, b[i]);
	swapIntStars(&a, &b);
	printf("Swap\n");
	for (i=0;i<5;i++) 
	 printf("a[%i]=%d, b[%i]=%d\n",i, a[i], i, b[i]);
return 0;
}
void swapIntStars(int **p1, int **p2) {
	int *temp;
	temp = *p1;
	*p1 = *p2;
	*p2 = temp;
}
