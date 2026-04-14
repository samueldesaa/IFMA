public class OreganoDecorator extends CondimentDecorator {

    public OreganoDecorator(Pizza pizza) {
        super(pizza);
    }

    @Override
    public String getDescription() {
        return decoratedPizza.getDescription() + ", Oregano";
    }

    @Override
    public double cost() {
        return decoratedPizza.cost() + 0.50;
    }
}
