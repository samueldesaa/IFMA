public class PedidoInternacional extends Pedido {

    @Override
    public double calcularImposto() {
        return 35.0; // exemplo
    }

    @Override
    public double calcularFrete() {
        return 120.0; // exemplo
    }

    @Override
    public void processarPagamento() {
        System.out.println("Pagamento via cartão internacional.");
    }
}
