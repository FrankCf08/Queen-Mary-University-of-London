/************************************************************************************************
	Author: Frank Erasmo Cruz Felix
	Week: 5
	Excercise: 2
	Topic: uniSports
************************************************************************************************/
#include <stdio.h>// Importing standard input/output library
#define MAXCHAR 50
#define ROUNDS 10
#define W 3
#define D 1
struct Results{
	char team1[MAXCHAR];
	int score1;
	char team2[MAXCHAR];
	int score2;
};// Declaring my struct Results
static struct Results result[ROUNDS];//making my struct static to be used in all my program
void readingFile();
void printPoints();//Declaring prototype functions

int main(){
	readingFile();//Calling readinfFile fuction
	printPoints();//Calling printPoints function
	return 0;
}//End main function
void readingFile(){
	int i=0;
	do{
		scanf("%s %d %s %d",result[i].team1,&result[i].score1,result[i].team2,&result[i].score2);
		i++;
	}while((getchar()!= EOF)&&i<ROUNDS);
}//End readingFile fucntion
void printPoints(){
	int hw =0,aw=0,hd=0,ad=0,hl=0,al=0;
	int gf=0,ga=0,pts=0;
	int i=0;

	for(i=0;i<ROUNDS;i++){
		if(result[i].team1[0] == 'Q'){
			if(result[i].score1 > result[i].score2){
				hw++;
			}//End if statement
			else if(result[i].score1 < result[i].score2){
				hl++;
			}//End else if statement
			else{
				hd++;
			}//End else statement
			gf = gf + result[i].score1;
			ga = ga + result[i].score2;
		}//End if statement
		else if(result[i].team2[0] == 'Q'){
			if(result[i].score1 < result[i].score2){
				aw++;
			}//End if statement
			else if(result[i].score1 > result[i].score2){
				al++;
			}//End else if statement
			else{
				ad++;
			}//End else statement
			gf = gf + result[i].score2;
			ga = ga + result[i].score1;
		}//End else if statement
	}//End for loop
	
	pts = W*(hw+aw)+D*(hd+ad);
	printf("\t Home\t\t  Away\n\tW  D  L\t\tW  D  L\t\tGF\tGA\tGD\t\tPTS\n");
	printf("QMUL\t%i  %i  %i\t\t%i  %i  %i\t\t%i\t%i\t%i\t\t%i\n",hw,hd,hl,aw,ad,al,gf,ga,(gf-ga),pts);
}//End printPoints dunction

