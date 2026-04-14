public abstract class NumeroDecorator implements Numero {
    private Numero numero;

    public NumeroDecorator(Numero numero) {
        this.numero = numero;
    }

    protected Numero getNumero() {
        return this.numero;
    }
}
