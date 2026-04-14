public class Main {

    public static void main(String[] args) {

        Experimento experimento = new Experimento();

        // Comandos (ações encapsuladas)
        RoboAction aquecer = new RoboElevaTemperatura();
        RoboAction quimico = new RoboAplicaProdutoQuimico();
        RoboAction reduzirO2 = new RoboReduzOxigenacao();

        // Montagem da sequência (enfileiramento)
        experimento.adicionarAcao(aquecer);
        experimento.adicionarAcao(quimico);
        experimento.adicionarAcao(reduzirO2);

        // Execução posterior
        experimento.executarTeste();
    }
}
