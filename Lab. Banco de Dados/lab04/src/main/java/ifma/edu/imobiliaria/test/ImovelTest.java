package ifma.edu.imobiliaria.test;

import ifma.edu.imobiliaria.model.Imovel;
import ifma.edu.imobiliaria.model.TipoImovel;
import ifma.edu.imobiliaria.repository.ImovelRepository;
import ifma.edu.imobiliaria.repository.TipoImovelRepository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.math.BigDecimal;
import java.util.List;

public class ImovelTest {

    private static EntityManagerFactory entityManagerFactory;
    private static EntityManager entityManager;
    private static ImovelRepository imovelRepository;
    private static TipoImovelRepository tipoImovelRepository;

    public static void main(String[] args) {
        entityManagerFactory = Persistence.createEntityManagerFactory("imobiliariaPU");
        entityManager = entityManagerFactory.createEntityManager();
        imovelRepository = new ImovelRepository();
        imovelRepository.setEntityManager(entityManager);
        tipoImovelRepository = new TipoImovelRepository();
        tipoImovelRepository.setEntityManager(entityManager);

        testInserirImovel();
        testAtualizarImovel();
        testListarTodosImoveis();

        entityManager.close();
        entityManagerFactory.close();
    }

    private static void testInserirImovel() {
        entityManager.getTransaction().begin();

        TipoImovel tipoImovel = tipoImovelRepository.findById(1);
        Imovel imovel = new Imovel();
        imovel.setTipoImovel(tipoImovel);
        imovel.setLogradouro("Rua Teste, 123");
        imovel.setBairro("Centro");
        imovel.setCep("12345-678");
        imovel.setMetragem(100);
        imovel.setDormitorios(3);
        imovel.setSuites(1);
        imovel.setBanheiros(2);
        imovel.setVagasGaragem(2);
        imovel.setValorAluguelSugerido(new BigDecimal("1500.00"));
        imovel.setObs("Ótima localização");

        imovelRepository.save(imovel);
        entityManager.getTransaction().commit();
        System.out.println("Imóvel inserido com sucesso!");
    }

    private static void testAtualizarImovel() {
        entityManager.getTransaction().begin();
        Imovel imovel = imovelRepository.findById(1);
        imovel.setLogradouro("Rua Atualizada, 456");
        imovelRepository.save(imovel); // Correção: usar save para inserir ou atualizar
        entityManager.getTransaction().commit();
        System.out.println("Imóvel atualizado com sucesso!");
    }

    private static void testListarTodosImoveis() {
        List<Imovel> imoveis = imovelRepository.findAll();
        imoveis.forEach(imovel -> System.out.println(imovel.toString()));
    }
}
