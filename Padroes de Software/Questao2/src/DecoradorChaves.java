public class DecoradorChaves extends NumeroDecorator {

    public DecoradorChaves(Numero numero) {
        super(numero);
    }

    @Override
    public void imprimir() {
        System.out.print("{");
        getNumero().imprimir();
        System.out.print("}");
    }
}
