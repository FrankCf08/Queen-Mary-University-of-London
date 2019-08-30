public class Vehicle
{
    private double horsepower, aerodynamics, weight, acc;
    public Vehicle(double horsepower, double weight,double aerodynamics){
        this.horsepower=horsepower;
        this.weight=weight;
        this.aerodynamics=aerodynamics;
    }
    public void setHorsepower(double hp){
        horsepower = hp;
    }
    public double getHorsepower(){
        return horsepower;
    }
    public void setAerodynamics(double aerody){
        aerodynamics = aerody;
    }
    public double getAerodynamics(){
        return aerodynamics;
    }
    public void setWeight(double wgt){
        weight=wgt;
    }
    public double getWeight(){
        return weight;
    }
    public double acceleration(){
        return acc = (100/getHorsepower())*getAerodynamics()*getWeight()/100;
    }
    public void printAcceleration(){
        System.out.println("Van : "+ acceleration()+ " mph");
    }
}
