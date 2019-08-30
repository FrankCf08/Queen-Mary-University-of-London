public class Character
{
   private String enterName, message;//declaring String variable
   private double attackDamage, health, agility;//declaring double variables
   public Character(String newName, double newattackDamage, double newHealth){
       this.enterName = newName;//Stores string enterName
       this.attackDamage = newattackDamage;//Stores double number in attackDamage
       this.health = newHealth;//Stores double number in health
   }//End constructor Character
   String getName(){
       return enterName;//Return value enterName when it's called called
   }//End getName method
   void setName(String newName){
       enterName = newName;// Stores a string name in enterName variable
   }//End setName method 
   void setAttackdamage(double newattackDamage){
       attackDamage = newattackDamage;//Stores a double number in attackdamage variable
   }//End setAttackdamage method
   double getAttackdamage(){
       return attackDamage; //returns double value when it's called
   }//End getAttackDamage method
   void setHealth(double newHealth){
       health = newHealth;//Stores a double number in heatlh variable
   }//End setHealth method
   double getHealth(){
       return health;//returns double value when it's called
   }//End getHealth method
   void details(){
       System.out.println(message);
   }//End details method
}//End class Character
