public class Elf extends Character
{
   private double defensiveSkill;
   public Elf(String name){
       super(name,25,150);//calling super constructor
   }//End constructor Monsters
   double getSpecialattack(){
       return getHealth()*0.05;//returns value after being evaluated
   }//End getSoecialattack
   String skills(){
       return "\n *Ice Arrow\n *Greater Defense";
   }//End skills method
   void details(){
       System.out.println("\nElf Name: " + getName() + "\nAttack Damage: " + getAttackdamage() + "\nHP : " + getHealth() + 
       "\nHealth increased by: " + getSpecialattack() + "%." + "%.\nSpecial Skill: " + skills());
   }//End details method
}//End class Magician
