import java.util.*;
public class TestConsumption
{
    public static void main(String [] args){
        SportCar veh1 = new SportCar(200,1500,220);
        SportCar veh2 = new SportCar(100,1000,170);
        SportCar veh3 = new SportCar(135,1100.2,173);
        System.out.println("Fuel Consumption veh1 = "+ veh1.Fuelconsumption());
        System.out.println("Fuel Consumption veh2 = "+ veh2.Fuelconsumption());
        System.out.println("Fuel Consumption veh3 = "+ veh3.Fuelconsumption());
    }
}
