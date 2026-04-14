public abstract class Pedido {

    public abstract double calcularImposto();
    public abstract double calcularFrete();
    public abstract void processarPagamento();

    public void processarPedido() {
        System.out.println("Imposto: " + calcularImposto());
        System.out.println("Frete: " + calcularFrete());
        processarPagamento();
        System.out.println("Pedido processado!\n");
    }
}
