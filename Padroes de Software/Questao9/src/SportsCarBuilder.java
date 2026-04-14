class SportsCarBuilder extends CarBuilder {
    protected void buildChassis(Car car) {
        car.chassis = "Chassi esportivo reforçado";
    }
    protected void installEngine(Car car) {
        car.engine = "Motor V8";
    }
    protected void setupFeatures(Car car) {
        car.features = "Bancos esportivos e escapamento de alto desempenho";
    }
}
