public class EstadoEnviado implements Estado {

    @Override
    public void alterar(Pedido pedido) {
        throw new IllegalStateException(
                "Não é possível realizar alterações pois o pedido já foi enviado"
        );
    }

    @Override
    public void cancelar(Pedido pedido) {
        throw new IllegalStateException(
                "Não é possível cancelar pois o pedido já foi enviado"
        );
    }

    @Override
    public void enviar(Pedido pedido) {
        throw new IllegalStateException("O pedido já foi enviado");
    }
}
