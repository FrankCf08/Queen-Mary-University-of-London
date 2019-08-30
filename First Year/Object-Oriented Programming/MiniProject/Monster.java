public class Monster extends Character
{
   public Monster(String name){
       super(name,12,100);//calling super constructor
   }//End constructor Monsters
   double getSpecialattack(){
      return getAttackdamage()*0.015;//returns value after being evaluated
   }//End getSoecialattack
   String skills(){
       return "\n *Defensive Skills\n *Earth Break";
   }//End skills method
   void details(){
       System.out.println("\nMonster Name: " + getName() + "\nAttack Damage: " + getAttackdamage() + "\nHP : " + getHealth() + 
       "\nAttak Damage increased by: " + getSpecialattack() + "%.\nSpecial Skill: " + skills());//prints out stament
   }//End deatils method
}//End class Monster
