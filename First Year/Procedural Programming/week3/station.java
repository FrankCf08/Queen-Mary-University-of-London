/************************************************************
  	   Author: Frank Cruz
  Shortprogram :3
   Description:
                This program will tell people the underground 			zone a particular station is in.
		Date: 10/10/16
************************************************************/
import java.util.*;


class station
{
 public static void main(String[] param)	
 {
	details();	
	System.exit(0);
 }//End main
 public static void details()
 {
	getPlace(inputString("What station do you need to know the zone of?"));// This method calls the inputString method which output a question.
 }//End details
 public static void getPlace( String msm)
 {
	if (msm.equals("OXFORD CIRCUS") ||msm.equals( "HYDE PARK") ||msm.equals("GREEN PARK")||msm.equals("VICTORIA STATION")||msm.equals("KNIGHTSBRIDGE"))
	{
	  System.out.println(msm+" is in zone 1.");
	}//End if nested statement
	else if (msm.equals("BRIXTON") ||msm.equals( "FINSBURY PARK") ||msm.equals("STOCKWELL")||msm.equals("MILE END")||msm.equals("KENSINGTON OLYMPIA"))
	{
	  System.out.println(msm+" is in zone 2.");
	}//End else if nested statement
	else if (msm.equals("WEST ACTON")||msm.equals("STRATFORD")||msm.equals("BALHAM")||msm.equals("SEVEN SISTER")||msm.equals("TOOTING BEC"))
	{
	 System.out.println(msm + " is in zone 3.");
	}//End else if nested statement
	else if (msm.equals("GREENFORD")||msm.equals("BOSTON MANOR")||msm.equals("KINGSBURY")||msm.equals("BARKING")||msm.equals("MILL HILL EAST"))
	{
	 System.out.println(msm + " is in zone 4.");
	}//End else if nested statement
	else if (msm.equals("HIGH BARNET")||msm.equals("COCKFOSTERS")||msm.equals("STANMORE")||msm.equals("CHARDWEL HEATH")||msm.equals("CHINGFORD"))
	{
	 System.out.println(msm + " is in zone 5.");
	}//End else if nested statement
	else if (msm.equals("HATCH END")||msm.equals("NORTHWOOD")||msm.equals("MOOR PARK")||msm.equals("UPMINSTER")||msm.equals("ROMFORD"))
	{
	 System.out.println(msm + " is in zone 6.");
	}//End else if nested statement
	else
	{
	 System.out.println("Is " + msm + " a London Undeground Station? Maybe check your spelling.");
	}//End else statement
	return;
 }//End getPlace

 public static String inputString(String message)
 {
		Scanner scanner = new Scanner(System.in);
		String answer;
	
		System.out.println(message);// This method works as our input method getting the answer from the question outputed.
		answer = scanner.nextLine();
		answer = answer.toUpperCase();
		return answer;
 }//End inputString
}//End class station
