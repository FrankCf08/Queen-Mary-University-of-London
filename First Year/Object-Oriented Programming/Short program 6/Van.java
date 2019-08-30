public class Van extends Vehicle
{
    private double carryweight;
    Van(double horsepower, double weight, double carryweight){
        super(horsepower,weight,0.9);
        this.carryweight = carryweight;
    }
    void setCarryweight(double carrywght){
        carryweight = carrywght;
    }
    double getCarryweight(){
        return carryweight;
    }
    public double acceleration(){
        return 100/getHorsepower()*(getAerodynamics()/2)*getWeight()/100;
    }
    void details(){
        System.out.println("Van : "+ acceleration()+ " mph");
    }
}
