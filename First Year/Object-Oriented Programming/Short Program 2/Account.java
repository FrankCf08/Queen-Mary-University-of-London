public class Account
{
    private double balance, interestRate;
    
    public Account(double initialBalance){
        balance = initialBalance;
    }
    public void deposit(double amount){
        balance += amount;
    }
    public void withdraw(double amount){
        balance -= amount;
    }
    public double getBalance(){
        return balance;
    }
    public void setInterest(double rate){
        interestRate = rate;
    }
    public void reset(){
        balance = 0;
    }
    public void computeInterest(int n){
        balance = balance*Math.pow((1 + interestRate),n/12);
    }
}
