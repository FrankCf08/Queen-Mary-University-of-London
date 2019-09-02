/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 3
	Excercise: 4
	Topic: Average Grader
	Date: 13/10/17	
************************************************************************************************/
#include <stdio.h>
#define STUDENTS 3
#define MARKS 4

void average(double std_grades[][MARKS]);//declaring average function

int main(){
	double std_grades[STUDENTS][MARKS]={{7.7,6.8,8.6,7.3},{9.6,8.7,8.9,7.9},{7.0,9.0,8.6,8.1}};// declaring and initializing std_grades array
	average(std_grades);// calling average function
	return 0;
}// End main
void average(double std_grades[][MARKS]){
	int i,j;
	float sum =0;//
	for(i=0;i<STUDENTS;i++){
		printf("\nGrades for student %i are : ",(i+1));
		for(j=0;j<MARKS;j++){
			sum = sum + std_grades[i][j];
			printf("%.2f ",std_grades[i][j]);
		}//End "j" for loop
		printf("\nStudent average = %.2f\n", sum/(float)MARKS);//printing marks
		sum =0;
	}//End "i" for loop
}//End avera function
