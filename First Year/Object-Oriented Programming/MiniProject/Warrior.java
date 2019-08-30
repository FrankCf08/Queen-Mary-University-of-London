public class Warrior extends Character
{
   String message;
   public Warrior(String name){
       super(name,30,100);//calling super constructor
   }//End constructor Monsters
   double getSpecialattack(){
       return getAttackdamage()*0.05;//returns value after being evaluated
   }//End getSoecialattack
   String skills(){
       return "\n *Cyclone Slash\n *Slash";
   }//End skills method
   void details(){
       System.out.println("\nWarrior Name: " + getName() + "\nAttack Damage: " + getAttackdamage() + "\nHP : " + getHealth() + 
       "\nAttak Damage increased by: " + getSpecialattack() + "%." + "%.\nSpecial Skill: " + skills());
   }//End details method
}//End class Magician