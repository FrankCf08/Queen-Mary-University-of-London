/**********************************************************************
    Author: Frank Cruz
		Work: Miniproject
	       Date: 12/12/16
	  Description:
		     This program is built up using getter and settter
		     methods. It will stimulate bio-engineered dinosaur
		     pets that you must look after.
**********************************************************************/
import java.util.*;

class dinosaur
{
	public static void main(String[] p)
  	{
		details();			//Main method.
		System.exit(0);
  	} //End main
  	
	public static void details()	 
	{
		final int numberofusers = 4;
		final int lowestanger = 0;
		Petdetails [] pet = new Petdetails [numberofusers];
		Petdetails [] temp = new Petdetails [lowestanger +1];

		settermethoddino(pet, numberofusers);	
		changestateofmind(pet, numberofusers);
		sortmethod(temp, pet, numberofusers);
		printSorthigher(pet[numberofusers-1]);
		printSort(pet[lowestanger]);
	}//End details method

	public static void settermethoddino(Petdetails [] pet, int numberofusers)
	 {
		for(int i = 0; i< numberofusers ; i++)
		{
			String user = setUser(i);
			String name = setName();
			String specie = setSpecie();
			int thirst = randomlevel();
			int hunger = randomlevel();   // This for loop works as our stter method.
			int numberanger = thirst + hunger;
			String anger = setAnger(numberanger);
			int irritability = randomlevel();
			Petdetails p = createPet(user,name,specie,thirst,hunger,numberanger,anger,irritability);
			print(printPetdetails(p));
			pet[i] = ressurrectpet(p, numberanger, i);
		}//End for loop
   	 }
	public static void changestateofmind(Petdetails [] pet, int numberofusers)
  	 {
		for(int j = 0; j< numberofusers; j++)
		{
			print("\n" + getUser(pet[j]) + ":");
			String question = inputString("Do you want to change the state of mind of " + getName(pet[j]) + " ? YES or NO?");

			while(!(question.equals("NO")))
			{
				int fed = setFed();
				int sung = setSung(); // This for loop will ask and get values to reduce and change state of mind of the dinosaurs.
				int water = setWater();
				int play = setPlay();

				pet[j] = setNewstatesofmind(pet[j],fed, sung, water,play);
				pet [j] = statesofmind(pet[j]);
				printNewpetdetails(pet[j]);

				question = inputString("\nDo you still want to change the state of mind of " + getName(pet[j]) + " ? YES or NO?");
			}// End while loop
		}// End for loop
  	 }
	public static Petdetails ressurrectpet(Petdetails p, int numberanger1, int i)
	 {
			if(numberanger1>15) // This If statement will be outputed if numberanger is greater than 15, because in that case our pet is dangerous and it's been put down.
			{
				String petback = inputString("Do you want to resurrect your dinosaur?");
				if(petback.equals("YES")||petback.equals("Y"))
			  	{
					numberanger1 = randomlevel3();
					p.numberanger = numberanger1;
				}// End nested if part
				else
			 	{
					print("Sorry but your dinosaur does not longer exist.      :(");
					print("Choose another dinosaur!");
					i=i-1;
			  	}//End nested else part	
			}//End main if part
			else
			{
				p.numberanger = numberanger1;
			}// End main else part
			return p;
	 }//End resurectpet
	public static void sortmethod(Petdetails [] temp, Petdetails [] pet, int numberofusers)
	{
		boolean sorted = false;
		while(!sorted)
		{
			sorted =true;
			for(int k = 0; k < numberofusers-1; k++)
			{
				if(getNumberanger(pet[k]) > getNumberanger(pet[k+1]))// This while loop will swap my array record in ascendent order by an ascendent order of anger level.
				{
					temp [0] = pet[k+1];
					pet[k+1] = pet[k];
					pet[k] = temp [0];
					sorted = false;
				}// End if part
			}//End for loop
		}// End while loop
		return;
	}//End sortmethod
	public static String setUser(int i)
	{
		i=i+1;
		String name = inputString("\nPlayer " + i + ": What is your name?"); // This method works as an input method asking for a name.
		return name;
	}// End setUser
	public static String setName()
	{
		String name = inputString("Give a name to your dinosaur.."); // This method works as an input method asking for a name.
		return name;
  	} //End askname
	public static String setSpecie()
  	{
		String [] giveanswer = {"Brontosaurus." , "Tyranosaurus.", "Aerosteon.", "Velociraptor"};
		String specie = "";
		for (int i = 0; i<giveanswer.length ; i++)
		  {
			int answer = inputInteger("What specie is it?\n1)Brontosaurus\n2)Tyranosaurus\n3)Aerosteon\n4)Velociraptor\nChoice number: ");
			answer = answer - 1;
			if ( answer < 4)
			  {
				specie = giveanswer[answer];	 // This method will return a specie for our dinosaur.
				break;
			  }// End if part
			else
			  {
				print("Sorry, that's not a choice.\n");
			  }// End else part
		  }// End for loop part
		return specie;
  	}   // End askspecie()
	public static String setAnger(int anger)
  	{
		String mood;
		 if(anger<=7)
		  {
			mood = " Serene.";
		  }// End if part
		 else if(anger <= 15)
		  {
			mood = " Grouchi.";		// This if, else method evaluates the level of anger of your pet and returns the mood of it by the String mood. 
		  }// End nested else if part
		 else
		  {
			mood = " Dangerous ... Get out of there now!! . Your pet is being put down for everyone's safety. ";
		  }// End neste else if part
		return mood;
	} // End Petdetails setAnger
	public static String printPetdetails(Petdetails p)
		/*This method print out the message with the details obtained.*/
	{
		String message = getUser(p) + ", your pet was just created and we celebrate it. Happy 0th birthday "+ getName(p)+ " the " + getSpecie(p) + ". " + getName(p)+ "'s thirst level is " + getThirst(p) + "/10, its hunger level is " + getHunger(p) + "/10 and its irritability level is " + getIrritability(p) + "/10. " + getName(p)+ " has a level of anger of " + getNumberanger(p) + "/20 and it is looking" + getAnger(p);
	 	return message;
	}// End printPetdeatils
	public static String getUser(Petdetails p)
	{
		return p.user;// Getter method for USer
	}// End getUser.
	public static String getName(Petdetails p)
	{
		return p.name;// Getter method for Name of the pet
	}// End getName
	public static String getSpecie(Petdetails p)
	{
		return p.specie;// Getter method for Specie
	}// End getSpecie
	public static int getThirst(Petdetails p)
	{
		return p.thirst;// Getter method for Thirst
	}// End getThirst
	public static int getHunger(Petdetails p)
	{
		return p.hunger;// Getter method for Hunger
	}// End getHunger
	public static String getAnger(Petdetails p)
	{
		return p.anger;// Getter method for Anger
	}// End getAnger
	public static int getNumberanger(Petdetails p)
	{
		return p.numberanger;// Getter method for numberanger
	}// End getNumberanger
	public static int getIrritability(Petdetails p)
	{
		return p.irritability;// Getter method for Irritability
	} // End getIrritability
	public static int getFed(Petdetails p)
	{
		return p.fed;// Getter method for Fed
	}// End getFed
	public static int getSung(Petdetails p)
	{
		return p.sung;// Getter method for sung
	}// End getSung
	public static int getWater(Petdetails p)
	{
		return p.water; // Getter method for water
	}// End getWater
	public static int getPlay(Petdetails p)
	{
		return p.play; // Getter method for play
	}// End getPlay
	public static Petdetails createPet(String user, String name, String specie, int thirst, int hunger, int numberanger, String anger,int irritability)
	{
		Petdetails p = new Petdetails();	

		p.user = user;
		p.name = name;
		p.specie = specie;
		p.thirst = thirst;
		p.hunger = hunger;
		p.numberanger = numberanger;
		p.anger = anger;
		p.irritability = irritability;
		p.fed = 0;
		p.sung = 0;
		p.water = 0;
		p.play = 0;

		return p;
	}// End Petdetails createPet
	public static Petdetails setNewstatesofmind(Petdetails p, int fed,int sung, int water, int play)
	{
		p.fed = fed;
		p.sung = sung;	// This method will store the new values for our record.
		p.water = water;
		p.play = play;

		return p;
	}// End Petdetails setNewstatesofmind

