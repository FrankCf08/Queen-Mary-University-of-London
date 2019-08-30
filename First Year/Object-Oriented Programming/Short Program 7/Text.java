import java.io.*;
public class Text implements Serializable
{
    private String capital, country;
    private int population;
    public Text(String l){
        String [] linesplit = l.split(" ");// Splits the line after a space (" ")
        capital = linesplit[0];//Stores the first value of index 0 of the array linesplit
        population = Integer.parseInt(linesplit[1]);//Stores the sexcond value of index 1 of the array linesplit
        country = linesplit[2];//Stores the third value of index 2 of the array linesplit
    }
    public void setCapital(String newCapital){
        capital = newCapital;
    }//End setCapital method
    public String getCapital(){
        return capital;
    }//End getCapital method
    public void setPopulation(int newPopulation){
        population = newPopulation;
    }// End setPopulation method
    public int getPopulation(){
        return population;
    }// End getPopulation method
    public void setCountry(String newCountry){
        country = newCountry;
    }//End setCountry method
    public String getCountry(){
        return country;
    }//End getCountry method
    public String toString(){
        return String.format("%s\t%d\t%s", capital, population, country);
    }//printing out format
}//End class Texts
