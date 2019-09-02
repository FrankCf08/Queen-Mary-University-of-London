#include<stdio.h>
#include<stdlib.h>
typedef struct list_elements {
	int value;
	struct list_elements *next;
}item;
void main() {
	item *current, *head;
	int i;
	head = NULL;
	for (i=1; i<=10; i++) {
		current = (item*) malloc(sizeof(item));
		current->value = i;
		current->next = head;
		head = current;
	}
	current = head;
	while (current) {
		printf("%d\n", current->value);
		current = current->next;
	}
}
