import java.io.*;
import java.util.*;
public class FileClass
{
    public static void main(String args[])throws FileNotFoundException, IOException, ClassNotFoundException {
        File file = new File("capitals.txt");//Creates a file called capitals.text
        ArrayList<Text> texts = new ArrayList<Text>();//Using Generics Arraylits

        int number = Integer.parseInt(args[0]);//Getting the line argument
        Scanner scanner = new Scanner(System.in);
        BufferedReader br = null;//Initialization br as a null
        String line;
        
        try{
            br = new BufferedReader(new FileReader(file));// BufferedReader reads the file called "file" previously
        }catch(FileNotFoundException ex){
            System.out.println("File not found");
            System.exit(0);//Ends the program
        }//End Exception in case it doesn't find the file
        
        try{
            while((line = br.readLine())!= null){
                texts.add(new Text(line));//Using generics we create object Text and pass line to the argument.
                System.out.println(line);//It print the line out
            }
        }catch(IOException ioex){
            System.out.println(ioex.getMessage() + " Error message");
        }//Catch Exception in case Br equals null
        int count = 0;
        System.out.println("\nNumber of have a population of equal to, or larger than " + args[0] + ":\n");
        for(int i = 0; i<texts.size();i++){
            if(texts.get(i).getPopulation()>= number){
                count++;
                System.out.println(texts.get(i).getCountry());//It 
            }
        }//End for loop
        System.out.println(count);//prints out the count of greater than args{0}
    }
}
