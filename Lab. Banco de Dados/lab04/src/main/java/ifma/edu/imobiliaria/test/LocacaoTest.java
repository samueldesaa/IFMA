package ifma.edu.imobiliaria.test;

import ifma.edu.imobiliaria.model.Locacao;
import ifma.edu.imobiliaria.model.Imovel;
import ifma.edu.imobiliaria.model.Cliente;
import ifma.edu.imobiliaria.repository.LocacaoRepository;
import ifma.edu.imobiliaria.repository.ImovelRepository;
import ifma.edu.imobiliaria.repository.ClienteRepository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;

public class LocacaoTest {

    private static EntityManagerFactory entityManagerFactory;
    private static EntityManager entityManager;
    private static LocacaoRepository locacaoRepository;
    private static ImovelRepository imovelRepository;
    private static ClienteRepository clienteRepository;

    public static void main(String[] args) {
        entityManagerFactory = Persistence.createEntityManagerFactory("imobiliariaPU");
        entityManager = entityManagerFactory.createEntityManager();

        locacaoRepository = new LocacaoRepository();
        imovelRepository = new ImovelRepository();
        clienteRepository = new ClienteRepository();

        locacaoRepository.setEntityManager(entityManager);
        imovelRepository.setEntityManager(entityManager);
        clienteRepository.setEntityManager(entityManager);

        testInserirLocacao();
        testAtualizarLocacao();
        testListarLocacoesPorCliente();

        entityManager.close();
        entityManagerFactory.close();
    }

    private static void testInserirLocacao() {
        entityManager.getTransaction().begin();

        Imovel imovel = imovelRepository.findById(1);
        Cliente cliente = clienteRepository.findById(1);

        if (imovel != null && imovel.getValorAluguelSugerido() != null) {
            Locacao locacao = new Locacao();
            locacao.setImovel(imovel);
            locacao.setCliente(cliente);
            locacao.setDataInicio(new java.util.Date());
            locacao.setDataFim(new java.util.Date());
            locacao.setAtivo(true);
            locacaoRepository.save(locacao);
            entityManager.getTransaction().commit();
            System.out.println("Locação inserida com sucesso!");
        } else {
            System.out.println("Imóvel não está disponível para locação.");
            entityManager.getTransaction().rollback();
        }
    }

    private static void testAtualizarLocacao() {
        entityManager.getTransaction().begin();
        Locacao locacao = locacaoRepository.findById(1);
        if (locacao != null) {
            locacao.setDataFim(new java.util.Date());
            locacaoRepository.save(locacao);
            entityManager.getTransaction().commit();
            System.out.println("Locação atualizada com sucesso!");
        } else {
            System.out.println("Locação não encontrada.");
            entityManager.getTransaction().rollback();
        }
    }

    private static void testListarLocacoesPorCliente() {
        List<Locacao> locacoes = locacaoRepository.findByClienteId(1);
        if (locacoes != null && !locacoes.isEmpty()) {
            locacoes.forEach(locacao -> System.out.println(locacao.toString()));
        } else {
            System.out.println("Nenhuma locação encontrada para o cliente.");
        }
    }
}
