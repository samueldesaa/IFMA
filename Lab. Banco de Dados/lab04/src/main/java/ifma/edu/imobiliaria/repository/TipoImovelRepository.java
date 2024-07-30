package ifma.edu.imobiliaria.repository;

import ifma.edu.imobiliaria.model.TipoImovel;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;
import java.util.List;

public class TipoImovelRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional
    public void save(TipoImovel tipoImovel) {
        if (tipoImovel.getId() == null) {
            entityManager.persist(tipoImovel);
        } else {
            entityManager.merge(tipoImovel);
        }
    }

    @Transactional
    public void delete(TipoImovel tipoImovel) {
        if (tipoImovel.getId() != null) {
            entityManager.remove(entityManager.merge(tipoImovel));
        }
    }

    public TipoImovel findById(Integer id) {
        return entityManager.find(TipoImovel.class, id);
    }

    public List<TipoImovel> findAll() {
        TypedQuery<TipoImovel> query = entityManager.createQuery("SELECT t FROM TipoImovel t", TipoImovel.class);
        return query.getResultList();
    }

    public void setEntityManager(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    public EntityManager getEntityManager() {
        return entityManager;
    }
}
