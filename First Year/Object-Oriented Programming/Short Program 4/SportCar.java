public class SportCar extends Vehicle
{
    private double topspeed;
    SportCar(double horsepower, double weight, double topspeed){
        super(horsepower,weight,0.5);
        setTopspeed(topspeed);
    }
    void setTopspeed(double topspeed){
        this.topspeed = topspeed;
    }
    double getTopspeed(){
        return topspeed;
    }
    double Fuelconsumption(){
        return (1000+(getWeight()/5))*(getTopspeed()/100)*(getAerodynamics()*getHorsepower()/10000);
    }
}
