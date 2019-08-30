public class Vehicle
{
    private double horsepower, aerodynamics, weight, acc;
    Vehicle(double horsepower, double weight,double aerodynamics){
        setHorsepower(horsepower);
        setWeight(weight);
        setAerodynamics(aerodynamics);
    }
    void setHorsepower(double horsepower){
        this.horsepower = horsepower;
    }
    double getHorsepower(){
        return horsepower;
    }
    void setAerodynamics(double aerodynamics){
        this.aerodynamics = aerodynamics;
    }
    double getAerodynamics(){
        return aerodynamics;
    }
    void setWeight(double weight){
        this.weight=weight;
    }
    double getWeight(){
        return weight;
    }
    public double acceleration(){
        return acc = (100/getHorsepower())*getAerodynamics()*getWeight()/100;
    }

}