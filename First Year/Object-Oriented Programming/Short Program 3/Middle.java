import java.util.*;

public class Middle
{
    public static void main(String[] args){
        double[] number = new double[3];
        for(int i = 0; i<args.length;i++){
            if(validarray(args)){
                System.out.println("Error");
                System.exit(0);
            }
            else if(args[i].equals("")){
                System.out.println("Error");
                System.exit(0);
            }
            else{
                number[i] = Double.parseDouble(args[i]);
            }
        }
        sortMiddle.sortArray(number);
        sortMiddle.printString(number);     
    }
    public static boolean validarray(String[] args){
        if(args.length <3){
            return false;
        }
        else{
            return true;
        }
    }
    
    public static class sortMiddle{
        public static void sortArray(double [] Arraymain){
            Arrays.sort(Arraymain);
        }
        public static void printString(double [] Arraymain){
            System.out.println( Arraymain[1] + " is between " + Arraymain[0]+ " and " + Arraymain[2]);
        }
    }
}
