/*
  Author: Frank Cruz
  week1: Object-Oriented Programming
*/
public class TestCounter// Main Class
{
    public static void main(String[] args){
    Counter ctr = new Counter(0);

    System.out.println(ctr.getValue());
    ctr.increment();
    System.out.println(ctr.getValue());
    ctr.reset();
    System.out.println(ctr.getValue());
    }
}
