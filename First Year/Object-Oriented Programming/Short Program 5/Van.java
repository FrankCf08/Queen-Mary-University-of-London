public class Van extends Vehicle
{
    private double carryweight,acc;
    Van(double horsepower, double weight, double carryweight){
        super(horsepower,weight,0.9);
        setCarryweight(carryweight);
    }
    void setCarryweight(double carryweight){
        this.carryweight = carryweight;
    }
    double getCarryweight(){
        return carryweight;
    }
    public double acceleration(){
        return acc = (100/getHorsepower())*(getAerodynamics()/2)*getWeight()/100;
    }
}
