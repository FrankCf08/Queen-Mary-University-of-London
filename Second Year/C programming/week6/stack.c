#include <stdio.h>
#include <stdlib.h>

struct stackNode{
	int nodeData;
	struct stackNode *nextPtr;//pointer to the next struct stackNOde
}*head,*tail;//End struc stackNode

void createNode();
void push(int *counter);
void pop(int *counter); //prototypes functions
int isEmpty();
void printStack();

int main(){
	
	createNode();//calling fcuntion createNode
	return 0;
}//End main
void createNode(){

	head = NULL;//setting struct stackNode head to null
	tail = NULL;//setting struct stackNode tail to null

	int counter=1,ans;//declaring and initializing counter and ans
	do{
		printf("What do you want to do?\n1)Push\n2)Pop\n3)Exit\nAnswer:");
		scanf("%d", &ans);//getting value for ans
		if(ans == 1){
			push(&counter);//calling push function
			printStack();
		}//End if statement
		else if(ans == 2){
			pop(&counter);//calling pop function
			printStack();
		}//End else if statement
		else if(ans == 3){
			break;
		}//End else if statement
		else{
			printf("Wrong input, try again..\n");
		}//End else statement
		
	}while(ans != 3);//do at least once until condition is reached

}//End createNode function
void push(int *counter){
	
	struct stackNode *newDataPtr;// declaring struct stackNode pointer
	int data;

	newDataPtr = (struct stackNode*)malloc(sizeof(struct stackNode));//setting up the space to use

	if(newDataPtr != NULL){ //If newData different than NUll
		printf("Enter data for node %i :", *counter);
		scanf("%i", &data);//getting value for data

		newDataPtr-> nodeData = data;//setting int value of data into the struct variable nodeData
		newDataPtr-> nextPtr = NULL;//setting nextPtr to Null otherwise we get errors
		
		if(isEmpty(head)){
			head = newDataPtr;//if head is NULL, head gets the value of newDataPtr
		}//End if nest statement
		else{
			tail -> nextPtr = newDataPtr;//Tail struct nextPointer will point the newDataPtr 
		}//End else statement
		tail = newDataPtr;//Tail struct will point from now on to the newDataPOint to store the value starting from the tail
	}//End if statement
	else{
		printf("Wrong input. Not enought memory");//Print statement
	}//End else statement
	*counter = *counter + 1;

}//End push function
void pop(int *counter){

	int node;

	if(*counter > 1){

		struct stackNode *temp;//creating a temporary struct stackNode temp

		node = head -> nodeData;//int value node willl get the value of head->nodeData
		temp = head;//It will be store in temp
		head = head -> nextPtr; //head will point to the next struct pointer
		if(isEmpty()){
			tail = NULL;//if it empty the head, then NO TAIL
		}
		free(temp);//liberates pointer
		*counter = *counter -1;//reduces by 1 the counter
	}//End if statement
}//End Pop function
int isEmpty(){
	return head == NULL;
}//End isEmpty
void printStack(){
	struct stackNode *temp;
	int i=1;
	if(isEmpty()){
		printf("List empty.\n");
	}//End if statement
	else{
		temp = head;//temp gets all value of struct head
		while(temp != NULL){
			printf("Data %i = %d\n",i, temp -> nodeData);
			temp = temp -> nextPtr;//go to the next POinters
			i++;
		}//print this until it reaches statement
	}//End else statement
}//End printStack function
