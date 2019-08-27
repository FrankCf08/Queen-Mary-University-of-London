/************************************************************
  Author: Frank Cruz
  Shortprogram: 9
  Description:
		     This program is built up using one or more arrays processed using for loops to display about the films at a cinema.
  Date: 06/12/16
************************************************************/
import java.util.*;

class movie
 {
	public static void main(String[] p)
	 {
		details();
		System.exit(0);
	 }//End main
	public static void details()
	 {
		final int numberofmovies = 5;
		Film [] movie = new Film [numberofmovies];
		
		for(int i = 1; i < numberofmovies; i++)
		 {
			String moviename = inputString("Film for screen " + i + "?"); // This for loop gets the answer from the inputs and stores them in our records m.
			int hour = inputInt("What time does it start?");
			int minute = inputInt("What time does it start? Minutes after the hour. ");
			Film m = createMovie(moviename,hour,minute);
			
			movie [i] = m;
		 }//End for loop part
		for (int j = 1 ; j< numberofmovies ; j++)	// This for loop prints out all the movies entered before
		 {
			print("Sreen " + j + ": " + MovietoString(movie[j]));
		 }//End for loop part

	 }// End details	
	public static String MovietoString( Film m)
	 {
		String message = getMovie(m) + "\t" + getHour(m)+ ":"+ getMinute(m);// This method prints out the values stored in our records Film
		return message;
	 }//End MovieString
	public static String getMovie(Film m)
	 {
		return m.name; // It will return the value entered in the box name from our records.
	 }// End getMovie
	public static int getHour(Film m)
	 {
		return m.hour;// It will return the value entered in the box hour from our records.
	 }// End getHour
	public static int getMinute(Film m)
	 {
		return m.minute;//It will return the value entered in the box minute from our records.
	 }//End getMinute
	public static Film createMovie(String moviename, int hour, int minute)
	 {
		Film m = new Film();
	
		m.name = moviename;	// This method works as our setter method.
		m.hour = hour;
		m.minute = minute;
		
		return m;
	 }//End Film createMovie
	public static void print(String message)
	 {
		System.out.println(message);		/*This method prints out a message come through*/
	 } // End print
	public static int inputInt(String message) 
	 { 						/*This inputInt method will convert the Str enter into an integer.*/
		return Integer.parseInt(inputString(message));
	 }// End inputInt
	public static String inputString(String message)
	
	 {
		Scanner scanner = new Scanner(System.in);
		print(message); 	/*This inputString method will output a question and store the answer as the string answer*/
		String answer = scanner.nextLine();
		return answer;
	 }// End inputString
 }//End class movie

class Film
 {
	String  name;	// This class works as our records for the following program.
	int  hour;
	int minute;

 }//End class Film
