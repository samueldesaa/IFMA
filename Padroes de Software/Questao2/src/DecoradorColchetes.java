public class DecoradorColchetes extends NumeroDecorator {

    public DecoradorColchetes(Numero numero) {
        super(numero);
    }

    @Override
    public void imprimir() {
        System.out.print("[");
        getNumero().imprimir();
        System.out.print("]");
    }
}
