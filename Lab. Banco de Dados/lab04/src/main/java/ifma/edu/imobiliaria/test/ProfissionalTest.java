package ifma.edu.imobiliaria.test;

import ifma.edu.imobiliaria.model.Profissional;
import ifma.edu.imobiliaria.repository.ProfissionalRepository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.math.BigDecimal;
import java.util.List;

public class ProfissionalTest {

    private static EntityManagerFactory entityManagerFactory;
    private static EntityManager entityManager;
    private static ProfissionalRepository profissionalRepository;

    public static void main(String[] args) {
        entityManagerFactory = Persistence.createEntityManagerFactory("imobiliariaPU");
        entityManager = entityManagerFactory.createEntityManager();

        profissionalRepository = new ProfissionalRepository();
        profissionalRepository.setEntityManager(entityManager);

        testInserirProfissional();
        testAtualizarProfissional();
        testListarTodosProfissionais();

        entityManager.close();
        entityManagerFactory.close();
    }

    private static void testInserirProfissional() {
        Profissional profissional = new Profissional();
        profissional.setNome("João da Silva");
        profissional.setProfissao("Eletricista");
        profissional.setTelefone1("123456789");
        profissional.setTelefone2("987654321");
        profissional.setValorHora(new BigDecimal("50.00"));
        profissional.setObs("Profissional experiente.");

        profissionalRepository.save(profissional);
        System.out.println("Profissional inserido com sucesso!");
    }

    private static void testAtualizarProfissional() {
        Profissional profissional = profissionalRepository.findById(1);
        if (profissional != null) {
            profissional.setValorHora(new BigDecimal("55.00"));
            profissionalRepository.save(profissional);
            System.out.println("Profissional atualizado com sucesso!");
        } else {
            System.out.println("Profissional não encontrado.");
        }
    }

    private static void testListarTodosProfissionais() {
        List<Profissional> profissionais = profissionalRepository.findAll();
        if (profissionais != null && !profissionais.isEmpty()) {
            profissionais.forEach(profissional -> System.out.println(profissional.toString()));
        } else {
            System.out.println("Nenhum profissional encontrado.");
        }
    }
}
