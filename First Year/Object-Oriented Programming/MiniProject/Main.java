import java.util.*;
public class Main
{
    public static void main(String[] args){
        Character user;
        Random rand = new Random();// 
        int numberofplayers = Question1();
        boolean END = false;
        for(int i =0; i<numberofplayers;i++){
            String chooseone = Question2();
            END =false;
            while(!END){ // DUring this while loop a specific character will be created according to the choice
                END = true;
                if(chooseone.equals("a")){
                    user = new Warrior(askforString("Warrior Name: "));// it creates a Warrior character 
                    user.details(); //Prints out details of the character
                }//End if nest
                else if(chooseone.equals("b")){
                    user = new Magician(askforString("Magician Name: "));//It creates a Magician character
                    user.details();//Prints out details of the character
                }//End else if Nest
                else if(chooseone.equals("c")){
                    user = new Elf(askforString("Elf Name: "));//It creates an Elf character
                    user.details();//Prints out details of the character
                }
                else{
                    print("WRONG ANSWER");
                    END = false;
                    chooseone = Question2();
                }//End else nest
            }//End while loop
        }//End for loop
        print("\nSOME MONSTERS HAVE APPEARED IN THE BATTLE FIELD... !!");
        for(int j = 0 ; j<rand.nextInt(10);j++ ){
            user = new Monster(listofMonster.arrayMonster());//It creates a random number of Monsters
            user.details();//Prints out details of the character
        }//End for loop
        print("\nThanks for playing!!");// Prints out a message
    }
    public static int Question1(){
        int number = askforInt("How many players? ");
        return number;
    }//End Question1 method
    public static String Question2(){
        String answer = askforString("\nWhich character do you want to be : \na)Warrior\nb)Magician\nc)Elf\nAnswer: ");
        return answer;
    }//EndQuestion2 method
    public static String askforString( String message){
        Scanner  scanner = new Scanner(System.in);
        print(message);
        String answer = scanner.nextLine();// This method stores the answer input by user
        return answer;
    }//End askforString method
    public static int askforInt(String message){
        return Integer.parseInt(askforString(message));// This method converts a String variable into an Integer
    }//End askforInt method
    public static void print(String message){
        System.out.println(message);
    }//End printmethod
    public static class listofMonster{
        public static String arrayMonster(){
            String [] listofmonsters = {"Budge Dragon", "Stone Golem", "Bull Fighter"};//Array monsters
            Random rand = new Random();
            String monster = listofmonsters[rand.nextInt(3)];//It will store a random character from the array listofMonsters
            return monster;//Return the value when it's called
        }//End arrayMonster method
    }//End class ListofMonsters
}//End class Main