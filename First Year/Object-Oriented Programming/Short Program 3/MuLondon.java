import java.util.*;
public class MuLondon
{
    public static void main(String args[]){
        Scanner scanner = new Scanner(System.in);
        String [] player = new String[3];
        String message = "Enter the name for player ";
        for (int i=0; i<player.length; i++){
            System.out.println(message + (i+1));
            player[i] = scanner.nextLine();
        }
    }
}
