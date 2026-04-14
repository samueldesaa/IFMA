public class Main {

    public static void main(String[] args) {

        Pedido pedido = new Pedido();

        // Estado inicial: PROCESSANDO
        pedido.alterar();   // permitido
        pedido.enviar();    // muda para ENVIADO

        // Agora o estado é ENVIADO
        try {
            pedido.alterar(); // lança exceção
        } catch (IllegalStateException e) {
            System.out.println(e.getMessage());
        }

        try {
            pedido.cancelar(); // lança exceção
        } catch (IllegalStateException e) {
            System.out.println(e.getMessage());
        }
    }
}
