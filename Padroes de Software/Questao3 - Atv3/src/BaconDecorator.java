public class BaconDecorator extends CondimentDecorator {

    public BaconDecorator(Pizza pizza) {
        super(pizza);
    }

    @Override
    public String getDescription() {
        return decoratedPizza.getDescription() + ", Bacon";
    }

    @Override
    public double cost() {
        return decoratedPizza.cost() + 0.80;
    }
}
