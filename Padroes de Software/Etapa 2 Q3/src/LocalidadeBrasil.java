public class LocalidadeBrasil extends LocalidadeAbstractFactory {

    @Override
    public Data getData() {
        return new DataBrasil();
    }

    @Override
    public Moeda getMoeda(double valor) {
        return new MoedaBrasil(valor);
    }
}
