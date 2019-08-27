import java.util.Scanner;
class studentadtarray
 {
// A simple test method setting student records then printing them out
// Note this would be better broken in to methods. I havent just to help
// make it clearer how the array of Students is being used
	public static void main(String []p)
	 {
		final int HOWMANYSYTUDENTS = 5;
		Student [] students = new Student [HOWMANYSYTUDENTS];
		for(int i = 0; i < HOWMANYSYTUDENTS; i++)
		 {
			String nextname = input("What is the name of the next student?");
			int nextid = inputInt("What is their ID?");
			Student s = createStudent(nextname, nextid);
			System.out.println(StudentToString(s)); // see what we have created
			students[i] = s; //store the new student record in the array
		 }
// now get all the students' marks
		System.out.println();
		System.out.println("Time for their marks");
		for(int j = 0; j < HOWMANYSYTUDENTS; j++)
		 {
			System.out.println("The next student is " + getName(students[j]) + "" + getId(students[j]));
			int mark1 = inputInt("Give me their coursework mark");
			int mark2 = inputInt("Give me their exam mark");
			students[j] = setMarks(students[j], mark1, mark2);
		 }
// print them all out to see what we have got
		System.out.println();
		System.out.println("Printing out all student records");
		for(int k = 0; k < HOWMANYSYTUDENTS; k++)
		 {
			System.out.println(StudentToString(students[k]));
		 }
		System.exit(0);
	}
/* *********************************
Ask for a string with given message
Return the string typed in by the user
*/
	public static String input(String message)
	{
		Scanner scanner = new Scanner(System.in);
		String answer;
		System.out.println(message);
		answer = scanner.nextLine();
		return answer;
	}
	public static int inputInt(String message)
	{
		return Integer.parseInt(input(message));
	}
/* ***************************************************
** Methods defining a Student ADT
** Theses are the only ways we should access a Student
** Get a student record as a formatted string
** Get a student name
** Get a student ID
** Get a student's combined mark
** Create a student record
** Set the marks for a student
**/
// Convert a student record to a printable string
//
	public static String StudentToString (Student s)
	{
		String message = getId(s) + "\t" + getName(s) + "\t" + getMark(s);
		return message;
	}
// Getter methods for Student record type
// Return the name from a student record
//
	public static String getName (Student s)
	{
		return s.name;
	}
// Return the id from a student record
	public static int getId (Student s)
	{
		return s.id;
	}
// Return the total mark from a student record
// This is the only mark accessible
	public static int getMark (Student s)
	{
		return (s.exammark + s.courseworkmark); // WE CHANGED THIS
	}
// To create a student BOTH a name and ID must be set at the same time
// The marks are set to 0 to mean no mark set.
//
	public static Student createStudent (String studentname, int studentid)
	{
		Student s = new Student();
		s.id = studentid;
		s.name = studentname;
		s.courseworkmark = 0;
		s.exammark = 0;
		return s;
	}
// Set the mark of a student by giving exam and coursework mark /50
// returning the updated record
//
	public static Student setMarks (Student s, int smark1, int smark2)
	{
		s.courseworkmark = smark1;
		s.exammark = smark2;
		return s;
	}
} //END class studentrecord
/* *************************************************** */
/* *************************************************** */
/* ***************************************************
Create a new type (a record) called Student that records student data
A student has a name and an ID and two marks.
*/
class Student
{
String name; // The Students full name
int id; // Their unique ID number
int courseworkmark; // their coursework mark /50
int exammark; // their exam mark /50
} // END class Student