	public static void printSorthigher(Petdetails p)
	{
		String message = "\n" + getUser(p)+ " ," + "your dinosaur " + getName(p) + " has the highest anger level " + getNumberanger(p) + "/20, which makes you have the last place in this game.";
		print(message);
		return;
	}// End printSorthigher
	public static void printSort(Petdetails p)
	{
		String message = "\n" + getUser(p)+ " ," + "your dinosaur " + getName(p) + " has the lowest anger level " + getNumberanger(p) + "/20, which makes you become THE WINER OF THE GAME.";
		print(message);
		return;
	}//End printSort
	public static int setFed()
	{
		int number = 0;
		String answer = inputString("Do you want to feed him ? Yes or No.");
		if (answer.equals("YES")||answer.equals("Y"))
		 {				// This method will ask a question and depends on the answer from the user will return 0 or a random number.
			number =  randomlevel2();
		 }
		else
		 {
			number = 0;
		 }
		return number;
	}// End setFed
	public static int setSung()
	{
		int number = 0;
		String answer = inputString("Do you want to sing something to him ? Yes or No.");
		if (answer.equals("YES")||answer.equals("Y"))
		 {				// This method will ask a question and depends on the answer from the user will return 0 or a random number.
			number =  randomlevel2();
		 }
		else
		 {
			number = 0;
		 }
		return number;
	}// End setSung
	public static int setWater()
	{
		int number = 0;
		String answer = inputString("Do you want to give some water to him ? Yes or No.");
		if (answer.equals("YES")||answer.equals("Y"))
		 {				// This method will ask a question and depends on the answer from the user will return 0 or a random number.
			number =  randomlevel2();
		 }
		else
		 {
			number = 0;
		 }
		return number;
	}// End setWater
	public static int setPlay()
	{
		int number = 0;
		String answer = inputString("Do you want to play with him ? Yes or No.");
		if (answer.equals("YES")||answer.equals("Y"))
		 {
			number =  randomlevel2(); // This method will ask a question and depends on the answer from the user will return 0 or a random number.
		 }
		else
		 {
			number = 0;
		 }
		return number;
	}// End setPlay
	public static void printNewpetdetails(Petdetails p)
	 {
		String message = "\nThe new states for " + getName(p)+ " are : Its thirst level is now " + getThirst(p) + "/10, its hunger level is " + getHunger(p) + "/10 and its irritability level is " + getIrritability(p) + "/10. " + getName(p)+ " has a level of anger of " + getNumberanger(p) + "/20 and it is looking" + getAnger(p);
		print(message);// This method prints out the message with the new deatials obtained from our new states.
	 	return;
	 }// End printNewpetdetails 
	public static Petdetails statesofmind(Petdetails p)
	{
		int hunger = getHunger(p) - getFed(p);
		int irritability = getIrritability(p) - getSung(p); // This method will calculate and store the new values for our new states of mind.
		int thirst = getThirst(p) - getWater(p);
		int numberanger = (hunger + thirst) - getPlay(p);

		p.hunger = hunger;
		p.irritability = irritability;
		p.thirst = thirst;
		p.numberanger = numberanger;

		
		return p;	 
	}// End Petdetails statesofmind
	public static int randomlevel3()
	{
		final int FINAL = 8;
		Random random = new Random(); //This method will create a ramdon number 
		int randomnumber = random.nextInt(FINAL)+ 1;
		return randomnumber;
	}// End randomlevel3
	public static int randomlevel2()
	{
		final int FINAL = 3;
		Random random = new Random();   // This method creates a ramdon number.
		int randomnumber = random.nextInt(FINAL)+ 1;
		return randomnumber;
	}// End randomlevel2
	public static int randomlevel()
	{
		final int FINAL = 10;
		Random random = new Random();
		int levelfound = random.nextInt(FINAL) + 1; 	// This method will generate a ramdon number and then return it with the name levelfound.
		return levelfound;
  	}// End randomlevel
  	public static int inputInteger(String message)
  	{
		return Integer.parseInt(inputString(message)); // This method will convert our String message into an integer.
  	} // End inputInteger
	public static String inputString(String message)	 
	{
		Scanner scanner = new Scanner(System.in);
		String answer;
							// THis method gets the input  and save it.
		print(message);
		answer = scanner.nextLine();
		answer = answer.toUpperCase();
		return answer;
  	} // End of the function inoutString
  	public static void print(String message)	 
	{
		System.out.println(message);		// THis method is used as an input to get an answer.
  	} // End of the procedure print

} // ENd of the class dinosaur
class Petdetails
{
	String user;
	String name;
	String specie;
	int thirst;			// This is our records.
	int hunger;
	String anger;
	int numberanger;
	int irritability;
	int fed;
	int sung;
	int water;
	int play;
} //End class Petdetails
