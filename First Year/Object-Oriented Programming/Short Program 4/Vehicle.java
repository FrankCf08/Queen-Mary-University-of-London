public class Vehicle
{
    private double horsepower, aerodynamics, weight;
    Vehicle(double horsepower, double weight, double aerodynamics){
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
}
