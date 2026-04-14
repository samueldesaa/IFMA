class SedanBuilder extends CarBuilder {
    protected void buildChassis(Car car) {
        car.chassis = "Chassi de Sedan";
    }
    protected void installEngine(Car car) {
        car.engine = "Motor 1.6";
    }
    protected void setupFeatures(Car car) {
        car.features = "Ar condicionado e direção elétrica";
    }
}
