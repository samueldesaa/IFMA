public class TomatoDecorator extends CondimentDecorator {

    public TomatoDecorator(Pizza pizza) {
        super(pizza);
    }

    @Override
    public String getDescription() {
        return decoratedPizza.getDescription() + ", Tomato";
    }

    @Override
    public double cost() {
        return decoratedPizza.cost() + 0.10;
    }
}
