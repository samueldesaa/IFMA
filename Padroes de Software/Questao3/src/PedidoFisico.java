class PedidoFisico extends Pedido {

    @Override
    protected void calcularCustos() {
        System.out.println("Calculando custos com embalagem e frete...");
    }

    @Override
    protected void notificarCliente() {
        System.out.println("Enviando notificação com informações de envio.");
    }
}
