public class CriadorPedidoInternacional extends CriadorPedido {
    @Override
    public Pedido criarPedido() {
        return new PedidoInternacional();
    }
}
