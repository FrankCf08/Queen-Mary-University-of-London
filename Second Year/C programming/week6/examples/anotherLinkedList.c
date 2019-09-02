// Program to:
// 1. create linked list;
// 2. insert a node at the end of the list;
// 3. display list before and after insertion.
#include <stdio.h>
#include <stdlib.h> // for malloc()

// Template for a node.
struct node {
  int data;           
  struct node *next;  
} *head;

// Function prototypes. 
void createList(int n);
void insertNodeAtEnd(int data);
void displayList();

int main() {
  int num, data;

  // Create linked list with 'num' nodes.
  printf("Enter the total number of nodes: ");
  scanf("%d", &num);
  createList(num);

  printf("\nData in the linked list: \n");
  displayList();

  // Insert node at the end of the linked list.
  printf("\nEnter data to insert at end of the linked list: ");
  scanf("%d", &data);
  insertNodeAtEnd(data);

  printf("\nData in the linked list: \n");
  displayList();

  return 0;
}

// Create a linked list with 'n' nodes.
void createList(int n) {
  struct node *newNode, *temp;
  int data, i;

  head = (struct node *)malloc(sizeof(struct node));
  // Check if unable to allocate memory.
  if (head == NULL) {
    printf("Unable to allocate memory.");
  }
  else {
    // Read data for node from the user.
    printf("Enter the data for node 1: ");
    scanf("%d", &data);

    head->data = data; // assign 'data' value w/ the 'data' field
    head->next = NULL; // assign pointer to NULL

    temp = head;

    // Create the remaining nodes and add them to linked list.
    for (i=2; i<=n; i++) {
      newNode = (struct node *)malloc(sizeof(struct node));

      // Check if memory can be allocated.
      if (newNode == NULL) {
        printf("Unable to allocate memory.");
        break;
      }
      else {
        printf("Enter the data for node %d: ", i);
        scanf("%d", &data);

        newNode->data = data; // assign 'data' value w/ the 'data' field
        newNode->next = NULL; // assign pointer to NULL

        temp->next = newNode; // link to the previous node
        temp = temp->next; 
      }
    }
  }
}

// Create a node and inserts it at end of the linked list.
void insertNodeAtEnd(int data) {
  struct node *newNode, *temp;

  newNode = (struct node*)malloc(sizeof(struct node));
  if (newNode == NULL) {
    printf("Unable to allocate memory.");
  }
  else {
    newNode->data = data;
    newNode->next = NULL; 

    temp = head;

    // Traverse the existing list to the last node.
    while (temp->next != NULL) {
      temp = temp->next;
    }
    temp->next = newNode; // link the pointer
  }
}

// Display the contents of the linked list.
void displayList() {
  struct node *temp;

  // Check if the linked list is empty, i.e. if head is NULL.
  if (head == NULL) {
   printf("List is empty.");
  }
  else {
    temp = head;
    while (temp != NULL) {
      printf("Data = %d\n", temp->data); // display data of current node
      temp = temp->next;                 // move to the next node
    }
  }
}
