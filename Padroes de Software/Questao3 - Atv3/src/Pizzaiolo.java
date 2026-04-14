public class Pizzaiolo {

    public static void main(String[] args) {

        // 1) Mozzarella Pizza
        Pizza p1 = new Mozzarella();
        System.out.println(p1.getDescription() + " --- " + p1.cost());

        // 2) Mozzarella + Tomato
        Pizza p2 = new TomatoDecorator(new Mozzarella());
        System.out.println(p2.getDescription() + " --- " + p2.cost());

        // 3) Mozzarella + Tomato + CreamCheeseEdge
        Pizza p3 = new CreamCheeseEdgeDecorator(new TomatoDecorator(new Mozzarella()));
        System.out.println(p3.getDescription() + " --- " + p3.cost());

        // 4) Pepperoni
        Pizza p4 = new Pepperoni();
        System.out.println(p4.getDescription() + " --- " + p4.cost());

        // 5) Pepperoni + Oregano + Bacon
        Pizza p5 = new BaconDecorator(new OreganoDecorator(new Pepperoni()));
        System.out.println(p5.getDescription() + " --- " + p5.cost());

        // 6) Pepperoni + Oregano + Bacon + Tomato
        Pizza p6 = new TomatoDecorator(new BaconDecorator(new OreganoDecorator(new Pepperoni())));
        System.out.println(p6.getDescription() + " --- " + p6.cost());
    }
}
