/*********************************************************************************
      Author: Frank Cruz
        Date: 04/10/16
 Description:
             This is a program which asks a question about what \n you believe.
*********************************************************************************/
import java.util.Scanner;
import java.util.Random;

class dinosaur 
{
 public static void main(String[] param)
  {
    String name = dinosaurdetails(); 
    System.exit(0);
  } /*End main*/
 
 public static String dinosaurdetails ()
  {
    String question = inputString("What is the name of your dinosaur?");
    
    System.out.println("Happy 0th birthday " + question + " the Brontosaurus. ");
    return question;    
  }
 
 public static String inputString(String message)
  {
   Scanner scanner = new Scanner (System.in);
   String answer;                                   /*THis method will be used to work as the one making questions*/
   
   System.out.println(message);
   answer = scanner.nextLine();
   return answer;
  } /* ENd String inputString(message)*/
}/*End class dinosaur*/
