abstract class CarBuilder {

    public final Car buildCar() {
        Car car = new Car();
        buildChassis(car);
        installEngine(car);
        setupFeatures(car);
        return car;
    }

    protected abstract void buildChassis(Car car);
    protected abstract void installEngine(Car car);
    protected abstract void setupFeatures(Car car);
}
