public class Magician extends Character
{
   public Magician(String name){
       super(name,20,100);//calling super constructor
   }//End constructor Monsters
   double getSpecialattack(){
       return getAttackdamage()*0.025;//returns value after being evaluated
   }//End getSoecialattack
   String skills(){
       return "\n *Fire Ball\n *Lightning\n *Evil Spirits\n *Aquabeam";
   }//End skills method
   void details(){
       System.out.println("\nMagician Name: " + getName() + "\nAttack Damage: " + getAttackdamage() + "\nHP : " + getHealth() + 
       "\nAttak Damage increased by: " + getSpecialattack() + "%.\nSpecial Skill: " + skills());
   }//End details method
}//End class Magician
