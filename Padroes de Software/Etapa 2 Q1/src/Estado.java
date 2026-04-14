public interface Estado {

    void alterar(Pedido pedido);

    void cancelar(Pedido pedido);

    void enviar(Pedido pedido);
}
