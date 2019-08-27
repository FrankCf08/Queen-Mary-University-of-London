/***************************************************************
	Author: Frank Cruz
	Shortprogram: 1
	Description:
                    This program will print out your initials
            	    using the initials of your first name and
            	    surname.
	Date: 04/10/16
****************************************************************/
class initials
{
	public static void main(String[] param)
	{
		name(); // It has the initial of your name
		space(); // It creates a space between name and surname
		surname(); //  It has the initial of your surname
		System.exit(0); 
	} // End main
	public static void name()
	{
	 String line1;
	 String line2;
	 String line3;
	 
	 line1 = "FFFFF";
	 line2 = "F";
	 line3 = "FFF";
	
	 System.out.println(line1);
	 System.out.println(line2); //It prints our the initial of your name using
	 System.out.println(line3); //the initial of it so.
	 System.out.println(line2);
	 System.out.println(line2);
	 return; 
	}// End of name
	public static void space()
	{
	 String space = "  ";       // It will crete some space between the two
	 System.out.println(space); // words.
	 return;
	} // End space
	public static void surname()
	{
	 String line1 = "CCCCC";
	 String line2 = "C";
	
	 System.out.println(line1);
	 System.out.println(line2); //It prints our the initial of your surname using
	 System.out.println(line2); //the initial of it so.
	 System.out.println(line2);
	 System.out.println(line1);
	 return;
	}// End surname
} //End class initial
