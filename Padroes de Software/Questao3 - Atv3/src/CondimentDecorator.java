public abstract class CondimentDecorator extends Pizza {
    protected Pizza decoratedPizza;

    public CondimentDecorator(Pizza pizza) {
        this.decoratedPizza = pizza;
    }

    public abstract String getDescription();
}
