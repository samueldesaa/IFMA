public class EstadoCancelado implements Estado {

    @Override
    public void alterar(Pedido pedido) {
        throw new IllegalStateException(
                "Não é possível realizar alterações pois o pedido foi cancelado"
        );
    }

    @Override
    public void cancelar(Pedido pedido) {
        throw new IllegalStateException("O pedido já foi cancelado");
    }

    @Override
    public void enviar(Pedido pedido) {
        throw new IllegalStateException(
                "Não é possível enviar pois o pedido foi cancelado"
        );
    }
}
