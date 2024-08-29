package ifma.edu.transportadora.testes;

import ifma.edu.transportadora.model.*;
import ifma.edu.transportadora.repository.*;
import ifma.edu.transportadora.service.FreteService;

import javax.persistence.EntityManager;
import javax.persistence.Persistence;
import java.util.List;

public class AppTest {
    public static void main(String[] args) {
        // Testar o registro de um frete
        testRegistrarFrete();

        // Testar a busca por frete por ID
        testBuscarFretePorId();

        // Testar listar fretes por cliente
        testListarFretesPorCliente();
    }

    public static void testRegistrarFrete() {
        // Configuração do EntityManager
        EntityManager entityManager = Persistence.createEntityManagerFactory("transportadoraPU").createEntityManager();

        // Criação do repositório e serviço
        FreteRepository freteRepository = new FreteRepository(entityManager);
        FreteService freteService = new FreteService();

        // Criação de um novo frete
        Frete frete = new Frete();
        frete.setIdCliente(1); // Exemplo de ID do cliente
        frete.setIdCidadeOrigem(1); // Exemplo de ID da cidade de origem
        frete.setIdCidadeDestino(2); // Exemplo de ID da cidade de destino
        frete.setIdCategoriaFrete(1); // Exemplo de ID da categoria de frete

        // Registrar o frete
        freteService.registrarFrete(frete);

        System.out.println("Frete registrado: " + frete);
    }

    public static void testBuscarFretePorId() {
        // Configuração do EntityManager
        EntityManager entityManager = Persistence.createEntityManagerFactory("transportadoraPU").createEntityManager();

        // Criação do repositório e serviço
        FreteRepository freteRepository = new FreteRepository(entityManager);
        FreteService freteService = new FreteService();

        // Buscar frete por ID
        Frete frete = freteService.buscarFretePorId(1); // Exemplo de ID
        System.out.println("Frete encontrado: " + frete);
    }

    public static void testListarFretesPorCliente() {
        // Configuração do EntityManager
        EntityManager entityManager = Persistence.createEntityManagerFactory("transportadoraPU").createEntityManager();

        // Criação do repositório e serviço
        FreteRepository freteRepository = new FreteRepository(entityManager);
        FreteService freteService = new FreteService();

        // Listar fretes de um cliente
        List<Frete> fretes = freteService.listarFretesPorCliente(1); // Exemplo de ID do cliente
        System.out.println("Fretes do cliente: ");
        for (Frete f : fretes) {
            System.out.println(f);
        }
    }
}
