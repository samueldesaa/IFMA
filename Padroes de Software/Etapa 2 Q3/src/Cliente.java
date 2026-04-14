public class Cliente {

    private final LocalidadeAbstractFactory factory;

    public Cliente(LocalidadeAbstractFactory factory) {
        this.factory = factory;
    }

    public void executar() {
        Data data = factory.getData();
        Moeda moeda = factory.getMoeda(10.0);

        System.out.println("Dia da semana: " + data);
        System.out.println("Valor monetário: " + moeda);
    }
}
