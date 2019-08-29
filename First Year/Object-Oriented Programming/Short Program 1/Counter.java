
public class Counter
{
   private int count;

   public Counter(int initialCount){
       count = initialCount;
   }//Initialise counter
   public Counter(){
       count = 0;
   }//initialise counter with value 0
   public void increment(){
       count += 2;
   }//Increment counter
   public void reset(){
       count = 0;
   }//reset counter to 0
   public int getValue(){
       return count;
   }//return value
}
