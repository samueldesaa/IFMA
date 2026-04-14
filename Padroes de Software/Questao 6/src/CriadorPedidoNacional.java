public class CriadorPedidoNacional extends CriadorPedido {
    @Override
    public Pedido criarPedido() {
        return new PedidoNacional();
    }
}
