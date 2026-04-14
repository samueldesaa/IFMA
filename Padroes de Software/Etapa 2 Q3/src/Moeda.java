public abstract class Moeda {

    protected double valor;

    public Moeda(double valor) {
        this.valor = valor;
    }

    @Override
    public abstract String toString();
}
