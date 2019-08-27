/*******************************************************
	Author: Frank Cruz
	Shortprogram: 2
	Description:
		This program works as a "fitness" age
         	showing you whether you are fitter than
         	your actual age or not.
	Date: 04/10/16
//*****************************************************/

import java.util.Scanner; // Need to make scanner available

class fitness
{
 public static void main (String[] param)
 {
   addyourfitness();   // This method will add the 2 fitness
   System.exit(0);     // and devide them by two.
 } // End main

 public static void addyourfitness()
 {
   int fit1;  
   int fit2;  // THey will store data about their fitness score
   int averagefit;
   int pcfit;
   int age;
   int yearsaway;

   fit1 = askfit1();
   fit2 = askfit2();
   averagefit = (fit1 + fit2)/2;
   pcfit = (averagefit*8)/5 + 10; // It will tell you, your PC Fit age
    
   System.out.println("Your average fitness is " + averagefit);
   System.out.println("Your PC Fit age is " + pcfit + " years old");

   age = askage();
   yearsaway = age - pcfit;
   
   System.out.println("You are " + yearsaway + " years away from your PC Fit age.");
 }//END addyourfitness
 public static int askfit1()
 {
   int ask1;
   Scanner scanner =  new Scanner(System.in);
                                                   // It will ask for your 1st score
   System.out.println("Score for fitness test1?");
   ask1 = Integer.parseInt(scanner.nextLine());
   return ask1;
 } // End askfit1
 public static int askfit2()
  {
   int ask2;
   Scanner scanner =  new Scanner(System.in);
                                                 // It will ask for your second score
   System.out.println("Score for fitness test2?");
   ask2 = Integer.parseInt(scanner.nextLine());
   return ask2;
  } // End askfit2
 public static int askage()
 {
   int age;
   Scanner scanner =  new Scanner(System.in);
                                                 // will ask for your actual age
   System.out.println("What is your actual age?");
   age = Integer.parseInt(scanner.nextLine());
   return age;
 } // End askage
} //End class fitness
