public class Main {
    public static void main(String[] args) {

        CarBuilder sedan = new SedanBuilder();
        CarBuilder suv = new SUVBuilder();
        CarBuilder sport = new SportsCarBuilder();

        System.out.println(sedan.buildCar());
        System.out.println(suv.buildCar());
        System.out.println(sport.buildCar());
    }
}
