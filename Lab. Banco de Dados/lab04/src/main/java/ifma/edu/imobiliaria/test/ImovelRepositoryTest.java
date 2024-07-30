package ifma.edu.imobiliaria.test;

import ifma.edu.imobiliaria.model.Imovel;
import ifma.edu.imobiliaria.model.TipoImovel;
import ifma.edu.imobiliaria.repository.ImovelRepository;
import ifma.edu.imobiliaria.repository.TipoImovelRepository;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.EntityManager;
import java.math.BigDecimal;

public class ImovelRepositoryTest {

    public static void main(String[] args) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("imobiliariaPU");
        EntityManager em = emf.createEntityManager();

        ImovelRepository imovelRepo = new ImovelRepository();
        imovelRepo.setEntityManager(em);

        TipoImovelRepository tipoImovelRepo = new TipoImovelRepository();
        tipoImovelRepo.setEntityManager(em);

        // Criar e salvar um TipoImovel
        TipoImovel tipoImovel = new TipoImovel();
        tipoImovel.setDescricao("Apartamento");
        tipoImovelRepo.save(tipoImovel);

        // Criar e salvar um Imovel
        Imovel imovel = new Imovel();
        imovel.setTipoImovel(tipoImovel);
        imovel.setLogradouro("Rua das Flores, 123");
        imovel.setBairro("Jardim das Rosas");
        imovel.setCep("12345-678");
        imovel.setMetragem(100);
        imovel.setDormitorios(3);
        imovel.setSuites(1);
        imovel.setBanheiros(2);
        imovel.setVagasGaragem(1);
        imovel.setValorAluguelSugerido(new BigDecimal("1500.00"));
        imovel.setObs("Próximo ao metrô");

        imovelRepo.save(imovel);

        // Listar todos os imóveis
        System.out.println("Todos os imóveis:");
        imovelRepo.findAll().forEach(System.out::println);

        em.close();
        emf.close();
    }
}
