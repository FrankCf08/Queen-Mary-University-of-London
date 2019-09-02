#include <stdio.h>
#include <math.h>
int main() {
	double x = 2.25;
	double less = 0.0;
	double more = 0.0;
	double root = 0.0;
	less = floor(x);
	more = ceil(x);
	root = sqrt(x);
	printf("\nFor value %.2f:\n floor = %.2f; ceil = %.2f; sqrt = %.2f\n", x, less, more, root);
	return 0;
}
