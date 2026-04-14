class SUVBuilder extends CarBuilder {
    protected void buildChassis(Car car) {
        car.chassis = "Chassi de SUV";
    }
    protected void installEngine(Car car) {
        car.engine = "Motor 2.0 Turbo";
    }
    protected void setupFeatures(Car car) {
        car.features = "Tração 4x4 e suspensão elevada";
    }
}
