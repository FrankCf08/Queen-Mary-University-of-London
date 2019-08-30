import java.util.*;

public class TestAccountInterest
{
    public static void main(String [] args){

        Account acc1 = new Account(500);// Account1
        Account acc2 = new Account(100);// Account2

        Scanner scanner = new Scanner(System.in);

        /*Printing out starting balance of both accounts*/
        System.out.println("Account1: " + acc1.getBalance());
        System.out.println("Account2: " + acc2.getBalance());

        /*Requesting Interest for Account 1*/
        String message1 = "\ninsert interest1 in decimals : ";
        System.out.println(message1);
        /*casting input value to a double type*/
        double rate1 = Double.valueOf(scanner.nextLine());
        acc1.setInterest(rate1);
        System.out.println("How long?");
        /*casting input value to a double type*/
        int years1 = Integer.parseInt(scanner.nextLine());
        acc1.computeInterest(years1);
        System.out.println("Balance Account1 : " + acc1.getBalance());
        //int interest1 = (int)acc1.getBalance(); (example to convert int)

        /*Requesting Interest for Account 2*/
        System.out.println("\nInsert interest2 in decimals :");
        /*casting input value to a double type*/
        double rate2 = Double.valueOf(scanner.nextLine());
        acc2.setInterest(rate2);
        System.out.println("How long?");
        int years2 = Integer.parseInt(scanner.nextLine());
        acc2.computeInterest(years2);
        System.out.println("Balance Account2 : " + acc2.getBalance());

    }
}
