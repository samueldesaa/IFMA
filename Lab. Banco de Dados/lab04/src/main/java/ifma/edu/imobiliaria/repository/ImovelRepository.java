package ifma.edu.imobiliaria.repository;

import ifma.edu.imobiliaria.model.Imovel;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;

public class ImovelRepository {

    @PersistenceContext
    private EntityManager entityManager;

    public void save(Imovel imovel) {
        if (imovel.getId() == null) {
            entityManager.persist(imovel);
        } else {
            entityManager.merge(imovel);
        }
    }

    public Imovel findById(Integer id) {
        return entityManager.find(Imovel.class, id);
    }

    public List<Imovel> findAll() {
        TypedQuery<Imovel> query = entityManager.createQuery("SELECT i FROM Imovel i", Imovel.class);
        return query.getResultList();
    }

    public void setEntityManager(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    public EntityManager getEntityManager() {
        return entityManager;
    }
}
