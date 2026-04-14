public class Main {
    public static void main(String[] args) {

        CriadorPedido criadorNacional = new CriadorPedidoNacional();
        Pedido pedido1 = criadorNacional.criarPedido();
        pedido1.processarPedido();

        CriadorPedido criadorInternacional = new CriadorPedidoInternacional();
        Pedido pedido2 = criadorInternacional.criarPedido();
        pedido2.processarPedido();
    }
}
