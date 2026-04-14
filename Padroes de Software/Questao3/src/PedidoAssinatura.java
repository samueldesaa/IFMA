class PedidoAssinatura extends Pedido {

    @Override
    protected void calcularCustos() {
        System.out.println("Configurando cobranças recorrentes.");
    }

    @Override
    protected void notificarCliente() {
        System.out.println("Enviando aviso sobre início da assinatura e futuras renovações.");
    }
}
