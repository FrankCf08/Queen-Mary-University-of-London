public class SportCar extends Vehicle
{
    private double topspeed, fuelconsumption;
    SportCar(double horsepower, double weight, double topspeed){
        super(horsepower,weight,0.5);
        this.topspeed = topspeed;
    }
    void setTopspeed(double tsp){
        topspeed = tsp;
    }
    double getTopspeed(){
        return topspeed;
    }
    double fuelConsumption(){
        return fuelconsumption =(1000+(getWeight()/5))*(getTopspeed()/100)*(getAerodynamics()*getHorsepower()/10000);
    }    
    void details(){
        System.out.println("Sport car : "+ acceleration()+ " mph");
    }
    void printConsumprion(){
        System.out.println("Consumption is : "+ fuelConsumption());
    }
}
