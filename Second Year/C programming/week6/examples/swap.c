#include <stdio.h>
void swapInts(int *p1, int *p2);
int main() {
int a = 50, b = 100;
printf("a is %d, b is %d\n", a, b);
swapInts(&a, &b);
printf("a is %d, b is %d\n", a, b);
return 0;
}
void swapInts(int *p1, int *p2) {
int temp;
temp = *p1;
*p1 = *p2;
*p2 = temp;
}
