/**********************************************************************
             Author: Frank Cruz
	       Date: 18/10/16
	Description:
		     This program is built up using getter and settter
		     methods.
**********************************************************************/
import java.util.*;

class dinosaur
{
  public static void main(String[] p)
   {
	details();
	System.exit(0);
   } // End main
  public static void details()
   {
	Petdetails pet1 = new Petdetails();
	
	pet1 = setName(pet1, inputString("what is the name of your dinosaur?"));
	pet1 = setSpecie(pet1, inputString("What specie is it?\na)Brontosaurus\nb)Tyranosaurus\nc)Aerosteon"));
	pet1 = setThirst(pet1, randomlevel());
	pet1 = setHunger(pet1, randomlevel());
	
	print( "Happy 0 th birthday " + getName(pet1) + " the " + getSpecie(pet1));
	print(getThirst(pet1) + " and " + getHunger(pet1));
   } // End details
  
  public static Petdetails setName(Petdetails pet, String name)
   {
	pet.name = name;
	return pet;
   }
  
  public static String getName(Petdetails pet)
   {
	return pet.name;
   }
  
  public static Petdetails setSpecie(Petdetails pet, String specie)
   {
	if (specie.equals("A"))
	  {
	    specie = "Brontosaurus.";
	  }
	else if (specie.equals("B"))
	  {
	    specie = "Tyranosaurus.";
	  }
	else
	  {
	    specie = "Aerosteon.";
	  }
	pet.specie = specie;
	return pet;
   } // End Petdetails setSpecie

  public static String getSpecie(Petdetails pet)
   {
	return pet.specie;
   } // End getSpecie
  
  public static Petdetails setThirst(Petdetails pet, int number)
   {
	pet.thirst = number;
	return pet;
   }
  public static int getThirst(Petdetails pet)
   {
	return pet.thirst;
   }
  
  public static Petdetails setHunger(Petdetails pet, int number)
   {
	pet.hunger = number;
	return pet;
   }

  public static int getHunger(Petdetails pet)
   {
	return pet.hunger;
   }
  public static int randomlevel()
   {
	final int FINAL = 10;
	Random random = new Random();
	int levelfound = random.nextInt(FINAL) + 1;
	return levelfound;
   }
  
  public static String inputString(String message)
   {
	Scanner scanner = new Scanner(System.in);
	String answer;

	print(message);
	answer = scanner.nextLine();
	answer = answer.toUpperCase();
	return answer;
   } // End of the function inoutString
 
  public static void print(String message)
   {
	System.out.println(message);
   } // End of the procedure print
} // ENd of the class dinosaur
class Petdetails
 {
	String name;
	String specie;
	int thirst;
	int hunger;
 }
