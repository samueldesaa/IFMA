public class CreamCheeseEdgeDecorator extends CondimentDecorator {

    public CreamCheeseEdgeDecorator(Pizza pizza) {
        super(pizza);
    }

    @Override
    public String getDescription() {
        return decoratedPizza.getDescription() + ", CreamCheeseEdge";
    }

    @Override
    public double cost() {
        return decoratedPizza.cost() + 1.20;
    }
}
