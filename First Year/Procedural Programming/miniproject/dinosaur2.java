/*********************************************************************************
      Author: Frank Cruz
        Date: 04/10/16
 Description:
             This is a program which asks a question about what \n you believe.
*********************************************************************************/
import java.util.Scanner;
import java.util.Random; /*Import random for our program*/

class dinosaur 
{
 public static void main(String[] param)
  {
    String name = inputString("What is the name of your dinosaur?");
    System.out.println("Happy 0th birthday " + name + " the Brontosaurus. ");
	
	int level = randomlevel();
	System.out.println( name + "'s thirst level is " + level + "/10");
	
	System.exit(0);
    return;    
  }// End main
 
 public static String inputString(String message)
  {
   Scanner scanner = new Scanner (System.in);
   String answer;                                   /*THis method will be used to work as the one making questions*/
   
   System.out.println(message);
   answer = scanner.nextLine();
   return answer;
  } /* ENd String inputString(message)*/
  
 public static int randomlevel()
  {
	final int FINAL = 10;
	Random random = new Random(); // This method will get a random number from 1-10
	int level_found = random.nextInt(FINAL)+1;
	
	return level_found;
  } // End randomlevel
	 
}/*End class dinosaur*/
