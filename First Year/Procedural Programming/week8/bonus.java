/*************************************************************
  Author: Frank Cruz
  Shortprogram:8
  Description:	
		This programs works out amounts to pay out in a digital media company's bonus scheme. This programm consists of multiple methods. Creating an abstract data type with fields accessed	only by getter and setter methods.
  Date: 06/11/16
************************************************************/
import java.util.*;

class bonus
 {
	public static void main(String[] p)
	 {
		Employee bonus = new Employee();
		int number = 0;
		bonus =  setProfit(bonus, scoreprofit());
		bonus =  setHardwork(bonus, scorehardwork());//This are our setter method
		bonus =  setPerformance(bonus, number);
		
		
		print("Your performance score this year is " + getperformance(bonus) + " out of 10.");
		print("Your bonus is " + amount(bonus) + " pounds.");

		System.exit(0);

	 }//End main
	public static Employee setProfit(Employee data, int profit)
	 {
		data.profitmade = profit;
		return data;
	 }//End setProfit
	public static int scoreprofit()
	 {
		int score = 0;
		score = 2 * inputInt("Profit score ? ");
		return score;
	 }//End scoreprofit
	public static Employee setHardwork(Employee data, int hardworkdone)
	 {
		data.hardwork = hardworkdone;
		return data;
	 }//End setHardwork
	public static int scorehardwork()
	 {
		int score = 0;
		score = 5* inputInt("Hard Work score? ");
		return score;
	 }//End scorehardwork
	public static Employee setPerformance(Employee data, int sum)
	 {
		sum = (data.profitmade + data.hardwork) / 7;
		data.performance = sum;
		return data;
	 }//End Employee setPerformance
	public static int getperformance (Employee data)
	 {
		return data.performance;//Getter method getperformance
	 }//End getperformance
	public static int amount(Employee data)
	 {
		return data.performance*5000;// Getter method getperformance
	 }//End amount
	public static void print(String message) 
	 {
		System.out.println(message);// output message
	 }//End print
	public static String inputString(String message)
	 {
		String answer;
		Scanner scanner =  new Scanner(System.in);
		print(message);// This methods works as an input method
		answer = scanner.nextLine();
		return answer;
	 }//End inputString
	public static int inputInt(String message)
	 {
		return Integer.parseInt(inputString(message));
	 }//End inputInt
 }//End class bonus

class Employee
 {
	int profitmade;
	int hardwork; // This is our records
	int performance;
 }//End class Employee
