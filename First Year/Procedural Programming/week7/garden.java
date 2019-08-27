/**********************************************************
  Author: Frank E. Cruz Felix
  Shortprogram: 7
  Description:
		This program will be used as part of a garden bird watch conservation project where people watch for birds in their gardens.
  Date: 13/11/16
************************************************************/
import java.util.*;

class garden
 {
	public static void main(String[] p)
	 {
		final int END = 50;
		String [] birds = new String[END];
		int [] howmany = new int[END];
		askquestion(birds, howmany);
		int k =0;	/*This main method contains the 2 arrays used in the prograM. The arrays are used to get values and make it print our final answer called printhowmany. */
		k = gethightest(howmany);
		String thistype = getbird(howmany,birds);
		printhowmany(k, thistype);
		System.exit(0);
	 }// End manin
	public static void printhowmany(int k, String thistype)
	 {
		print("\nYou saw " + k + " " + thistype + "s.");// This print method will output our answer.
		print("It was the most common bird seen at one time in your garden.");
	 }// End printhowmany
	public static void askquestion(String [] birds, int [] howmany)
	 {
		int i = 0;
		birds[i] = inputString("\nWhich bird have you seen?");
		while(!birds[i].equals("END"))	/*This while method will make questions until it get false and makes it break the program whith the use of break.*/
		 {
			
			howmany[i] = inputInt("How many were in your garden at once?");

			i++;
			birds[i] = inputString("\nWhich bird have you seen?");
		 }//End while loop part
		return;
	 }// End askquestion
	public static int gethightest(int [] howmany)
	 {
		int maxValue = howmany[0];
		for (int i = 1; i < howmany.length ; i++)
		 {
			if (howmany[i] > maxValue)
			 {	/*This method will find the hightest value entered and return it as a maxValue*/
				maxValue = howmany[i];
			 }//End nested if statement
		 }//End for loop part
		return maxValue;	
	 }// End gethightest 
	public static String getbird(int[] howmany, String[] birds)
	 {
		int maxValue = howmany[0];
		String birdtype = " ";
		for (int i = 1; i < howmany.length ; i++)
		 {
			if (howmany[i] > maxValue)
			 {	/*This method uses both arrays in order to match it with the gihest value before finding.*/
				maxValue = howmany[i];
				birdtype = birds[i];
			 }//End nested if statement
		 }//End foor loop part
		return birdtype;	
	 }// End getbird
	public static void print(String message)
	 {
		System.out.println(message);/*This method prints out a message come through*/
	 } // End print
	public static int inputInt(String message)
	 { 		/*This inputInt method will convert the Str enter into an integer.*/
		return Integer.parseInt(inputString(message));
	 }// End inputInt
	public static String inputString(String message)
	 {
		Scanner scanner = new Scanner(System.in);
		print(message); /*This inputString method will output a question and store the answer as the string answer*/
		String answer = scanner.nextLine();
		return answer;
	 }// End inputString
 } /*End Main*/
