package ifma.edu.imobiliaria.repository;

import ifma.edu.imobiliaria.model.ServicoImovel;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;
import java.util.List;

public class ServicoImovelRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional
    public void save(ServicoImovel servicoImovel) {
        if (servicoImovel.getId() == null) {
            entityManager.persist(servicoImovel);
        } else {
            entityManager.merge(servicoImovel);
        }
    }

    @Transactional
    public void delete(ServicoImovel servicoImovel) {
        if (servicoImovel.getId() != null) {
            entityManager.remove(entityManager.merge(servicoImovel));
        }
    }

    public ServicoImovel findById(Integer id) {
        return entityManager.find(ServicoImovel.class, id);
    }

    public List<ServicoImovel> findAll() {
        TypedQuery<ServicoImovel> query = entityManager.createQuery("SELECT s FROM ServicoImovel s", ServicoImovel.class);
        return query.getResultList();
    }

    public void setEntityManager(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    public EntityManager getEntityManager() {
        return entityManager;
    }
}
