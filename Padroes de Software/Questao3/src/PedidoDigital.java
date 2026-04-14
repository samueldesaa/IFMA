class PedidoDigital extends Pedido {

    @Override
    protected void calcularCustos() {
        System.out.println("Calculando custo sem frete (produto digital).");
    }

    @Override
    protected void notificarCliente() {
        System.out.println("Liberando link para download.");
    }
}
