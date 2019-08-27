/**************************************************************
        Author: Frank Cruz 
	Shortprogram: 4 
	Description:
		    This program gives information about paintings
		    in an art gallery for visitors.
	Date: 16/09/16
***************************************************************/
import java.util.*;

class paintings
{
 public static void main(String[] param)
 {
	paintingposition();
	System.exit(0);
 }//End main
 public static void paintingposition()
 {
	Painting p1 = new Painting();
	int question;

	question =  inputInt("What room are you in?");

	p1 = setposition(p1, question);
	p1 = setartist(p1, question);
	p1 = setyear(p1, question);	//This variables work as our setter method
	p1 = settittle(p1, question);
	p1 = setdimension(p1, question);

	System.out.println("The painting " + getposition(p1) + " is by " + getartist(p1) + ". It was painted in " + getyear(p1) + " and is called " + gettittle(p1) + ". It is " + getdimension(p1) + ".");
 }//End paintingposition
 public static Painting setposition(Painting p, int question)
 {
	if (question == 1|| question == 2)
	 {
	   p.position = "ahead of you";
         }//End nested if statement
	else if (question == 3)
         { 
	   p.position = "on the left";
         }//End nested else if statement
	else if (question == 4)
	 {
	   p.position = " on your right";
	 }//End nested else if statement
	return p;
 }//End Painting setposition
 public static Painting setartist (Painting p, int question)
 {
	if (question == 1)
	 {
	   p.artist = "Mary Cassatt";
	 }//End nested if statement
	else if (question == 2)
	 {
	   p.artist = "Rembradt";
	 }//End nested else if statement
	else if (question == 3)
	 {
	   p.artist = "Olga Boznanska";
	 }//End nested else if statement
	else
	 {
	   p.artist = "Claude Monet";
	 }//End nested else statement
	return p;
 }//End Painting setartist
 public static Painting setyear(Painting p, int question)
 {
	if (question == 1)
	 {
	   p.year = 1879;
	 }//End nested if statement
	else if (question == 2)
	 {
	   p.year = 1659;
	 }//End nested else if statement
	else if (question == 3)
	 {
	   p.year = 1894;
	 }//End nested else if statement
	else
	 {
	   p.year = 1872;
	 }//End nested else if statement
	return p;
 }//End Painting setyear
 public static Painting settittle(Painting p, int question)
 {
	if (question == 1)
	 {
	   p.tittle = "Woman with a Pearl Necklace in a Loge";
	 }//End nested if statement
	else if (question == 2)
	 {
	   p.tittle = "Self-Portrait with Beret and Turned-up Collar";
	 }//End nested else if statement
	else if (question == 3)
	 {
	   p.tittle = "Girl with Chrysanthemums";
	 }//End nested else if statement
	else
	 {
	   p.tittle = "Impression, Sunrise";
	 }//End nested else statement
	return p;
 }//End Painting settitle
 public static Painting setdimension(Painting p, int question)
 {
	if (question == 1)
	 {
	  p.dimension = " 81.3 cm by 59.7cm";
	 }//End nested if statement
	else if (question == 2)
	 {
	  p.dimension = "84.5cm by 66.0cm";
	 }//End nested else if statement
	else if (question == 3)
	 {
	  p.dimension = "88.5cm by 59 cm";
	 }//End nested else if statement
	else
	 {
	  p.dimension = "48.0cm by 63.0cm";
	 }//End nested else statement
	return p;
  }
 public static String getposition(Painting p)
 {	
	return p.position;
 }//End getposition
 public static String getartist (Painting p)
 {
	return p.artist;
 }//End getartist
 public static int getyear(Painting p)
 {
	return p.year;
 }//End getyear
 public static String gettittle(Painting p)
 {
	return p.tittle;
 }//End gettitle
 public static String getdimension(Painting p)
 {
	return p.dimension;
 }//End getdimension
 public static int inputInt(String message)
 {
	Scanner scanner = new Scanner(System.in);
	int answer;
	System.out.println(message);
	answer = Integer.parseInt(scanner.nextLine());
	
	if (answer >= 5)
	 {
	   System.out.println("Sorry, I don't know that place. Thank you");
	   System.exit(0);
	 }//End nested if part
	return answer;	
 }//End inputString
}//End class paintings
class Painting
 {
	String position;
	String artist;
	int year; // Thesen are our records
	String tittle;
	String dimension;
 }//End class Painting
