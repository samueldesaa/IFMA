package ifma.edu.imobiliaria.test;

import ifma.edu.imobiliaria.model.ServicoImovel;
import ifma.edu.imobiliaria.model.Imovel;
import ifma.edu.imobiliaria.model.Profissional;
import ifma.edu.imobiliaria.repository.ServicoImovelRepository;
import ifma.edu.imobiliaria.repository.ImovelRepository;
import ifma.edu.imobiliaria.repository.ProfissionalRepository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class ServicoImovelTest {

    private static EntityManagerFactory entityManagerFactory;
    private static EntityManager entityManager;
    private static ServicoImovelRepository servicoImovelRepository;
    private static ImovelRepository imovelRepository;
    private static ProfissionalRepository profissionalRepository;

    public static void main(String[] args) {
        entityManagerFactory = Persistence.createEntityManagerFactory("imobiliariaPU");
        entityManager = entityManagerFactory.createEntityManager();

        servicoImovelRepository = new ServicoImovelRepository();
        imovelRepository = new ImovelRepository();
        profissionalRepository = new ProfissionalRepository();

        servicoImovelRepository.setEntityManager(entityManager);
        imovelRepository.setEntityManager(entityManager);
        profissionalRepository.setEntityManager(entityManager);

        testInserirServicoImovel();
        testAtualizarServicoImovel();
        testListarTodosServicosImovel();

        entityManager.close();
        entityManagerFactory.close();
    }

    private static void testInserirServicoImovel() {
        Imovel imovel = imovelRepository.findById(1);
        Profissional profissional = profissionalRepository.findById(1);

        if (imovel != null && profissional != null) {
            ServicoImovel servicoImovel = new ServicoImovel();
            servicoImovel.setImovel(imovel);
            servicoImovel.setProfissional(profissional);
            servicoImovel.setDataServico(new Date());
            servicoImovel.setValorTotal(new BigDecimal("500.00"));
            servicoImovel.setObs("Serviço de manutenção.");

            servicoImovelRepository.save(servicoImovel);
            System.out.println("Serviço de imóvel inserido com sucesso!");
        } else {
            System.out.println("Imóvel ou profissional não encontrado.");
        }
    }

    private static void testAtualizarServicoImovel() {
        ServicoImovel servicoImovel = servicoImovelRepository.findById(1);
        if (servicoImovel != null) {
            servicoImovel.setValorTotal(new BigDecimal("600.00"));
            servicoImovelRepository.save(servicoImovel);
            System.out.println("Serviço de imóvel atualizado com sucesso!");
        } else {
            System.out.println("Serviço de imóvel não encontrado.");
        }
    }

    private static void testListarTodosServicosImovel() {
        List<ServicoImovel> servicos = servicoImovelRepository.findAll();
        if (servicos != null && !servicos.isEmpty()) {
            servicos.forEach(servico -> System.out.println(servico.toString()));
        } else {
            System.out.println("Nenhum serviço de imóvel encontrado.");
        }
    }
}
