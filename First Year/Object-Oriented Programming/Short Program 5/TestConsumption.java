public class TestConsumption
{
    public static void main(String [] args){
        Vehicle acc1 = new SportCar(200,1500,220);
        //SportCar veh1 =(SportCar)acc1;
        System.out.println("Sport car1 : "+ acc1.acceleration()+ " mph");
        //System.out.println("Fuel Consumption veh1 = "+ veh1.Fuelconsumption());
    
        Vehicle acc2 = new SportCar(100,1000,170);
        //SportCar veh2 = (SportCar)acc2;
        System.out.println("\nSport car2 : "+ acc2.acceleration()+ " mph");
        //System.out.println("Fuel Consumption veh2 = "+ veh2.Fuelconsumption());
        
        Vehicle acc3 = new SportCar(135,1100.2,173);
        //SportCar veh3 = (SportCar)acc3;
        System.out.println("\nSport car3 : "+ acc3.acceleration()+ " mph");
        //System.out.println("Fuel Consumption veh3 = "+ veh3.Fuelconsumption());
        
        Vehicle van = new Van(100,3500,160.4);
        System.out.println("\nInstance of Van : "+ van.acceleration()+ " mph"); 
        
    }
}