public class PedidoNacional extends Pedido {

    @Override
    public double calcularImposto() {
        return 10.0; // exemplo
    }

    @Override
    public double calcularFrete() {
        return 20.0; // exemplo
    }

    @Override
    public void processarPagamento() {
        System.out.println("Pagamento via boleto nacional.");
    }
}
