import java.util.ArrayList;
import java.util.List;

public class Experimento {

    private List<RoboAction> acoes = new ArrayList<>();

    // adiciona sempre no final da sequência
    public void adicionarAcao(RoboAction acao) {
        acoes.add(acao);
    }

    // executa o teste na ordem cadastrada
    public void executarTeste() {
        System.out.println("Iniciando experimento...");
        for (RoboAction acao : acoes) {
            acao.execute();
        }
        System.out.println("Experimento finalizado.");
    }
}
