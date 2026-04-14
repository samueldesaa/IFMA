public class DecoradorParenteses extends NumeroDecorator {

    public DecoradorParenteses(Numero numero) {
        super(numero);
    }

    @Override
    public void imprimir() {
        System.out.print("(");
        getNumero().imprimir();
        System.out.print(")");
    }
}
