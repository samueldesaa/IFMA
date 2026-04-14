public class Main {
    public static void main(String[] args) {

        Pedido p1 = new PedidoFisico();
        Pedido p2 = new PedidoDigital();
        Pedido p3 = new PedidoAssinatura();

        System.out.println("=== Pedido Físico ===");
        p1.processarPedido();

        System.out.println("\n=== Pedido Digital ===");
        p2.processarPedido();

        System.out.println("\n=== Pedido Assinatura ===");
        p3.processarPedido();
    }
}
