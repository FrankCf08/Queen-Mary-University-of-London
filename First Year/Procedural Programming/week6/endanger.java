/************************************************************
	Author: Frank Cruz
	Shortprogram: 6
    	Description:
			This program uses an array manipulated in a loop to repeatedly name an animal asking for a number of its specie alive.
	 Date: 08/11/16
************************************************************/
import java.util.*;

class endanger
{
 public static void main (String[] param)
 {
		String [] animals;
		animals = listofanimals();
		int [] number ;			/*This method will call for all the variables mentioned*/
		number = askquestion(animals);
		int count = getlowest(number, animals);
		String savethem = saveanimal(number, animals);
		printmostEndengered(count , savethem);
		printingbothList(number , animals);
		
		System.exit(0);
 } /*End of the main*/
 public static  void printmostEndengered(int count, String savethem)
 {
		print("\nThe most endangered animal is the " + savethem + ".");/*This method will print out the sentences*/
		print("There are only " + count + " left in the world.\n");
 } // End printmostEndengered
 public static void printingbothList(int[] number, String [] animals)
 {
		int i =0;
		while(i < animals.length)
		 {
			print( number[i] + ", " + animals[i]);
			i++;	/*This method prints both array lists with the number input respectively.*/
		 }//End while loop part
 } // End printingbothList
 public static void print(String message)
 {
		System.out.println(message); /*Method working only to print our inputs*/
 }
 public static String inputString(String message)
 {
		Scanner scanner = new Scanner(System.in);
		print(message);  /*This method will get an input and save it as answer*/
		String answer =  scanner.nextLine();
		return answer;
 } // End inputString
 public static int inputInt(String message)
 {			/*This method converts a string answer into an integer*/
		return Integer.parseInt(inputString(message));
 } // End inputInt
 public static String [] listofanimals()
 {
		String [] list = {"Komodo Dragon","Manatee","Kakapo","Florida Panther","White Rhino"};
		return list; /*List of the animals endangered.*/
 }// End listofanimals
 public static int [] askquestion( String [] animals)
 {
		int [] numberslist = new int [5];
		for (int i = 0; i < animals.length ; i++)
		 {				/*This method will output a question and create an array ist using those value*/
			print("\n" + animals[i] + ":");
			numberslist[i] = inputInt("How many are left in the wild? ");
		 }//End for loop part
		return numberslist;
 } // End askquestion
 public static int getlowest(int [] number, String [] animals)
 {
		int numbertracker = Integer.MAX_VALUE;
		int numberposition = -1;
		int k = 0;
		for( int i = 0 ; i < animals.length ; i++)
		 {
			if ( number[k] < numbertracker)
			 {
				numbertracker = number[k];/*This if-then-else construct will look through the list of number and find the lowest value of it.*/
				numberposition = k ;
			 }//End nested if statement
			k++;
		 }//End for loop part
		return numbertracker;
 }// End gethightest
 public static String saveanimal(int [] number, String [] animals)
 {
		int numbertracker = Integer.MAX_VALUE;
		int numberposition = -1;
		int k = 0;
		String saveme = animals[0];
		for( int i = 0 ; i < animals.length ; i++)
		 {
			if ( number[k] < numbertracker)
			 {
				numbertracker = number [k];/*This if-then-else construct will look through the list of number and find the lowest value of it.*/
				numberposition = k ;
				saveme = animals[k];
			 }//End nested if statement
			k++;
		 }//End for loop part
		return saveme;
 }// End gethightest
}// End class endanger
