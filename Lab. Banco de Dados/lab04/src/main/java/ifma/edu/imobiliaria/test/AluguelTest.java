package ifma.edu.imobiliaria.test;

import ifma.edu.imobiliaria.model.Aluguel;
import ifma.edu.imobiliaria.model.Cliente;
import ifma.edu.imobiliaria.model.Imovel;
import ifma.edu.imobiliaria.repository.AluguelRepository;
import ifma.edu.imobiliaria.repository.ClienteRepository;
import ifma.edu.imobiliaria.repository.ImovelRepository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class AluguelTest {

    private static EntityManagerFactory entityManagerFactory;
    private static EntityManager entityManager;
    private static AluguelRepository aluguelRepository;
    private static ImovelRepository imovelRepository;
    private static ClienteRepository clienteRepository;

    public static void main(String[] args) {
        entityManagerFactory = Persistence.createEntityManagerFactory("imobiliariaPU");
        entityManager = entityManagerFactory.createEntityManager();

        aluguelRepository = new AluguelRepository();
        imovelRepository = new ImovelRepository();
        clienteRepository = new ClienteRepository();

        aluguelRepository.setEntityManager(entityManager);
        imovelRepository.setEntityManager(entityManager);
        clienteRepository.setEntityManager(entityManager);

        testInserirAluguel();
        testAtualizarAluguel();
        testListarTodosAlugueis();
        testListarAlugueisPorCliente();

        entityManager.close();
        entityManagerFactory.close();
    }

    private static void testInserirAluguel() {
        Imovel imovel = imovelRepository.findById(1);
        Cliente cliente = clienteRepository.findById(1);

        if (imovel != null && cliente != null) {
            Aluguel aluguel = new Aluguel();
            aluguel.setImovel(imovel);
            aluguel.setCliente(cliente);
            aluguel.setValorAluguel(new BigDecimal("1500.00"));
            aluguel.setPercentualMulta(new BigDecimal("0.33"));
            aluguel.setDiaVencimento((byte) 5);
            aluguel.setDataInicio(new Date());
            aluguel.setDataFim(new Date());
            aluguel.setAtivo(true);
            aluguel.setObs("Primeira locação do imóvel.");

            aluguelRepository.save(aluguel);
            System.out.println("Aluguel inserido com sucesso!");
        } else {
            System.out.println("Imóvel ou cliente não encontrado.");
        }
    }

    private static void testAtualizarAluguel() {
        Aluguel aluguel = aluguelRepository.findById(1);
        if (aluguel != null) {
            aluguel.setValorAluguel(new BigDecimal("1600.00"));
            aluguelRepository.save(aluguel);
            System.out.println("Aluguel atualizado com sucesso!");
        } else {
            System.out.println("Aluguel não encontrado.");
        }
    }

    private static void testListarTodosAlugueis() {
        List<Aluguel> alugueis = aluguelRepository.findAll();
        if (alugueis != null && !alugueis.isEmpty()) {
            alugueis.forEach(aluguel -> System.out.println(aluguel.toString()));
        } else {
            System.out.println("Nenhum aluguel encontrado.");
        }
    }

    private static void testListarAlugueisPorCliente() {
        List<Aluguel> alugueis = aluguelRepository.findByClienteId(1);
        if (alugueis != null && !alugueis.isEmpty()) {
            alugueis.forEach(aluguel -> System.out.println(aluguel.toString()));
        } else {
            System.out.println("Nenhum aluguel encontrado para o cliente.");
        }
    }
}
