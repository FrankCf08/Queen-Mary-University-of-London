import java.io.*;
import java.util.*;
public class Myfile
{
    public static void main(String args[])throws FileNotFoundException, IOException, ClassNotFoundException {
        File file = new File("capitals.txt");
        ArrayList<Text> texts = new ArrayList<Text>();
        int number = Integer.parseInt(args[0]);
        
        /*listofCapitals(texts);
        
        FileOutputStream fo = new FileOutputStream(file);
        ObjectOutputStream output = new ObjectOutputStream(fo);
        for(Text t: texts){
            output.writeObject(t);
        }
        output.close();
        //fo.close();*/
                 
        FileInputStream fi = new FileInputStream(file);
        ObjectInputStream input = new ObjectInputStream(fi);
        ArrayList<Text> texts2 = new ArrayList<Text>();
        
        try{
            while(true){
                Text t = (Text)input.readObject();
                texts2.add(t);
           }
        }catch(EOFException ex){
            for(Text t : texts2){
                System.out.println(t);
            }
        }
        int count = 0;
        System.out.println("\nNumber of have a population of equal to, or larger than " + args[0] + ":\n");
        for(int i = 0; i<texts.size();i++){
            if(texts2.get(i).getPopulation()>= number){
                count++;
                System.out.println(texts2.get(i).getCountry());
            }
        }
        System.out.println(count);
    }
    /*public static void listofCapitals(ArrayList<Text> texts){
        texts.add(new Text("London", 7500000, "UK"));
        texts.add(new Text("Rome", 2700000, "Italy"));
        texts.add(new Text("Paris", 6000000, "France"));
        texts.add(new Text("Athens", 3800000, "Greece"));
        texts.add(new Text("Budapest", 1700000, "Hungary"));
        texts.add(new Text("Lisbon", 2800000, "Portugal"));
        texts.add(new Text("Madrid", 5600000, "Spain"));
        texts.add(new Text("Oslo", 1300000, "Norway"));
        texts.add(new Text("Copenhagen", 1200000, "Denmark"));
        return;
    }*/
}
