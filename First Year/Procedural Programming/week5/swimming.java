/************************************************************
	Author: Frank Cruz
	Shortprogram: 5
   	Description:
		This program will use a for loop to work out
		the total disability point score for a single
		team.
************************************************************/
import java.util.*;

class swimming
{
 public static void main(String[] p)
 {
	int level = getDisability();
	printlegalteam(level);
 }//End main
 public static void printlegalteam(int level)
 {
	print("That team has " + level + " points so is " + booleananswer(level));
 }//End printlegalteam
 public static void print(String message)
 {
	System.out.println(message);
 }//End print
 public static int inputString(String message)
 {
	Scanner scanner = new Scanner(System.in);
	String answer;// This input method will get all numbers entered
	int level; 
	print(message);
	answer = scanner.nextLine();
	level = Integer.parseInt(answer);
	return level;
 }//End inpuString
 public static int getDisability()
 {
	int sum = 0;
	for( int i = 1; i<=4; i++)
	 {//This for loop will work asking sum question upto4 times
	  sum = sum + inputString("What is the disability class of Runner " + i + "?");
	 }//End for loop part
	return sum;
 }//End getDisability
 public static String booleananswer(int level)
 {
	String answer;
	if (level<=32)
	 {
	   answer = "legal.";
	 }//End nested if statement
	else
	 {
	  answer ="NOT legal.";
	 }//End nested else statement
	return answer;
 }//End booleananswer
}//End class swimming

