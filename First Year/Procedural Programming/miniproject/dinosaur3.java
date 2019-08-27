/*********************************************************************************
      Author: Frank Cruz
        Date: 04/10/16
 Description:
             This is a program which asks a question about what \n you believe.
*********************************************************************************/
import java.util.*; /*Imports java util*/

class dinosaur 
{
 public static void main(String[] param)
  {
	petsdetails();
	System.exit(0);
  }
 public static void petsdetails()
  {
    	String name = inputString("What is the name of your dinosaur?");
	String specie = getSpecie(inputString ("What species is it?:\na)Brontosaurus\nb)Tyranosaurus\nc)Aerosteon"));
    	print("Happy 0th birthday " + name + " the " + specie + ".");
	
	int thirst = randomlevel();
	int hunger = randomlevel();
	String anger = levelanger(name, getanger(thirst, hunger));
	
	print( name + "'s thirst level is " + thirst + "/10 and its hunger level is " + hunger + "/10.");
	print( name + " is looking " + anger);
	
        return;    
  }// End main

 public static String getSpecie(String message)
  {
	String specie;
	
	if (message.equals("A"))	/*This method which let us know the species our pet belongs.*/
	  specie = "Brontosaurus";
	else if (message.equals("B"))
	  specie = "Tyranosaurus";
	else
	  specie = "Aerosteon";
	return specie ;
  } // End getSpecie
 public static int getanger (int thirst,int hunger)
  {
	int level = thirst + hunger; /*This method will add the variables thirst and hunger, and return a value.*/
	return level;
  }// End of get anger
 public static String levelanger(String name, int number)
  {
	String answer;
	if (number <= 8)
	   answer = "Serene. " + name + " looks really happy."; /*This methos will tell us the anger of our pet.*/
	else if (number <= 15)
	   answer = "Grouchi. " + name + " looks quite stressed.";
	else
	   answer = "Dangerous... GET OUT OF THERE NOW!! Your pet is being put down for everyone's safety.";
	return answer;
  }
 public static String inputString(String message)
  {
	Scanner scanner = new Scanner (System.in);
	String answer;                             /*THis method will be used to work as the one making questions*/
   
	print(message);
        answer = scanner.nextLine();
	answer = answer.toUpperCase();
        return answer;
  } /* ENd String inputString(message)*/
 public static int randomlevel()
  {
	final int FINAL = 10;
	Random random = new Random(); // This method will get a random number from 1-10
	int level_found = random.nextInt(FINAL)+1;
	
	return level_found;
  } // End randomlevel
 public static void print(String message)
  {
	System.out.println(message);
  }		 
}/*End class dinosaur*/
