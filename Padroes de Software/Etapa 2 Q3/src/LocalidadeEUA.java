public class LocalidadeEUA extends LocalidadeAbstractFactory {

    @Override
    public Data getData() {
        return new DataEUA();
    }

    @Override
    public Moeda getMoeda(double valor) {
        return new MoedaEUA(valor);
    }
}
