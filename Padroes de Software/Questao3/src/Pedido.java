abstract class Pedido {

    // Template Method
    public final void processarPedido() {
        validar();
        calcularCustos();
        notificarCliente();
    }

    protected void validar() {
        System.out.println("Validando pedido...");
    }

    // Etapa que muda conforme o tipo de pedido
    protected abstract void calcularCustos();

    // Etapa que muda conforme o tipo de pedido
    protected abstract void notificarCliente();
}
