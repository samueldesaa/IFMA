public class EstadoProcessando implements Estado {

    @Override
    public void alterar(Pedido pedido) {
        // código para alteração do pedido
        System.out.println("Pedido alterado com sucesso");
    }

    @Override
    public void cancelar(Pedido pedido) {
        // código para cancelamento
        pedido.setEstado(new EstadoCancelado());
        System.out.println("Pedido cancelado");
    }

    @Override
    public void enviar(Pedido pedido) {
        // código para envio
        pedido.setEstado(new EstadoEnviado());
        System.out.println("Pedido enviado");
    }
}
