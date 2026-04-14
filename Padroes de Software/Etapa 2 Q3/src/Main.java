public class Main {

    public static void main(String[] args) {

        // Pode vir de args, banco, interface gráfica, etc.
        String localidade = "Brasil"; // ou "EUA"

        LocalidadeAbstractFactory factory =
                Factory.newLocalidade(localidade);

        Cliente cliente = new Cliente(factory);
        cliente.executar();
    }
}
